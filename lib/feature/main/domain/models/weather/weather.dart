import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';
part 'weather.g.dart';

@freezed
class WeatherModel with _$WeatherModel {
  const factory WeatherModel({
    @JsonKey(name: 'dt_txt') required String dt,
    required double temp,
    required String description,
    required double tempMax,
    required double tempMin,
    required double windSpeed,
    required int windDeg,
    required int humidity,
    required int iconId,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  @override
  Map<String, dynamic> toJson();
}
