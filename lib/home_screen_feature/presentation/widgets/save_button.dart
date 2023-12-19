import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weatherapp/home_screen_feature/presentation/main.dart';

import '../bloc/weather_bloc.dart';

var defHintText = ' Enter your city';
Color defTextColor = Colors.grey;
FontWeight defWeight = FontWeight.normal;
bool error = false;

class SaveButton extends StatefulWidget {
  const SaveButton({Key? key}) : super(key: key);

  @override
  SaveButtonState createState() => SaveButtonState();
}

class SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Save', style: TextStyle(color: Colors.green)),
      onPressed: () async {
        // bool valid = await isCityValid(cityName);
        // print(valid);

        // //if (valid){
        if (valueText.isNotEmpty) {
          setState(
            () {
              cityName = valueText;
              BlocProvider.of<WeatherBloc>(context)
                  .add(FetchWeather(cityName: cityName));
              Navigator.pop(context);
            },
          );
        } else {
          setState(() {
            shakeKey.currentState?.shake();
            defHintText = "Enter a city name!";
            defTextColor = Colors.red;
            defWeight = FontWeight.bold;
            error = true;
          });
        }
        // } else {

        // }
      },
    );
  }
}
