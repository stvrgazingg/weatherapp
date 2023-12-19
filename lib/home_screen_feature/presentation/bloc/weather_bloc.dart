import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weatherapp/data/model/fetch_weather_model.dart';


import '../../../data/service/fetch_weather_service.dart';


part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await WeatherS().getWeather(event.cityName);
        emit(WeatherSucess(weather));
      } catch (e) {
        emit(WeatherFailure());
      }
    });
  }
}
