import 'package:dio/dio.dart';
import 'package:weatherapp/data/model/fetch_weather_model.dart';


final dio = Dio();

class WeatherS {
  var status = 'Valid';

  getWeather(String cityName) async {
    var appId = 'cefdada433614bfe87399be7a67f83a9';
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$appId';
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final result = response.data;


        return Weather.fromJson(result);

    } else if (response.statusCode == 404) {
      status = 'Missing';
    } else {
      throw Exception('broken');
    }
  }
}
