import 'package:flutter/material.dart';

class HumidityTile extends StatelessWidget {
  final double? humidity;

  const HumidityTile(this.humidity, {Key? key}) : super(key: key);

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
                    'https://cdn-icons-png.flaticon.com/512/1582/1582886.png'),
              ),
              const SizedBox(height: 5),
              const Text('Humidity',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color.fromRGBO(50, 36, 88, 1))),
              const SizedBox(height: 10),
              Text(
                "$humidity %",
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
