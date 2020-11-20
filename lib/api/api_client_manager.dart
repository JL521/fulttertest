import 'package:dio/dio.dart';
import 'package:flutterpackagetest/env/config.dart';
import 'interceptor/result.dart';

import 'interceptor/sign.dart';

/// 基于自定义验签规则的，接口请求工具类
class ApiClientManager {
  factory ApiClientManager() =>_getInstance();
  static ApiClientManager get instance => _getInstance();
  static ApiClientManager _instance;
  Dio _dio;
  Dio dio() {
    return _dio;
  }

  ApiClientManager._internal() {
    // 初始化
    if (null == _dio) {
      _dio = Dio();

      _dio.options.baseUrl = Config.apiGateway;
      _dio.options.connectTimeout = 1000 * 10;
      _dio.options.receiveTimeout = 1000 * 5;

      // 添加签名拦截器
      _dio.interceptors.add(new SignInterceptor());
      _dio.interceptors.add(new LogInterceptor());
      _dio.interceptors.add(new ResultInterceptor());
    }
  }
  static ApiClientManager _getInstance() {
    if (_instance == null) {
      _instance = new ApiClientManager._internal();
    }
    return _instance;
  }

  // 全部使用async，返回Future（统一编程模型，有利于用户体验，不会被网络请求卡住）？
  // 还是同步、异步都支持？
}
