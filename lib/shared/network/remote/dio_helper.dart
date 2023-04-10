import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fakestoreapi.com/users/',
        receiveDataWhenStatusError: true,
        // We hide the header coz we added it below in the get & post
        // headers: {
        //   'Content-Type': 'application/json',
        // }
      ),
    );
  }

  static Future<Response> getData({
    String url,
    Map<String, dynamic> query,
    String lang = 'en',
    String token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token??'',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    String url,
    Map<String, dynamic> query,
    Map<String, dynamic> data,
    String lang = 'en',
    String token,
  }) async {
    dio.options.headers = {
        'Content-Type': 'application/json',
        'lang': lang,
        'Authorization': token??'',
      };
    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
