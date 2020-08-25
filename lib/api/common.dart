import 'package:dio/dio.dart';
import 'package:xm_app_dart/utils/global.dart';

class HttpUtil {
  Dio dio;
  static int uploadRestApiTimeOut = 12000;
  static String token;
  static final REST_API_PATH = {
    "DEV": "https://dev-nd.jsure.com/xm-app-backend",
    "TEST": "https://test-nd.jsure.com/xm-app-backend",
    "PRO": "https://nd.jsure.com/xm-app-backend",
    "CLONE": "https://clone-nd.jsure.com/xm-app-backend"
  };
  static HttpUtil instance;
  static BaseOptions options;
  static Response response;

  CancelToken _cancelToken = new CancelToken();
  static HttpUtil getInstance() {
    if (instance == null) instance = new HttpUtil();
    return instance;
  }

  HttpUtil() {
    String restApiBasePath = REST_API_PATH[Global.env];
    token ??= Global.token;
    options = new BaseOptions(
        baseUrl: restApiBasePath,
        connectTimeout: uploadRestApiTimeOut,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'x-access-token': token
        },
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.json);
    dio = new Dio(options);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      return options;
    }, onResponse: (Response response) async {
      return response;
    }, onError: (DioError err) async {
      if (err.response.statusCode == 401) {
        Global.signOutAboutNotAccess();
        return null;
      } else {
        return err;
      }
    }));
  }

  Future<Map<String, dynamic>> call(method, url, isToken,
      {data, options}) async {
    if (method == 'get') {
      dio.options.headers = {
        'Accept': 'application/json',
        'x-access-token': token
      };
    }
    try {
      if (method == 'get') {
        response = await dio.get<Map<String, dynamic>>(url,
            options: options, cancelToken: _cancelToken);
      } else if (method == 'post') {
        response = await dio.post<Map<String, dynamic>>(url,
            data: data, options: options, cancelToken: _cancelToken);
      } else if (method == 'put') {
        response = await dio.put<Map<String, dynamic>>(url,
            data: data, options: options, cancelToken: _cancelToken);
      } else if (method == 'delete') {
        response = await dio.delete<Map<String, dynamic>>(url,
            options: options, cancelToken: _cancelToken);
      } else if (method == 'patch') {
        response = await dio.patch<Map<String, dynamic>>(url,
            data: data, options: options, cancelToken: _cancelToken);
      }
      return response.data;
    } on DioError catch (err) {
      if (err.response != null) {
        return {'errInfo': err.response};
      } else {
        return {'msg': err.message, 'req': err.request};
      }
    }
  }
}
