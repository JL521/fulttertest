import 'package:flutter/cupertino.dart';
import 'package:flutterpackagetest/base/toast.dart';

class ResponseData<T> {
  bool success;
  int code;
  String msg;
  T data;

  // 用于多接口并发调用时，区分List中的返回结果是哪个接口请求的
  String path;

  ResponseData(this.success, this.code, this.msg, this.data, {this.path});

  static ResponseData<T> createFrom<T>(ResponseData responseData, T data) {
    if(responseData.code == 10108 || responseData.code == 10103){
      if(responseData.path != "/user/app/v2/teacher/self-info"){
        showToast("用户登录失效，请重新登录！");
        //if(ModalRoute.of(AsrRouter.navigatorKey.currentState.context)!=null){
        //if(ModalRoute.of(AsrRouter.navigatorKey.currentState.context).settings.name != "login"){

      }

    }else if(responseData.code == -11 ) {//未发送请求
      //print('-11==========未发送请求');
    }else if(responseData.code != 0&&responseData.msg!=null){
        showToast(responseData.msg);
    };
    return new ResponseData(responseData.success, responseData.code, responseData.msg, data, path: responseData.path);
  }
}
