import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String icon;
  const WeatherIcon(this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Image.network('https://openweathermap.org/img/wn/$icon@2x.png',
          fit: BoxFit.fitHeight),
    );
  }
}
