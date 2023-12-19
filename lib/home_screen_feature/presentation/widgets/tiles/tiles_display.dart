import 'package:flutter/material.dart';


import 'feels_like_tile.dart';
import 'humidity_tile.dart';
import 'pressure_tile.dart';
import 'windspeed_tile.dart';

class TilesDisplay extends StatelessWidget {
  final String? pressure;
  final double? feelsLike;
  final double? humidity;
  final String? windspeed;

  const TilesDisplay(this.pressure, this.feelsLike, this.humidity, this.windspeed,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 15),
        PressureTile(pressure!),
        const SizedBox(width: 13),
        FeelsLikeTile(feelsLike!),
        const SizedBox(width: 13),
        HumidityTile(humidity!),
        const SizedBox(width: 13),
        WindspeedTile(windspeed!),
        const SizedBox(width: 15)
      ],
    );
  }
}
