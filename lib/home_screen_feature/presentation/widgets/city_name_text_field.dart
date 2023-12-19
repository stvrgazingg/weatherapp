import 'package:flutter/material.dart';
import 'package:weatherapp/home_screen_feature/presentation/main.dart';

var defHintText = ' Enter your city';
Color defTextColor = Colors.grey;
FontWeight defWeight = FontWeight.normal;

class CityNameTextField extends StatefulWidget {
  const CityNameTextField({Key? key}) : super(key: key);

  @override
  CityNameTextFieldState createState() => CityNameTextFieldState();
}

class CityNameTextFieldState extends State<CityNameTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        setState(() {
          defHintText = ' Enter your city';
          defTextColor = Colors.grey;
          defWeight = FontWeight.normal;
        });
      },
      decoration: InputDecoration(
        hintText: defHintText,
        hintStyle: TextStyle(
          color: defTextColor,
          fontWeight: defWeight,
        ),
      ),
      onChanged: (value) {
        setState(() {
          valueText = value;
        });
      },
    );
  }
}
