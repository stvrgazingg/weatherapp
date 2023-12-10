import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:weatherapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

String cityName = 'Cairo';
String valueText ='';

class _WeatherS {
  Future<Weather> getWeather(String cityName) async {
    var url = 'https://api.openweathermap.org/data/2.5/weather?q={$cityName}&appid={cefdada433614bfe87399be7a67f83a9}';
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


  _fetchWeather() async{
    try {
      final weather = await _WeatherS().getWeather(cityName);
      setState(() {
        _currentWeather = weather;
      });
    }
    catch(e){
      print(e);
    }
  }

  @override
  void initState(){
    super.initState();
    cityName = "Cairo";
    _fetchWeather();

  }

@override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(cityName)),
      body: Column(
      children: [
        Text(cityName,style: TextStyle(fontWeight: FontWeight.bold,fontSize:48)),
        Image.network('http://openweathermap.org/img/w/{$_currentWeather?.icon}.png'),
        Text(_currentWeather?.temp,style: TextStyle(fontWeight: FontWeight.bold,fontSize:36)),
        Center(child: Text(_currentWeather?.description,style: TextStyle(fontWeight: FontWeight.bold,fontSize:36))),
]
  ),
      floatingActionButton: FloatingActionButton.large(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Enter a city'),
                content: TextField(
                    decoration: InputDecoration.collapsed(
                    hintText: 'Enter your city',
                    hintStyle: TextStyle(color: Colors.grey)),
                    controller: _textFieldController,
                    onChanged: (value) {
                    setState(() {
                       valueText = value;
                    });
                  }
                ),
               actions: [TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              TextButton(
              child: Text('Save'),
              onPressed: () {

              setState(() {
              cityName = valueText;
              Navigator.pop(context);
              });

              },
              )],

              );
            },
          );
        },
      ),
    );
  }
}
