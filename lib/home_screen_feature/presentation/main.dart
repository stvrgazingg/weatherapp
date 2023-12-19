// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screen/home_screen.dart';
import 'bloc/weather_bloc.dart';

String cityName = 'London';
String valueText = '';
void main() {
  runApp(BlocProvider<WeatherBloc>(
      create: (context) => WeatherBloc()..add(FetchWeather(cityName: cityName)),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: MyApp())));
}

final shakeKey = GlobalKey<ShakeWidgetState>();
