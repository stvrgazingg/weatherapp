import 'dart:math';
import 'package:dio/dio.dart';


final dio = Dio();
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
    rethrow;
  }
  throw (e);
}
