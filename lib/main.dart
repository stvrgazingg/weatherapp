// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:weatherapp/bloc/bloc/weather_bloc.dart';

final dio = Dio();
void main() {
  runApp(BlocProvider<WeatherBloc>(
      create: (context) => WeatherBloc()..add(FetchWeather(cityName: cityName)),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: MyApp())));
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

String cityName = 'London';
String valueText = '';

class WeatherApp extends StatefulWidget {
  @override
  State<WeatherApp> createState() => WeatherAppState();
}

bool invalidCity = false;

Color buttonColor = Color.fromARGB(255, 113, 100, 138);

class WeatherAppState extends State<WeatherApp> {
  @override
  void initState() {
    super.initState();
    cityName = "London";

    // fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherSucess) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(120, 157, 194, 1),
                          Color.fromRGBO(216, 191, 216, 1),
                          Color(0xFFF6EFE9)
                        ],
                      )),
                  width: MediaQuery.of(context).size.width,
                  height: 520,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.location_pin,
                                shadows: [
                                  const Shadow(
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
                                builder: (_) => ShakeableDialog(),
                              );
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(3, 0),
                                    blurRadius: 12,
                                  ),
                                ],
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 10,
                                bottom: 10,
                              ),
                              child: Text(cityName,
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.refresh,
                              size: 50,
                              color: buttonColor,
                              shadows: [
                                const Shadow(
                                  color: Colors.black,
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            onPressed: () {
                              BlocProvider.of<WeatherBloc>(context)
                                  .add(FetchWeather(cityName: cityName));
                            },
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 250, height: 0),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 110,
                                    child: Image.network(
                                        'https://openweathermap.org/img/wn/${state.weather.icon}@2x.png',
                                        fit: BoxFit.fitHeight),
                                  ),
                                  Text(
                                    state.weather.description ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(1.0, 1.0),
                                          blurRadius: 5.0,
                                          color: Colors.black54,
                                        )
                                      ],
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    " ${state.weather.temp}°",
                                    style: TextStyle(
                                        shadows: [
                                          const Shadow(
                                            color: Colors.black26,
                                            offset: Offset(2, 2),
                                            blurRadius: 6,
                                          ),
                                        ],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 110,
                                        color: Colors.white),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            " ${state.weather.tempmin}°",
                                            style: TextStyle(
                                              shadows: [
                                                const Shadow(
                                                  color: Colors.black26,
                                                  offset: Offset(2, 2),
                                                  blurRadius: 6,
                                                ),
                                              ],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 40,
                                              color: Color.fromRGBO(
                                                  205, 206, 216, 1),
                                            ),
                                          ),
                                          Text('Min',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 21,
                                                color: Color.fromRGBO(
                                                    193, 193, 214, 1),
                                                shadows: [
                                                  const Shadow(
                                                    color: Colors.black26,
                                                    offset: Offset(2, 2),
                                                    // blurRadius: 6,
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            " ${state.weather.tempmax}°",
                                            style: TextStyle(
                                              shadows: [
                                                const Shadow(
                                                  color: Colors.black26,
                                                  offset: Offset(2, 2),
                                                  blurRadius: 6,
                                                ),
                                              ],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 40,
                                              color: Color.fromRGBO(
                                                  205, 206, 216, 1),
                                            ),
                                            //color: Color.fromRGBO(69, 85, 110, 1)
                                          ),
                                          Text('Max',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 21,
                                                color: Color.fromRGBO(
                                                    193, 193, 214, 1),
                                                shadows: [
                                                  const Shadow(
                                                    color: Colors.black26,
                                                    offset: Offset(2, 2),
                                                    // blurRadius: 6,
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: 120),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 480),
                    Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(3, 0),
                                blurRadius: 30,
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            color: Colors.white),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 480,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(width: 15),
                              SizedBox(
                                width: 150,
                                height: 200,
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          offset: Offset(0, 0),
                                          blurRadius: 2,
                                        ),
                                      ],
                                      color: Color.fromARGB(255, 250, 249, 251),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: Image.network(
                                              'https://static-00.iconduck.com/assets.00/temperature-feels-like-icon-495x512-ylzv705f.png'),
                                        ),
                                        SizedBox(height: 5),
                                        Text('Feels like',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                                color: Color.fromRGBO(
                                                    50, 36, 88, 1))),
                                        SizedBox(height: 10),
                                        Text(
                                          "${state.weather.feelslike}°",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 28,
                                            color:
                                                Color.fromRGBO(68, 55, 139, 1),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    )),
                              ),
                              SizedBox(width: 13),
                              SizedBox(
                                width: 150,
                                height: 200,
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          offset: Offset(0, 0),
                                          blurRadius: 2,
                                        ),
                                      ],
                                      color: Color.fromARGB(255, 250, 249, 251),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: Image.network(
                                              'https://cdn4.iconfinder.com/data/icons/weather-287/32/92-_pressure-_air-_wind-_weather-512.png'),
                                        ),
                                        SizedBox(height: 5),
                                        Text('Pressure',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                                color: Color.fromRGBO(
                                                    50, 36, 88, 1))),
                                        SizedBox(height: 10),
                                        Text(
                                          "${state.weather.pressure} Pa",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 28,
                                            color:
                                                Color.fromRGBO(68, 55, 139, 1),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    )),
                              ),
                              SizedBox(width: 13),
                              SizedBox(
                                width: 150,
                                height: 200,
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          offset: Offset(0, 0),
                                          blurRadius: 2,
                                        ),
                                      ],
                                      color: Color.fromARGB(255, 250, 249, 251),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: Image.network(
                                              'https://cdn-icons-png.flaticon.com/512/1582/1582886.png'),
                                        ),
                                        SizedBox(height: 5),
                                        Text('Humidity',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                                color: Color.fromRGBO(
                                                    50, 36, 88, 1))),
                                        SizedBox(height: 10),
                                        Text(
                                          "${state.weather.humidity} %",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 28,
                                            color:
                                                Color.fromRGBO(68, 55, 139, 1),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    )),
                              ),
                              SizedBox(width: 13),
                              SizedBox(
                                width: 150,
                                height: 200,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(0, 0),
                                        blurRadius: 2,
                                      ),
                                    ],
                                    color: Color.fromARGB(255, 250, 249, 251),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        child: Image.network(
                                            'https://cdn-icons-png.flaticon.com/512/54/54298.png'),
                                      ),
                                      SizedBox(height: 5),
                                      Text('Windspeed',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              color: Color.fromRGBO(
                                                  50, 36, 88, 1))),
                                      SizedBox(height: 10),
                                      Text(
                                        "${state.weather.windspeed} m/s",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 28,
                                          color: Color.fromRGBO(68, 55, 139, 1),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 15)
                            ],
                          ),
                        ))
                  ],
                )
              ],
            ),
          );
        } else if (state is WeatherLoading) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.black,
              size: 300,
            ),
          );
        } else if (state is WeatherFailure) {
          try {
            return Scaffold(
                body: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_sharp, size: 250, color: Colors.black),
                    Text('You entered an invalid city name!',
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decorationStyle: TextDecorationStyle.solid)),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(15),
                        side: BorderSide(color: Color.fromRGBO(69, 85, 110, 1)),
                      ),
                      onPressed: () {
                        setState(
                          () {
                            cityName = 'London';
                            BlocProvider.of<WeatherBloc>(context)
                                .add(FetchWeather(cityName: cityName));
                          },
                        );
                      },
                      child: Text("Go back to the default screen!",
                          style: TextStyle(
                              fontSize: 19,
                              color: Color.fromRGBO(69, 85, 110, 1))),
                    ),
                    SizedBox(height: 40)
                  ],
                ),
              ),
            ));
          } catch (e) {
            return Icon(Icons.error, size: 300);
          }
        } else {
          try {
            invalidCity = true;
            return Icon(Icons.error_sharp, size: 300);
          } catch (e) {
            return Icon(Icons.error, size: 300);
          }
        }
      },
    );
  }
}

final shakeKey = GlobalKey<ShakeWidgetState>();

class ShakeableDialog extends StatefulWidget {
  final Duration duration; // how fast to shake
  final double distance; // how far to shake

  const ShakeableDialog({
    Key? key,
    this.duration = const Duration(milliseconds: 300),
    this.distance = 24.0,
  }) : super(key: key);

  @override
  ShakeableDialogState createState() => ShakeableDialogState();
}

class ShakeableDialogState extends State<ShakeableDialog>
    with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  var defHintText = ' Enter your city';
  Color defTextColor = Colors.grey;
  FontWeight defWeight = FontWeight.normal;
  bool error = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          final dx = sin(controller.value * 2 * pi) * widget.distance;
          return Transform.translate(
            offset: Offset(dx, 0),
            child: child,
          );
        },
        child: ShakeMe(
          key: shakeKey,
          shakeCount: 3,
          shakeOffset: 10,
          shakeDuration: Duration(milliseconds: 500),
          child: AlertDialog(
            title: Text('Enter a city',
                style: TextStyle(fontWeight: FontWeight.bold)),
            content: GestureDetector(
              child: TextField(
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
              ),
            ),
            actions: [
              TextButton(
                child: Text('Cancel', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.pop(context);
                  //   Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('Save', style: TextStyle(color: Colors.green)),
                onPressed: () async {
                  // bool valid = await isCityValid(cityName);
                  // print(valid);

                  // //if (valid){
                  if (valueText.isNotEmpty) {
                    setState(
                      () {
                        cityName = valueText;
                        BlocProvider.of<WeatherBloc>(context)
                            .add(FetchWeather(cityName: cityName));
                        Navigator.pop(context);
                      },
                    );
                  } else {
                    setState(() {
                      shakeKey.currentState?.shake();
                      defHintText = "Enter a city name!";
                      defTextColor = Colors.red;
                      defWeight = FontWeight.bold;
                      error = true;
                    });
                  }
                  // } else {

                  // }
                },
              )
            ],
            contentPadding: EdgeInsets.all(16.0),
            titleTextStyle: TextStyle(fontSize: 24.0),
            contentTextStyle: TextStyle(fontSize: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ));
  }

  void dispose() {
    controller.dispose();
    super.dispose();
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

Future<bool> isCityValid(String cityName) async {
  var appId = 'cefdada433614bfe87399be7a67f83a9';
  var url =
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$appId';
  try {
    final response = await dio.get(url);

    if (response.statusCode == 404) {
      return false;
    } else if (response.statusCode == 200) {
      return true;
    }
  } catch (e) {
    throw (e);
  }
  throw (e);
}

class saveFunction {
  String cityName;
  String valueText;

  saveFunction(this.cityName, this.valueText);
}
