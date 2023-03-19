import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fakestoreapi.com/users/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    String url,
    Map<String, dynamic> query,
    String lang = 'ar',
    String token,
  }) async {
    dio.options.headers = {
        'lang': lang,
        'Authorization': token,
      };
    return await dio.get(url,
        queryParameters: query,
        );
  }

  static Future<Response> postData({
    String url,
    Map<String, dynamic> query,
    Map<String, dynamic> data,
    String lang = 'ar',
    String token,
  }) async {
    dio.options.headers = {
        'lang': lang,
        'Authorization': token,
      };
    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
