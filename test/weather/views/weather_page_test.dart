import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:weather_app/weather/weather.dart';

import '../../helpers/helpers.dart';

void main() {
  late WeatherRepository weatherRepository;
  late WeatherCubit weatherCubit;
  late TemperatureUnitCubit temperatureUnitCubit;

  setUp(() {
    weatherRepository = MockWeatherRepository();
    weatherCubit = WeatherCubit(weatherRepository: weatherRepository);
    temperatureUnitCubit = TemperatureUnitCubit();
  });

  tearDownAll(() {
    reset(weatherRepository);
  });

  testWidgets('should render WeatherPage with two days', (
    WidgetTester tester,
  ) async {
    final mockData = mockWeatherData();
    when(() => weatherRepository.fetchWeather()).thenAnswer(
      (_) async => mockData,
    );

    await mockNetworkImages(() async {
      await tester.pumpApp(
        RepositoryProvider.value(
          value: weatherRepository,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: weatherCubit,
              ),
              BlocProvider.value(
                value: temperatureUnitCubit,
              ),
            ],
            child: const WeatherPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(WeatherPage), findsOneWidget);

      expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is Text &&
              widget.data!.contains(
                mockData.first.theTemp.toStringAsFixed(0),
              ) &&
              widget.key == const Key('weather_landscape_widget_temperature'),
        ),
        findsOneWidget,
      );

      expect(find.byType(WeatherListItemWidget), findsNWidgets(2));
    });
  });
}
