import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/app/app.dart';

@Singleton(as: AppApi)
class DioAppApi implements AppApi {
  DioAppApi(AppConfig appConfig) {
    final BaseOptions options = BaseOptions(
      baseUrl: appConfig.baseUrl,
      connectTimeout: const Duration(seconds: 15),
    );

    dio = Dio(options);
  }

  late final Dio dio;

  @override
  Future<Response<Map<String, dynamic>>> forecast({
    required String lat,
    required String lon,
  }) async {
    return dio.get(
    // ignore: lines_longer_than_80_chars
      'forecast?lat=$lat&lon=$lon&lang=ru&units=metric&appid=${dotenv.env['WEATHER_KEY']}',
    );
  }
}
