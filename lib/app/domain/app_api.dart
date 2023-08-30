import 'package:dio/dio.dart';

abstract class AppApi {
  Future<Response<Map<String, dynamic>>> forecast({
    required String lat,
    required String lon,
  });
}
