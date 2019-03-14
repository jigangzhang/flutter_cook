import 'dart:io';

import 'package:dio/dio.dart';
import 'net.dart';

class DioConfig {
  static const int TIMEOUT_DEFAULT = 8000;
  Dio _dio;

  DioConfig._internal() {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
    _dio.options.contentType = ContentType.json;
    _dio.options.responseType = ResponseType.json;
    _dio.options.sendTimeout = TIMEOUT_DEFAULT;
    _dio.options.receiveTimeout = TIMEOUT_DEFAULT;
    _dio.options.connectTimeout = TIMEOUT_DEFAULT;
  }

  static DioConfig singleton = DioConfig._internal();

  factory DioConfig() => singleton;

  Dio get dio {
    return _dio;
  }
}
