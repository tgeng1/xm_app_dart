import 'package:flutter/material.dart';
import 'package:xm_app_dart/app.dart';
import 'commonUtils.dart';
import 'package:xm_app_dart/components/customAlertDialog.dart';
import 'package:xm_app_dart/routes/login/Login.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Global {
  static String env;
  static String token;
  static String userId;
  static String version = '3.2';

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    env = await LocalStorageUtil.getInfo('env') ?? 'DEV';
    token ??= await LocalStorageUtil.getInfo('token');
  }

  static Future<bool> updateUserData(tokenValue, userIdValue) async {
    var updateToken = await LocalStorageUtil.saveInfo('token', tokenValue);
    var updateUserId = await LocalStorageUtil.saveInfo('userId', userIdValue);
    if (updateUserId && updateToken) {
      token = tokenValue;
      userId = userIdValue;
    }
    return updateUserId && updateToken;
  }

  static setConfig(configInfo) async {
    await LocalStorageUtil.writeJson(configInfo);
  }

  static setAccessRight(accessRightList) async {
    await LocalStorageUtil.saveList('accessRight', accessRightList);
  }

  static Future signOut() async {
    await LocalStorageUtil.removeInfo('token');
    await LocalStorageUtil.removeInfo('accessRight');
    token = null;
    navigatorKey.currentState.pushAndRemoveUntil(
        new MaterialPageRoute(builder: (BuildContext context) => new Login()),
        (route) => route == null);
  }

  static void showToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void signOutAboutNotAccess() {
    CustomAlertDialog().showCustomDialog(
        context: navigatorKey.currentState.overlay.context,
        title: '提示',
        onOk: signOut,
        content: '权限更改，请退出重新登陆');
  }
}
