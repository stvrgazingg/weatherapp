import 'package:flutter/material.dart';

class FeelsLikeTile extends StatelessWidget {
  final double? feelsLike;
  const FeelsLikeTile(this.feelsLike, {Key? key}) : super(key: key);

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
                    'https://static-00.iconduck.com/assets.00/temperature-feels-like-icon-495x512-ylzv705f.png'),
              ),
              const SizedBox(height: 5),
              const Text('Feels like',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color.fromRGBO(50, 36, 88, 1))),
              const SizedBox(height: 10),
              Text(
                "${(feelsLike! - 273.15).toInt()}°",
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
