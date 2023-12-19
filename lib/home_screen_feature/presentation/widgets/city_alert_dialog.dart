import 'package:flutter/material.dart';


import 'cancel_button.dart';
import 'city_name_text_field.dart';
import 'save_button.dart';

class AlertDialogCity extends StatefulWidget {
  const AlertDialogCity({Key? key}) : super(key: key);

  @override
  AlertDialogCityState createState() => AlertDialogCityState();
}

class AlertDialogCityState extends State<AlertDialogCity> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          const Text('Enter a city', style: TextStyle(fontWeight: FontWeight.bold)),
      content: GestureDetector(
        child: const CityNameTextField(),
      ),
      actions: const [CancelButton(), SaveButton()],
      contentPadding: const EdgeInsets.all(16.0),
      titleTextStyle: const TextStyle(fontSize: 24.0),
      contentTextStyle: const TextStyle(fontSize: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}
