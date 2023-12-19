import 'package:flutter/material.dart';

class TempMax extends StatelessWidget {
  final double maxTemp;
   const TempMax(this.maxTemp, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          " ${(maxTemp - 273.15).toInt()}°",
          style: const TextStyle(
            shadows: [
              Shadow(
                color: Colors.black26,
                offset: Offset(2, 2),
                blurRadius: 6,
              ),
            ],
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: Color.fromRGBO(205, 206, 216, 1),
          ),
          //color: Color.fromRGBO(69, 85, 110, 1)
        ),
        const Text('Max',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21,
              color: Color.fromRGBO(193, 193, 214, 1),
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(2, 2),
                  // blurRadius: 6,
                ),
              ],
            )),
      ],
    );
  }
}
