import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weatherapp/home_screen_feature/presentation/main.dart';

import '../bloc/weather_bloc.dart';

class InvalidCityScreen extends StatefulWidget {
  const InvalidCityScreen({Key? key}) : super(key: key);

  @override
  InvalidCityScreenState createState() => InvalidCityScreenState();
}

class InvalidCityScreenState extends State<InvalidCityScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [const Icon(Icons.error_sharp, size: 250, color: Colors.black),
        const Text('You entered an invalid city name!',
            style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                decorationStyle: TextDecorationStyle.solid)),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(15),
            side: const BorderSide(color: Color.fromRGBO(69, 85, 110, 1)),
          ),
          onPressed: () {
            setState(
              () {
                cityName = 'London';
                BlocProvider.of<WeatherBloc>(context)
                    .add(FetchWeather(cityName: cityName));
              },
            );
          },
          child: const Text("Go back to the default screen!",
              style: TextStyle(
                  fontSize: 19, color: Color.fromRGBO(69, 85, 110, 1))),
        ),
        const SizedBox(height: 40)
      ],
    );
  }
}
