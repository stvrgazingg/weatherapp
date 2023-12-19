part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherFailure extends WeatherState {}

class WeatherSucess extends WeatherState {
  final Weather weather;

  const WeatherSucess(this.weather);
  @override
  List<Object> get props => [weather];
}
