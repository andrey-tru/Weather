import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_list.freezed.dart';
part 'weather_list.g.dart';

@freezed
class WeatherListModel with _$WeatherListModel {
  const factory WeatherListModel({
    required List<Map<String, dynamic>> list,
  }) = _WeatherListModel;

  factory WeatherListModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherListModelFromJson(json);

  @override
  Map<String, dynamic> toJson();
}
