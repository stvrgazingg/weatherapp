class Weather {
  final cityName;
  final temp;
  final description;
  final icon;
  final tempmin;
  final tempmax;
  final humidity;
  final pressure;
  final windspeed;
  final date;
  final feelslike;

  Weather(
      {required this.cityName,
      required this.temp,
      required this.description,
      required this.icon,
      required this.tempmin,
      required this.tempmax,
      required this.humidity,
      required this.pressure,
      required this.windspeed,
      required this.date,
      required this.feelslike});

  factory Weather.fromJson(Map result) {
    return Weather(
        cityName: result['name'],
        temp: (result['main']['temp'] - 273.15).toInt().toString(),
        description: result['weather'][0]['main'],
        icon: result["weather"][0]["icon"],
        tempmax: (result['main']['temp_max'] - 273.15).toInt().toString(),
        tempmin: (result['main']['temp_min'] - 273.15).toInt().toString(),
        pressure: result['main']['pressure'].toString(),
        humidity: result['main']['humidity'].toString(),
        windspeed: result['wind']['speed'].toString(),
        date: result['dt'].toString(),
        feelslike: (result['main']['feels_like']..toInt().toString()));
  }
}
