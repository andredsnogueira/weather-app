import '../weather.dart';

extension TemperatureExtension on TemperatureUnit {
  String convertTemperature(double temperature, TemperatureUnit unit) {
    if (unit == TemperatureUnit.celsius) {
      return '${temperature.toInt()}°C';
    } else {
      return '${(temperature * 1.8 + 32).toInt()}°F';
    }
  }
}
