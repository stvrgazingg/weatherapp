import 'package:flutter/material.dart';

class MinTemp extends StatelessWidget {
  final double minTemp;

 const MinTemp(this.minTemp, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          " $minTemp°",
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
        ),
        const Text('Min',
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
