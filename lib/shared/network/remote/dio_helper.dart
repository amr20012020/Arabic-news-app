
import 'package:dio/dio.dart';
class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        //base url: https://newsapi.org/
        // method: v2/top-headlines?
        // queries: country=eg&category=sports&apiKey=afe009d8d0d944d2936f28de8b92bd7a
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }
  static Future<Response> getData(
      {required Map<String, dynamic> queries,required String path}) async {
    return await dio.get(
      path,
      queryParameters: queries,
    );
  }
}