import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weatherapp/home_screen_feature/presentation/main.dart';

import '../../bloc/weather_bloc.dart';
import '../weather_app.dart';


class RefreshButton extends StatefulWidget {
  const RefreshButton({Key? key}) : super(key: key);

  @override
  RefreshButtonState createState() => RefreshButtonState();
}

class RefreshButtonState extends State<RefreshButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.refresh,
        size: 50,
        color: buttonColor,
        shadows: const [
          Shadow(
            color: Colors.black,
            offset: Offset(1, 1),
            blurRadius: 2,
          ),
        ],
      ),
      onPressed: () {
        BlocProvider.of<WeatherBloc>(context)
            .add(FetchWeather(cityName: cityName));
      },
    );
  }
}
