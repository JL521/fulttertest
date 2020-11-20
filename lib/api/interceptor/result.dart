import 'package:dio/dio.dart';

import '../response_data.dart';

/// 动态接口调用的返回结果处理
/// 非正常的返回均在此拦截器中处理
/// 使用时：var data = Api.get(xxx);
/// 根据接口返回参数的类型直接使用
class ResultInterceptor extends InterceptorsWrapper {

  @override
  onResponse(Response response) async {
    // 如果是非json格式的返回结果，则直接跳过拦截器
    if (response.request.responseType != ResponseType.json) {
      return super.onResponse(response);
    }

    print(response.toString());

    int httpStatus = response.statusCode;
    String requestPath = response.request.path;

    int returnCode = -1;
    String codeMsg = response.data["msg"];
    if (response.data != null) {
      returnCode = response.data["code"];
    }

    // 如果HTTP == 200 & code == 0时，success为true
    bool success = false;
    if (httpStatus == 200) {
      if (returnCode == 0) {
        success = true;
      }
    } else {
      // TODO 对HTTP错误结果进行统一处理
      if (httpStatus == 404) {
        //Toast.show(msg: response.data["msg"]);
      }
      return new ResponseData(success, httpStatus, response.statusMessage, null, path: requestPath);
    }

    // 对服务端返回结果错误的情况进行统一处理
    if (!success) {

      if (returnCode == 10061) {
        //TODO 若是签名类的错误，则引导用户重新登录
      }
      return new ResponseData(success, returnCode, codeMsg, response.data["data"], path: requestPath);
    }

    // 直接返回response.data，其它都在这个拦截器里做
    return new ResponseData(success, returnCode, codeMsg, response.data["data"], path: requestPath);
  }
}
