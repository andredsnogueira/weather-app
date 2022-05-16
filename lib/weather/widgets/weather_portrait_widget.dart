import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../weather.dart';

class WeatherPortraitWidget extends StatelessWidget {
  const WeatherPortraitWidget({
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 16.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: Column(
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
                  ),
                  Expanded(
                    child: Image.network(
                      _imageUrl(weather.selectedDay.weatherStateAbbr),
                    ),
                  ),
                  Text(
                    temperatureUnitCubit.state.convertTemperature(
                      weather.selectedDay.theTemp,
                      temperatureUnitCubit.state,
                    ),
                    style: textTheme.headline1!.copyWith(
                      fontSize: devicePixelRatio * 40,
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        WeatherDetailItemWidget(
                          icon: Icons.water_drop,
                          iconColor: Colors.blue,
                          label: '${weather.selectedDay.humidity}%',
                        ),
                        WeatherDetailItemWidget(
                          icon: Icons.compress,
                          iconColor: Colors.orange,
                          label:
                              '${weather.selectedDay.airPressure.toInt()} hPa',
                        ),
                        WeatherDetailItemWidget(
                          icon: Icons.wind_power,
                          iconColor: Colors.green,
                          label:
                              '${weather.selectedDay.windSpeed.toInt()} km/h',
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: weather.weatherList.length,
                      itemBuilder: ((context, index) {
                        final weatherDay = weather.weatherList.elementAt(index);
                        final weekDayName = DateFormat('EE').format(
                          DateTime.parse(weatherDay.applicableDate),
                        );

                        return GestureDetector(
                          onTap: () {
                            context.read<WeatherCubit>().selectDay(
                                  weatherList: weather.weatherList,
                                  selectedDay: weatherDay,
                                );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                weekDayName,
                                style: textTheme.headline5,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Image.network(
                                    _imageUrl(
                                      weatherDay.weatherStateAbbr,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                '${temperatureUnitCubit.state.convertTemperature(
                                  weatherDay.minTemp,
                                  temperatureUnitCubit.state,
                                )} / ${temperatureUnitCubit.state.convertTemperature(
                                  weatherDay.maxTemp,
                                  temperatureUnitCubit.state,
                                )}',
                                style: textTheme.subtitle1,
                              ),
                            ],
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
