import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_bloc_observer.dart';
import 'weather/weather.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(
      RepositoryProvider(
        create: (context) => WeatherRepository(),
        child: const MyApp(),
      ),
    ),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WeatherPage(),
    );
  }
}
