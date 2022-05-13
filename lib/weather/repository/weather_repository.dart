import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/weather/repository/models/weather_day.dart';

class WeatherRepository {
  Future<List<WeatherDay>> fetchWeather() async {
    final response = await http
        .get(
          Uri.parse(
            'https://www.metaweather.com/api/location/44418',
          ),
        )
        .timeout(const Duration(seconds: 10));

    final parsed = jsonDecode(response.body);

    return parsed['consolidated_weather']
        .map<WeatherDay>((json) => WeatherDay.fromJson(json))
        .toList();
  }
}
