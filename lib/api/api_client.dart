import 'package:dio/dio.dart';
import 'package:flutterpackagetest/base/base_info.dart';
import 'api_client_manager.dart';
import 'api_error_processor.dart';

import 'response_data.dart';

class ApiClient {
  /// get method
  static Future<ResponseData> get(
    String path, {
    Map<String, dynamic> queryParameters, // Dio参数
    Options options, // Dio参数
    CancelToken cancelToken, // Dio参数
    ProgressCallback onReceiveProgress, // Dio参数
    bool isThrowError = false, // 用于控制是否由自己处理异常
  }) async {
    Response response;
    try {
      if(!(options!=null&&options.headers!=null&&options.headers["is_rsa"]==true)&& _isUserToken() == false){
        return ResponseData(false, -11, "", null, path: path);
      }
      response = await ApiClientManager.instance.dio().get(path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
    } on DioError catch (e) {
      if (isThrowError) {
        throw e;
      }
      return ApiErrorProcessor.processError(e);
    }
    return response.data;
  }

  /// post method
  static Future<ResponseData> post(
    String path, {
    data, // Dio参数
    Map<String, dynamic> queryParameters, // Dio参数
    Options options, // Dio参数
    CancelToken cancelToken, // Dio参数
    ProgressCallback onSendProgress, // Dio参数
    ProgressCallback onReceiveProgress, // Dio参数
    bool isThrowError = false, // 用于控制是否由自己处理异常
  }) async {
    Response response;
    try {
      if(!(options!=null&&options.headers!=null&&options.headers["is_rsa"]==true)&& _isUserToken() == false){
        return ResponseData(false, -11, "", null, path: path);
      }
      response = await ApiClientManager.instance.dio().post(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
    } on DioError catch (e) {
      if (isThrowError) {
        throw e;
      }
      return ApiErrorProcessor.processError(e);
    }
    print("返回的最初数据" + response.toString());
    return response.data;
  }

  /// put method
  static Future<ResponseData> put(
    String path, {
    data, // Dio参数
    Map<String, dynamic> queryParameters, // Dio参数
    Options options, // Dio参数
    CancelToken cancelToken, // Dio参数
    ProgressCallback onSendProgress, // Dio参数
    ProgressCallback onReceiveProgress, // Dio参数
    bool isThrowError = false, // 用于控制是否由自己处理异常
  }) async {
    Response response;
    try {
      if(!(options!=null&&options.headers!=null&&options.headers["is_rsa"]==true)&& _isUserToken() == false){
        return ResponseData(false, -11, "", null, path: path);
      }
      response = await ApiClientManager.instance.dio().put(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
    } on DioError catch (e) {
      if (isThrowError) {
        throw e;
      }
      return ApiErrorProcessor.processError(e);
    }
    return response.data;
  }

  /// delete method
  static Future<ResponseData> delete(
    String path, {
//    data, // Dio参数
    Map<String, dynamic> queryParameters, // Dio参数
    Options options, // Dio参数
    CancelToken cancelToken, // Dio参数
    bool isThrowError = false, // 用于控制是否由自己处理异常
  }) async {
    Response response;
    try {
      if(!(options!=null&&options.headers!=null&&options.headers["is_rsa"]==true)&& _isUserToken() == false){
        return ResponseData(false, -11, "", null, path: path);
      }
      response = await ApiClientManager.instance.dio().delete(path,
//          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken);
    } on DioError catch (e) {
      if (isThrowError) {
        throw e;
      }
      return ApiErrorProcessor.processError(e);
    }
    return response.data;
  }

  /// download file
  static Future<ResponseData> download(
    String urlPath,
    savePath, {
    ProgressCallback onReceiveProgress, // Dio参数
    Map<String, dynamic> queryParameters, // Dio参数
    CancelToken cancelToken, // Dio参数
    data, // Dio参数
    RequestOptions options, // Dio参数
    bool isThrowError = false, // 用于控制是否由自己处理异常
  }) async {
    if (options == null) {
      // 默认数据接收超时时间为：60秒
      options = new RequestOptions();
      options.receiveTimeout = 60 * 1000;
    }
    Response response;
    try {
      response = await ApiClientManager.instance.dio().download(
          urlPath, savePath,
          onReceiveProgress: onReceiveProgress,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          data: data,
          options: options);
    } on DioError catch (e) {
      if (isThrowError) {
        throw e;
      }
      return ApiErrorProcessor.processError(e);
    }
    if (response.data is ResponseBody) {
      ResponseBody responseBody = response.data;
      if (responseBody.statusCode == 200) {
        return new ResponseData(true, 0, "下载完成", responseBody.extra, path: urlPath);
      } else {
        return new ResponseData(false, -1, "下载失败", responseBody.extra, path: urlPath);
      }
    }
    return response.data;
  }
}
/// 判断当前是否有token值
bool _isUserToken() {
  String token = AsrBaseInfo.getToken();
  // TODO 从存储中获取用户令牌
  return token!=null?(token.trim()!=""?true:false):false;// 若token不存在，应确保返回的字符串不为null
}