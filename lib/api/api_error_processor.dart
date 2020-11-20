import 'package:dio/dio.dart';

import 'response_data.dart';

class ApiErrorProcessor {

  // TODO 根据错误类型，进行统一的异常处理
  static ResponseData processError(DioError e) {
    String errorMsg;
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      errorMsg = "连接超时";
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      errorMsg = "请求超时";
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      errorMsg = "响应超时";
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      errorMsg = "出现异常";
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      errorMsg = "请求取消";
    } else if (e.type == DioErrorType.DEFAULT) {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      if (e.error != null) {
        if (e.error.osError.errorCode == 61) {
          errorMsg = "连接被拒绝";//Connection refused
        }
      } else {
        errorMsg = "未知错误";
      }
    } else {
      errorMsg = "未知错误";
    }

    return ResponseData(false, -1, errorMsg, null, path: e.request.path);
  }
}
