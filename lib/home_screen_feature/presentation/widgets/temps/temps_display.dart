import 'package:flutter/material.dart';
import 'package:weatherapp/home_screen_feature/presentation/widgets/temps/max_temp.dart';


import 'main_temp.dart';
import 'min_temp.dart';

class TempsDisplay extends StatelessWidget {
  final double? minTemp;
  final double? maxTemp;
  final double? mainTemp;
 const TempsDisplay(this.mainTemp, this.maxTemp, this.minTemp, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MainTemp(mainTemp!),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MinTemp(minTemp!),
                    //- 273.15).toInt()
                    const SizedBox(width: 20),
                    TempMax(maxTemp!),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 120),
          ],
        ),
      ],
    );
  }
}
