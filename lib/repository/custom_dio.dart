import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:listacep/repository/custom_dio_interceptor.dart';

class CustomDio {
  final _dio = Dio();

  Dio get dio => _dio;

  CustomDio() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BACK4APPBASEURL");
    _dio.interceptors.add(CustomDioInterceptor());
  }
}