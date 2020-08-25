import 'package:flutter/material.dart';

class CustomAlertDialog {
  Future<bool> showCustomDialog(
      {maskClosable, context, title, onOk, content, onCancel}) {
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
                  onOk != null ? onOk() : Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
