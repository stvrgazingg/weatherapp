import 'package:flutter/material.dart';

class MainTemp extends StatelessWidget {
  final double temp;
  const MainTemp(this.temp, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${(temp - 273.15).toInt()}°",
      style: const TextStyle(shadows: [
        Shadow(
          color: Colors.black26,
          offset: Offset(2, 2),
          blurRadius: 6,
        ),
      ], fontWeight: FontWeight.bold, fontSize: 110, color: Colors.white),
    );
  }
}
