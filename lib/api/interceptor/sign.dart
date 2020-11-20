import 'dart:collection';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutterpackagetest/base/base_info.dart';
import 'package:flutterpackagetest/env/config.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';
import "package:pointycastle/export.dart";

// TODO 做成独立的Package，供多个app使用
/// 签名拦截器
class SignInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {

    // 如果非自有接口，则不进行验签
    if ((options.path.startsWith("http://") || options.path.startsWith("https://")) && !options.path.startsWith(Config.apiGateway)) {
      return super.onRequest(options);
    }

    // 处理验签所需header
    Map<String, String> headers = {};
    headers["appId"] = Config.appId;
    headers["clientType"] = Config.clientType;
    headers["clientVersion"] = _getClientVersion();

    // 根据是否存在token，决定签名方式（RSA or MD5）
    String token = _getUserToken();
    String signType = "RSA";
    if (options.headers["is_rsa"]!=true && token.isNotEmpty) {
      signType = "MD5";
    }

    if(options.headers.containsKey("is_rsa")){
      options.headers.remove("is_rsa");
    }
    headers["signType"] = signType;

    // 获取当前时间
    headers["timestamp"] = new DateTime.now().millisecondsSinceEpoch.toString();
    // 扩展的请求头参数

    headers["extra"] = convert.jsonEncode(options.extra);

    // 根据签名方式，计算签名
    String signResult = "";
    if (signType == "RSA") {
      signResult = this._generateSignRSA(options.path, headers, options.queryParameters, options.data);
    } else if (signType == "MD5") {
      headers["userId"] = _getUserId();
      signResult = this._generateSignMD5(options.path, token, headers, options.queryParameters, options.data);
    }
    headers["sign"] = signResult;

    options.headers.addAll(headers);

    return super.onRequest(options);
  }

  /// 获取当前登录用户的令牌
  String _getUserToken() {
    String token = AsrBaseInfo.getToken();
    // TODO 从存储中获取用户令牌
    return token!=null?token.trim():'';// 若token不存在，应确保返回的字符串不为null
  }
  /// 获取当前登录用户的标识
  String _getUserId() {
    // TODO 从存储中获取用户标识
    int userId = AsrBaseInfo.getUserId();
    return userId!=null?userId.toString():'';
  }
  /// 获取当前APP版本号
  String _getClientVersion() {
    // TODO 从常量中获取APP版本号
    String version = AsrBaseInfo.getVersionName();
    return version;
  }

  /// 生成RSA签名
  String _generateSignRSA(String path, Map<String, String> headers, Map<String, dynamic> queryParams, dynamic bodyParams) {

    // 组成待签名字符串
    String tobeSignStr = path + _handleSignParam(queryParams, bodyParams) + _handleSignHeader(headers);

    // 使用RSA私钥计算签名
    var rsaHelper = new RsaKeyHelper();
    var privateKey = rsaHelper.parsePrivateKeyFromPem(Config.privateKey);

    var signer = RSASigner(MD5Digest(), "06082a864886f70d0205");
    signer.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));
    String sign = convert.base64Encode(signer.generateSignature(rsaHelper.createUint8ListFromString(tobeSignStr)).bytes);

    return sign;
  }
  /// 生成MD5签名
  String _generateSignMD5(String path, String token, Map<String, String> headers, Map<String, dynamic> queryParams, dynamic bodyParams) {
    // 组成待签名字符串
    String tobeSignStr = path + _handleSignParam(queryParams, bodyParams) + token + _handleSignHeader(headers);

    // 使用MD5算法计算签名
    var content = new convert.Utf8Encoder().convert(tobeSignStr);
    var digest = md5.convert(content);
    String sign = hex.encode(digest.bytes);
    return sign;
  }
  /// 对需要签名的query和body参数进行排序，并拼接为一个字符串
  String _handleSignParam(Map<String, dynamic> queryParams, dynamic bodyParams) {
    String result = "";

    var treeMap = SplayTreeMap<String, dynamic>.from(queryParams);
    if (bodyParams != null) {
      treeMap.addAll(bodyParams);
    }

    for (var key in treeMap.keys) {
      // value若为json数组，则不参与签名计算
      var _value = treeMap[key];
      if (_value is List || _value == null || _value == "" || _value == "null") {
        continue;
      }

      result += key;
      if (_value is Map) {
        result += convert.json.encode(_value);
      } else {
        result += _value.toString();
      }
    }

    return result;
  }
  /// 对需要签名的请求头参数进行排序，并拼接为一个字符串
  String _handleSignHeader(Map<String, String> headers) {
    String result = "";

    var treeMap = SplayTreeMap<String, dynamic>.from(headers);
    for (var key in treeMap.keys) {
      result += key;
      result += treeMap[key].toString();
    }

    return result;
  }
}
