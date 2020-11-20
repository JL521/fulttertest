import 'package:flutter/material.dart';

// 普通提示
void showToast(
  String text, [Map position]) {
}

// 自定义的提示框
class AlertWidget extends Dialog {
  String title = '';
  String message = '';
  String confirm = '确定';
  VoidCallback confirmCallback;
  VoidCallback cancelCallback;

  AlertWidget(
      {this.title,
      this.message,
      this.cancelCallback,
      this.confirmCallback,
      this.confirm});
  @override
  Widget build(BuildContext context) {
    return Material(
//        type: MaterialType.transparency,
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Center(
        child: Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(message),
              SizedBox(
                height: 25,
              ),
              Divider(
                height: 1,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: FlatButton(
                            child: Text('取消',
                                style: TextStyle(color: Color(0xff999999))),
                            onPressed: cancelCallback == null
                                ? () {
                                    Navigator.pop(context);
                                  }
                                : cancelCallback,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 1, color: Color(0xffEFEFF4))),
                          ),
                        )),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        child: Text(
                          confirm,
                          style: TextStyle(color: Color(0xffFF3000)),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          confirmCallback();
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void showConfirmDialog(
    BuildContext context, String content, Function confirmCallback) {
  showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {},
      barrierColor: Colors.grey.withOpacity(.4),
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: Duration(milliseconds: 125),
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
            scale: anim1.value,
            child: Opacity(
                opacity: anim1.value,
                child: AlertWidget(
                  title: '',
                  message: content,
                  confirm: '确定',
                  confirmCallback: confirmCallback,
                )));
      });
}
