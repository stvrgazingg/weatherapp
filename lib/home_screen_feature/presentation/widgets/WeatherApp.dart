import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weatherapp/home_screen_feature/presentation/widgets/temps/temps_display.dart';
import 'package:weatherapp/home_screen_feature/presentation/widgets/tiles/tiles_display.dart';
import 'package:weatherapp/home_screen_feature/presentation/widgets/toolbar/city_name.dart';
import 'package:weatherapp/home_screen_feature/presentation/widgets/toolbar/location_button.dart';
import 'package:weatherapp/home_screen_feature/presentation/widgets/toolbar/refresh_button.dart';

import '../bloc/weather_bloc.dart';



import 'icon_description_column/description.dart';
import 'icon_description_column/icon.dart';
import 'invalid_city_screen.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => WeatherAppState();
}

bool invalidCity = false;
Color buttonColor = const Color.fromARGB(255, 113, 100, 138);

class WeatherAppState extends State<WeatherApp> {
  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherSucess) {

          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
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
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LocationButton(),
                          SizedBox(
                            width: 10,
                          ),
                          CityName(),
                          SizedBox(
                            width: 10,
                          ),
                          RefreshButton(),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 250, height: 0),
                              Column(
                                children: [
                                  WeatherIcon(
                                      state.weather.weather?[0].icon ?? ""),
                                  Description(
                                      state.weather.weather?[0].description ??
                                          ""),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      TempsDisplay(
                          (state.weather.main?.temp),
                          (state.weather.main?.tempMax),
                          (state.weather.main?.tempMin)
                          )
                    ],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 480),
                    Container(
                        decoration: const BoxDecoration(
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
                          child: TilesDisplay(
                              state.weather.main?.pressure.toString(),
                              state.weather.main?.feelsLike,
                              state.weather.main?.humidity,
                              state.weather.wind?.speed.toString() ),
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
            return const Scaffold(
                body: Center(
              child: InvalidCityScreen(),
            ));
          } catch (e) {
            return const Icon(Icons.error, size: 300);
          }
        } else {
          try {
            invalidCity = true;
            return const Icon(Icons.error_sharp, size: 300);
          } catch (e) {
            return const Icon(Icons.error, size: 300);
          }
        }
      },
    );
  }
}
