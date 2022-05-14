import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../weather.dart';

class WeatherListItemWidget extends StatelessWidget {
  const WeatherListItemWidget({
    Key? key,
    required this.weatherDay,
  }) : super(key: key);

  final WeatherDay weatherDay;

  String _imageUrl(String weatherState) =>
      '${Constants.kBaseImageUrl}/$weatherState.png';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final weekDayName = DateFormat('EE').format(
      DateTime.parse(weatherDay.applicableDate),
    );
    final temperatureUnitCubit = context.watch<TemperatureUnitCubit>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
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
              padding: const EdgeInsets.all(16.0),
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
  }
}
