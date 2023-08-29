import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/app/app.dart';

@Singleton()
class DioContainer {
  DioContainer(AppConfig appConfig) {
    final BaseOptions options = BaseOptions(
      baseUrl: appConfig.baseUrl,
      connectTimeout: const Duration(seconds: 15),
    );

    dio = Dio(options);
  }
  late final Dio dio;

  void addInterceptor(Interceptor interceptor) {
    if (dio.interceptors.contains(interceptor)) {
      dio.interceptors.remove(interceptor);
    }

    deletenterceptor(interceptor.runtimeType);

    dio.interceptors.add(interceptor);
  }

  void deletenterceptor(Type type) {
    dio.interceptors
        .removeWhere((Interceptor element) => element.runtimeType == type);
  }
}
