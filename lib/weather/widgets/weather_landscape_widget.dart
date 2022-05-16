import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../weather.dart';

class WeatherLandscapeWidget extends StatelessWidget {
  const WeatherLandscapeWidget({
    super.key,
    required this.weather,
  });

  final WeatherLoadSuccess weather;

  String _imageUrl(String weatherState) =>
      '${Constants.kBaseImageUrl}/$weatherState.png';

  @override
  Widget build(BuildContext context) {
    final weekDayName = DateFormat('EEEE').format(
      DateTime.parse(weather.selectedDay.applicableDate),
    );
    final textTheme = Theme.of(context).textTheme;
    final temperatureUnitCubit = context.watch<TemperatureUnitCubit>();
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView(
          children: [
            SizedBox(
              height: constraints.maxHeight,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    weekDayName,
                                    style: textTheme.headline2!.copyWith(
                                      fontSize: 20 * devicePixelRatio,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<TemperatureUnitCubit>()
                                        .toggleTemperatureUnit();
                                  },
                                  icon: const Icon(
                                    Icons.thermostat,
                                    size: 32,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              weather.selectedDay.weatherStateName,
                              style: textTheme.subtitle1,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Image.network(
                                _imageUrl(
                                  weather.selectedDay.weatherStateAbbr,
                                ),
                                height: 100,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                temperatureUnitCubit.state.convertTemperature(
                                  weather.selectedDay.theTemp,
                                  temperatureUnitCubit.state,
                                ),
                                style: textTheme.headline1!.copyWith(
                                  fontSize: devicePixelRatio * 40,
                                ),
                                key: const Key(
                                  'weather_landscape_widget_temperature',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: WeatherDetailItemWidget(
                                icon: Icons.water_drop,
                                iconColor: Colors.blue,
                                label: '${weather.selectedDay.humidity}%',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: WeatherDetailItemWidget(
                                icon: Icons.compress,
                                iconColor: Colors.orange,
                                label:
                                    '${weather.selectedDay.airPressure.toInt()} hPa',
                              ),
                            ),
                            WeatherDetailItemWidget(
                              icon: Icons.wind_power,
                              iconColor: Colors.green,
                              label:
                                  '${weather.selectedDay.windSpeed.toInt()} km/h',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: weather.weatherList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: ((context, index) {
                        final weatherDay = weather.weatherList.elementAt(index);

                        return GestureDetector(
                          onTap: () {
                            context.read<WeatherCubit>().selectDay(
                                  weatherList: weather.weatherList,
                                  selectedDay: weatherDay,
                                );
                          },
                          child: WeatherListItemWidget(
                            weatherDay: weatherDay,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
