import 'package:weather/feature/feature.dart';

abstract class MainRepository {
  Future<List<WeatherModel>> forecast({
    required String lat,
    required String lon,
  });
}
