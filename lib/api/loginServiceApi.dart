import 'common.dart';

class LoginServiceApi {
  // User login
  // String phone
  // String password
  static userLogin(phone, password) async {
    const api = '/userapi/users/authenticate';
    Map<String, dynamic> body = {
      "phone": phone.trim(),
      "password": password.trim()
    };
    return await HttpUtil().call('post', api, false, data: body);
  }

  // Get user access
  static getUserAccess() async {
    const api = '/userapi/users/access?kind=APP';
    return await HttpUtil().call('get', api, true);
  }

  // Get config
  static getConfig() async {
    const api = '/statisticalapi/config/map';
    return await HttpUtil().call('get', api, true);
  }
}
