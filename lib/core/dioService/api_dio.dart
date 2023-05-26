import 'package:dio/dio.dart';

import 'api_string_const.dart';

abstract class ApiDio {
  static final _dio = _getDio();
  static Dio get instant => _dio;
  static Dio _getDio() {
    final baseOption = BaseOptions(
      baseUrl: ApiStringConst.BASE_URL,
    );
    return Dio(baseOption);
  }
}
