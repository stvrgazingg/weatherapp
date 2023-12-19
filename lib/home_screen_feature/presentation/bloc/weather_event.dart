part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent {
  final String cityName;

  const FetchWeather({required this.cityName});

  @override
  List<Object> get props => [cityName];
}
