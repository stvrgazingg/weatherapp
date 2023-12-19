import 'package:flutter/material.dart';
import 'package:weatherapp/home_screen_feature/presentation/main.dart';

import '../weather_app.dart';


class CityName extends StatefulWidget {
  const CityName({Key? key}) : super(key: key);

  @override
  CityNameState createState() => CityNameState();
}

class CityNameState extends State<CityName> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(3, 0),
              blurRadius: 12,
            ),
          ],
          color: buttonColor,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 10,
        ),
        child: Text(cityName,
            style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.bold)));
  }
}
