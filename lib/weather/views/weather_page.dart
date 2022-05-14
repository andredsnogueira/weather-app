import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../weather.dart';

const _kBaseImageUrl = 'https://www.metaweather.com/static/img/weather/png';

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
      child: const WeatherView(),
    );
  }
}

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoadSuccess) {
              return OrientationBuilder(
                builder: (context, orientation) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<WeatherCubit>().getWeather();
                    },
                    child: orientation == Orientation.portrait
                        ? WeatherPortraitWidget(weather: state)
                        : WeatherLandscapeWidget(weather: state),
                  );
                },
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
