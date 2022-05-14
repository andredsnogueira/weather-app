class WeatherDay {
  final int id;
  final String weatherStateName;
  final String weatherStateAbbr;
  final String? windDirectionCompass;
  final String? created;
  final String applicableDate;
  final double minTemp;
  final double maxTemp;
  final double theTemp;
  final double windSpeed;
  final double? windDirection;
  final double airPressure;
  final int humidity;
  final double? visibility;
  final int? predictability;

  const WeatherDay({
    required this.id,
    required this.weatherStateName,
    required this.weatherStateAbbr,
    required this.windDirectionCompass,
    required this.created,
    required this.applicableDate,
    required this.minTemp,
    required this.maxTemp,
    required this.theTemp,
    required this.windSpeed,
    required this.windDirection,
    required this.airPressure,
    required this.humidity,
    required this.visibility,
    required this.predictability,
  });

  factory WeatherDay.fromJson(Map<String, dynamic> json) {
    return WeatherDay(
      id: json['id'],
      weatherStateName: json['weather_state_name'],
      weatherStateAbbr: json['weather_state_abbr'],
      windDirectionCompass: json['wind_direction_compass'],
      created: json['created'],
      applicableDate: json['applicable_date'],
      minTemp: json['min_temp'],
      maxTemp: json['max_temp'],
      theTemp: json['the_temp'],
      windSpeed: json['wind_speed'],
      windDirection: json['wind_direction'],
      airPressure: json['air_pressure'],
      humidity: json['humidity'],
      visibility: json['visibility'],
      predictability: json['predictability'],
    );
  }
}
