import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => WeatherCubit(
            weatherRepository: WeatherRepository(),
          )..getWeather(),
        ),
        BlocProvider(
          create: (_) => TemperatureUnitCubit(),
        ),
      ],
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  String calculateTemperature(TemperatureUnit unit, double temperature) {
    if (unit == TemperatureUnit.celsius) {
      return '${temperature.toInt()}°C';
    } else {
      return '${(temperature * 1.8 + 32).toInt()}°F';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoadSuccess) {
              final currentTemperatureUnit =
                  context.watch<TemperatureUnitCubit>();
              final weekDayName = DateFormat('EEEE').format(
                DateTime.parse(state.selectedDay.applicableDate),
              );

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<WeatherCubit>().getWeather();
                },
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(weekDayName),
                        IconButton(
                          onPressed: () {
                            context
                                .read<TemperatureUnitCubit>()
                                .toggleTemperatureUnit();
                          },
                          icon: const Icon(Icons.thermostat, size: 32),
                        )
                      ],
                    ),
                    Text(state.selectedDay.weatherStateName),
                    Image.network(
                      'https://www.metaweather.com/static/img/weather/png/${state.selectedDay.weatherStateAbbr}.png',
                    ),
                    Text(
                      calculateTemperature(
                        currentTemperatureUnit.state,
                        state.selectedDay.theTemp,
                      ),
                    ),
                    Text('Humidity: ${state.selectedDay.humidity}%'),
                    Text(
                      'Pressure: ${state.selectedDay.airPressure.ceil()} hPa',
                    ),
                    Text('Wind: ${state.selectedDay.windSpeed.ceil()} km/h'),
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.weatherList.length - 1,
                        itemBuilder: ((context, index) {
                          final weatherDay = state.weatherList.elementAt(index);
                          final weekDayName = DateFormat('EE').format(
                            DateTime.parse(weatherDay.applicableDate),
                          );

                          return GestureDetector(
                            onTap: () {
                              context.read<WeatherCubit>().selectDay(
                                    weatherList: state.weatherList,
                                    selectedDay: weatherDay,
                                  );
                            },
                            child: Column(
                              children: [
                                Text(weekDayName),
                                Image.network(
                                  'https://www.metaweather.com/static/img/weather/png/${weatherDay.weatherStateAbbr}.png',
                                  height: 100,
                                ),
                                Text(
                                  '${calculateTemperature(
                                    currentTemperatureUnit.state,
                                    weatherDay.minTemp,
                                  )} / ${calculateTemperature(
                                    currentTemperatureUnit.state,
                                    weatherDay.maxTemp,
                                  )}',
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is WeatherLoadFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Something went wrong. Try again later.'),
                    ElevatedButton(
                      onPressed: () {
                        context.read<WeatherCubit>().getWeather();
                      },
                      child: const Text('Retry'),
                    )
                  ],
                ),
              );
            } else if (state is WeatherLoadInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
