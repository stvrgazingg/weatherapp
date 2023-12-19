import 'package:flutter/material.dart';

class PressureTile extends StatelessWidget {
   final String? pressure;
   const PressureTile(this.pressure, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 200,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 0),
                blurRadius: 2,
              ),
            ],
            color: const Color.fromARGB(255, 250, 249, 251),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                child: Image.network(
                    'https://cdn4.iconfinder.com/data/icons/weather-287/32/92-_pressure-_air-_wind-_weather-512.png'),
              ),
              const SizedBox(height: 5),
              const Text('Pressure',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color.fromRGBO(50, 36, 88, 1))),
              const SizedBox(height: 10),
              Text(
                "$pressure Pa",
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 28,
                  color: Color.fromRGBO(68, 55, 139, 1),
                ),
              ),
              const SizedBox(height: 10),
            ],
          )),
    );
  }
}
