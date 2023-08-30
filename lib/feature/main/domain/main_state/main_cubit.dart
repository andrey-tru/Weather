import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/feature/feature.dart';

part 'main_state.dart';
part 'main_cubit.freezed.dart';

@Singleton()
class MainCubit extends Cubit<MainState> {
  MainCubit(this.mainRepository) : super(MainState.forecast());

  final MainRepository mainRepository;

  Future<void> forecast({
    required String lat,
    required String lon,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      final List<WeatherModel> weatherList =
          await mainRepository.forecast(lat: lat, lon: lon);
      emit(state.copyWith(isLoading: false, weatherList: weatherList));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
    }
  }
}
