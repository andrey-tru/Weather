part of 'main_cubit.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    @Default(false) bool isLoading,
    String? error,
    List<WeatherModel>? weatherList,
    String? city,
    @Default(0) int selectedWeather,
  }) = _MainState;

  factory MainState.fromJson(Map<String, dynamic> json) =>
      _$MainStateFromJson(json);
}
