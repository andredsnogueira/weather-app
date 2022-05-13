import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({
    required this.weatherRepository,
  }) : super(WeatherInitial());

  final WeatherRepository weatherRepository;

  void getWeather() async {
    try {
      emit(WeatherLoadInProgress());

      final weatherList = await weatherRepository.fetchWeather();

      emit(
        WeatherLoadSuccess(
          weatherList: weatherList,
          selectedDay: weatherList.first,
        ),
      );
    } on Object catch (_) {
      emit(WeatherLoadFailure());
    }
  }

  void selectDay({
    required List<WeatherDay> weatherList,
    required WeatherDay selectedDay,
  }) async {
    emit(
      WeatherLoadSuccess(
        weatherList: weatherList,
        selectedDay: selectedDay,
      ),
    );
  }
}
