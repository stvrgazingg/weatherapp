import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherApp(),
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        shadowColor: Colors.black45,
      ),
    );
  }
}

class Weather {
  final cityName;
  final temp;
  final description;
  final icon;
  final tempmin;
  final tempmax;
  final humidity;
  final pressure;

  Weather(
      {required this.cityName,
      required this.temp,
      required this.description,
      required this.icon,
      required this.tempmin,
      required this.tempmax,
      required this.humidity,
      required this.pressure});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temp: (json['main']['temp'] - 273.15).toInt().toString(),
        description: json['weather'][0]['main'],
        icon: json["weather"][0]["icon"],
        tempmax: (json['main']['temp_max'] - 273.15).toInt().toString(),
        tempmin: (json['main']['temp_min'] - 273.15).toInt().toString(),
        pressure: json['main']['pressure'].toString(),
        humidity: json['main']['humidity'].toString());
  }
}

String cityName = 'London';
String valueText = '';

class _WeatherS {
  Future<Weather> getWeather(String cityName) async {
    var appId = 'cefdada433614bfe87399be7a67f83a9';
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$appId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('broken');
    }
  }
}

class WeatherApp extends StatefulWidget {
  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final TextEditingController _textFieldController = TextEditingController();
  Weather? _currentWeather;

  _fetchWeather() async {
    try {
      final weather = await _WeatherS().getWeather(cityName);
      setState(() {
        _currentWeather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    cityName = "London";
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  colors: [Color.fromRGBO(120, 157, 194, 1), Color(0xFFF6EFE9)],
                )),
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Text(
                  cityName,
                  style: TextStyle(fontSize: 55, color: Colors.white, shadows: [
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )
                  ]),
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: _currentWeather?.icon != null
                      ? Image.network(
                          'http://openweathermap.org/img/w/${_currentWeather?.icon}.png',
                          fit: BoxFit.fill,
                        )
                      : Icon(
                          Icons.error,
                          size: 50,
                          color: Colors.red,
                        ),
                ),
                Text(
                  _currentWeather?.description ?? '',
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Colors.black54,
                      )
                    ],
                    fontSize: 36,
                    color: Color.fromRGBO(95, 123, 158, 1),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                ),
                Container(
                  width: 400,
                  height: 250,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      )
                    ],
                    color: Color.fromRGBO(120, 157, 194, 1),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 20),
                          Text(
                            " ${_currentWeather?.temp}°" ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 72,
                              color: Color.fromRGBO(51, 66, 82, 1),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                " ${_currentWeather?.tempmin}°" ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
                                  color: Color.fromRGBO(69, 85, 110, 1),
                                ),
                              ),
                              Text('Min',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23,
                                      color: Color.fromRGBO(95, 123, 158, 1))),
                            ],
                          ),
                          SizedBox(width: 125, height: 125),
                          Column(
                            children: [
                              Text(
                                " ${_currentWeather?.tempmax}°" ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
                                  color: Color.fromRGBO(69, 85, 110, 1),
                                ),
                                //color: Color.fromRGBO(69, 85, 110, 1)
                              ),
                              Text('Max',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23,
                                      color: Color.fromRGBO(95, 123, 158, 1))),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 400,
                  height: 100,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      )
                    ],
                    color: Color.fromRGBO(120, 157, 194, 1),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "${_currentWeather?.humidity}%" ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                              color: Color.fromRGBO(51, 66, 82, 1),
                            ),
                          ),
                          Text('Humidity',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                  color: Color.fromRGBO(69, 85, 110, 1))),
                        ],
                      ),
                      SizedBox(width: 50),
                      Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "${_currentWeather?.pressure}" ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                              color: Color.fromRGBO(51, 66, 82, 1),
                            ),
                          ),
                          Text('Pressure',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                  color: Color.fromRGBO(69, 85, 110, 1))),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Enter a city',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                content: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your city',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  controller: _textFieldController,
                  onChanged: (value) {
                    setState(() {
                      valueText = value;
                    });
                  },
                ),
                actions: [
                  TextButton(
                    child: Text('Cancel', style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Text('Save', style: TextStyle(color: Colors.green)),
                    onPressed: () {
                      setState(() {
                        cityName = valueText;
                        _fetchWeather();
                        Navigator.pop(context);
                      });
                    },
                  )
                ],
                contentPadding: EdgeInsets.all(20.0),
                titleTextStyle: TextStyle(fontSize: 24.0),
                contentTextStyle: TextStyle(fontSize: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
// void fetchWeather(var lat, var lon) async {
//   const url2 = 'https://api.openweathermap.org/data/2.5/weather?lat={$lat}&lon={$lon}&appid={cefdada433614bfe87399be7a67f83a9}';
//   var uri2 = Uri.parse(url2);
//   final response = await http.get(uri2);
//   final body = response.body;
//   final json = jsonDecode(body);
//   var weather = json['weather'];
//   var main = json['main'];
// }

// class getWeather {
//
//   Future<Weather> fetchWeather(String cityName) async {
//     var url = 'https://api.openweathermap.org/data/2.5/weather?q={$cityName}&appid={cefdada433614bfe87399be7a67f83a9}';
//     final response = await http.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       return Weather.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('broken');
//     }
//   }
// }

//  Future<bool> isCityValid(String cityName) async {
//     var appId = 'cefdada433614bfe87399be7a67f83a9';
//     var url =
//         'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$appId';
    
//     try {
//       final response = await http.get(Uri.parse(url));
//       return response.statusCode == 200;
//     } catch (e) {
//       return false;
//     }
//   }
