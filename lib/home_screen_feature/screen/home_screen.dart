import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../presentation/widgets/weather_app.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  void initState() {}

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WeatherApp(),
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        shadowColor: Colors.black45,
      ),
    );
  }
}
