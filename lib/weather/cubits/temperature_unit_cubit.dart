import 'package:bloc/bloc.dart';

import '../weather.dart';

class TemperatureUnitCubit extends Cubit<TemperatureUnit> {
  TemperatureUnitCubit() : super(TemperatureUnit.celsius);

  void toggleTemperatureUnit() {
    if (state == TemperatureUnit.celsius) {
      emit(TemperatureUnit.fahrenheit);
    } else {
      emit(TemperatureUnit.celsius);
    }
  }
}
