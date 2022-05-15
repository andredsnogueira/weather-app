import 'package:mocktail/mocktail.dart';
import 'package:weather_app/weather/weather.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

List<WeatherDay> mockWeatherData() {
  return const <WeatherDay>[
    WeatherDay(
      id: 1,
      airPressure: 1.0,
      applicableDate: '2020-01-01',
      humidity: 10,
      maxTemp: 10.0,
      minTemp: 10.0,
      theTemp: 10.0,
      weatherStateAbbr: 'sy',
      weatherStateName: 'sunny',
      windSpeed: 10.0,
      created: '2020-01-01',
      predictability: 10,
      visibility: 10.0,
      windDirection: 10.0,
      windDirectionCompass: 'N',
    ),
    WeatherDay(
      id: 2,
      airPressure: 1.0,
      applicableDate: '2020-01-02',
      humidity: 10,
      maxTemp: 10.0,
      minTemp: 10.0,
      theTemp: 10.0,
      weatherStateAbbr: 'sy',
      weatherStateName: 'sunny',
      windSpeed: 10.0,
      created: '2020-01-01',
      predictability: 10,
      visibility: 10.0,
      windDirection: 10.0,
      windDirectionCompass: 'S',
    ),
  ];
}
