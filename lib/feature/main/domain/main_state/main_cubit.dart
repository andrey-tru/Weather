import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/feature/feature.dart';

part 'main_state.dart';
part 'main_cubit.freezed.dart';
part 'main_cubit.g.dart';

@Singleton()
class MainCubit extends HydratedCubit<MainState> {
  MainCubit(this.mainRepository) : super(const MainState());

  final MainRepository mainRepository;

  Future<void> determinePosition() async {
    emit(state.copyWith(isLoading: true));

    Position position;
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(
        state.copyWith(
          error: 'Location services are disabled.',
          isLoading: false,
          selectedWeather: 0,
        ),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(
          state.copyWith(
            error: 'Location permissions are denied',
            isLoading: false,
            selectedWeather: 0,
          ),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(
        state.copyWith(
          error:
              'Location permissions are permanently denied, we cannot request permissions.',
          isLoading: false,
          selectedWeather: 0,
        ),
      );
      return;
    }
    position = await Geolocator.getCurrentPosition();

    forecast(lat: position.latitude, lon: position.longitude);
  }

  Future<void> forecast({
    required double lat,
    required double lon,
  }) async {
    try {
      final (List<WeatherModel> weatherList, String city) =
          await mainRepository.forecast(lat: lat, lon: lon);
      emit(
        state.copyWith(
          isLoading: false,
          weatherList: weatherList,
          city: city,
          selectedWeather: 0,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          error: error.toString(),
          isLoading: false,
          selectedWeather: 0,
        ),
      );
    }
  }

  void selectedWeather(int index) {
    emit(state.copyWith(selectedWeather: index));
  }

  @override
  MainState? fromJson(Map<String, dynamic> json) {
    return MainState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(MainState state) {
    return state.toJson();
  }
}
