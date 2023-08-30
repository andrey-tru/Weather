part of 'main_cubit.dart';

@freezed
class MainState with _$MainState {
  factory MainState.forecast({
    @Default(false) bool isLoading,
    String? error,
    List<WeatherModel>? weatherList,
  }) = _MainStateForecast;
}
