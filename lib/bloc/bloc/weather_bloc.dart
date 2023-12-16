import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weatherapp/model/fetch_weather_model.dart';
import 'package:weatherapp/service/fetch_weather_service.dart';

import '../../main.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await WeatherS().getWeather(cityName);
        emit(WeatherSucess(weather));
      } catch (e) {
        emit(WeatherFailure());
      }
    });
  }
}
