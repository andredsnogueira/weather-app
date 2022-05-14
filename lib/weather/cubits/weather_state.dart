part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  final List<WeatherDay> weatherList;
  final WeatherDay selectedDay;

  WeatherLoadSuccess({
    required this.weatherList,
    required this.selectedDay,
  });
}

class WeatherLoadFailure extends WeatherState {}
