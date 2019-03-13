import 'dart:_http';

import 'package:dio/dio.dart';
import 'net.dart';

class DioConfig {
  Dio _dio;

  DioConfig._internal() {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
    _dio.options.contentType = ContentType.json;
  }

  factory DioConfig() => DioConfig._internal();

  get dio {
    return _dio;
  }
}
