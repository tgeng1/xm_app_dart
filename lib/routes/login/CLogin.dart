import 'package:flutter/material.dart';
import 'package:xm_app_dart/api/loginServiceApi.dart';
import 'package:xm_app_dart/api/httpCode/index.dart';

class LoginApi {
  // User login
  static Future userLogin(dataInfo) async {
    try {
      final result = await LoginServiceApi.userLogin(
          dataInfo['phone'], dataInfo['password']);
      switch (result['code']) {
        case HttpCode.CODE_SUCCESS:
          return {
            'code': 'success',
            'msg': '登录成功',
            'payload': result['payload']
          };
        case HttpCode.CODE_INVALID_USERNAME_OR_PASSWORD:
          return {'code': 'error', 'msg': '用户名或密码错误!'};
        case HttpCode.CODE_USER_HAS_BEEN_LOCKED:
          return {'code': 'error', 'msg': '用户被锁定!'};
//        case HttpCode.LOGIN_WITHOUT_PERMISSION:
//          return {
//            'code': 'error',
//            'msg': '该用户没有权限登录！'
//          };
        default:
          return {'code': 'error', 'msg': '服务器错误，请稍后重试!'};
      }
    } catch (err) {
      if (err['code'] == HttpCode.CODE_NO_NETWORK) {
        return {'code': 'error', 'msg': '网络异常，请稍后再试!'};
//      } else if (err.code == HttpCode.LOGIN_WITHOUT_PERMISSION) {
//        return {
//          'code': 'error',
//          'msg': "该用户没有权限登录！"
//        };
      } else {
        return {'code': 'error', 'msg': '服务器错误，请稍后再试!'};
      }
    }
  }

  // Get user access
  static Future getUserAccess() async {
    try {
      final result = await LoginServiceApi.getUserAccess();
      switch (result['code']) {
        case HttpCode.CODE_SUCCESS:
          return {
            'code': 'success',
            'msg': '获取用户权限成功',
            'payload': result['payload']
          };
        default:
          return {'code': 'error', 'msg': '服务器错误，请稍后再试!'};
      }
    } catch (err) {
      if (err['code'] == HttpCode.CODE_NO_NETWORK) {
        return {'code': 'error', 'msg': '网络异常，请稍后再试!'};
      } else {
        return {'code': 'error', 'msg': '服务器错误，请稍后再试!'};
      }
    }
  }

  // Get user access
  static Future getConfig() async {
    try {
      final result = await LoginServiceApi.getConfig();
      switch (result['code']) {
        case HttpCode.CODE_SUCCESS:
          return {
            'code': 'success',
            'msg': '获取基础权限成功',
            'payload': result['payload']
          };
        default:
          return {'code': 'error', 'msg': '服务器错误，请稍后重试!'};
      }
    } catch (err) {
      if (err['code'] == HttpCode.CODE_NO_NETWORK) {
        return {'code': 'error', 'msg': '网络异常，请稍后再试!'};
      } else {
        return {'code': 'error', 'msg': '服务器错误，请稍后再试!'};
      }
    }
  }
}
