// ignore_for_file: avoid_dynamic_calls

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class ErrorModel {
  ErrorModel({
    required this.message,
    this.errorMessage,
    this.error,
  });

  factory ErrorModel.fromException(dynamic error) {
    if (error is ErrorModel) return error;
    if (error is DioException) {
      try {
        return ErrorModel(
          message:
              error.response?.data['message'].toString() ?? tr('error.unknow'),
          errorMessage:
              error.response?.data['error'].toString() ?? tr('error.unknow'),
          error: error,
        );
      } catch (_) {
        return ErrorModel(message: tr('error.unknow'));
      }
    }
    return ErrorModel(message: tr('error.unknow'));
  }

  final String message;
  final String? errorMessage;
  final dynamic error;
}
