// ignore_for_file: avoid_dynamic_calls

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/app/app.dart';
import 'package:weather/feature/feature.dart';
import 'package:weather/feature/main/domain/models/weather_list/weather_list.dart';

@Injectable(as: MainRepository)
@prod
class NetworkMainRepository implements MainRepository {
  NetworkMainRepository(this.api);

  final AppApi api;

  @override
  Future<(List<WeatherModel>, String)> forecast({
    required double lat,
    required double lon,
  }) async {
    try {
      final Response<Map<String, dynamic>> response =
          await api.forecast(lat: lat, lon: lon);

      final WeatherListModel weatherListModel =
          WeatherListModel.fromJson(response.data!);

      final List<WeatherModel> weatherList =
          weatherListModel.list.map<WeatherModel>((Map<String, dynamic> e) {
        e['temp'] = e['main']['temp'];
        e['tempMax'] = e['main']['temp_max'];
        e['tempMin'] = e['main']['temp_min'];
        e['humidity'] = e['main']['humidity'];
        e['description'] = e['weather'][0]['description'];
        e['iconId'] = e['weather'][0]['id'];
        e['windSpeed'] = e['wind']['speed'];
        e['windDeg'] = e['wind']['deg'];
        return WeatherModel.fromJson(e);
      }).toList();

      return (weatherList, weatherListModel.city['name'].toString());
    } catch (_) {
      print(_);
      rethrow;
    }
  }
}
