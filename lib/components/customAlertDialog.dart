import 'package:flutter/material.dart';

class CustomAlertDialog {
  // final String title;
  // final String content;
  // final onOk;
  // final onCancel;
  // final BuildContext context;
  // final maskClosable;
  // CustomAlertDialog({this.maskClosable, this.context, this.title, this.onOk, this.content, this.onCancel});

  Future<bool>showCustomDialog({maskClosable, context, title, onOk, content, onCancel}) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: maskClosable == true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                onCancel != null ? onCancel() : Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('确定'),
              onPressed: () {
                onOk != null ?onOk() : Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
}