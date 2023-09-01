import 'package:weather/feature/feature.dart';

abstract class MainRepository {
  Future<(List<WeatherModel>, String)> forecast({
    required double lat,
    required double lon,
  });
}
