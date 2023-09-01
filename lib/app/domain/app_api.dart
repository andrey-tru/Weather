import 'package:dio/dio.dart';

abstract class AppApi {
  Future<Response<Map<String, dynamic>>> forecast({
    required double lat,
    required double lon,
  });
}
