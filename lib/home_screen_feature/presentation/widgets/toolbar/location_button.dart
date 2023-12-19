import 'package:flutter/material.dart';


import '../shakeable_dialog.dart';
import '../WeatherApp.dart';

class LocationButton extends StatefulWidget {
  const LocationButton({Key? key}) : super(key: key);

  @override
  LocationButtonState createState() => LocationButtonState();
}

class LocationButtonState extends State<LocationButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.location_pin,
          shadows: const [
            Shadow(
              color: Colors.black,
              offset: Offset(1, 1),
              blurRadius: 1,
            ),
          ],
          size: 50,
          color: buttonColor),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => const ShakeableDialog(),
        );
      },
    );
  }
}
