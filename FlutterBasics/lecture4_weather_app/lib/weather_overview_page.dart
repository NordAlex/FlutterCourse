
import 'package:flutter/material.dart';
import 'package:lecture4_weather_app/weather.dart';
import 'package:lecture4_weather_app/weather_container.dart';
import 'package:lecture4_weather_app/weather_provider.dart';

class WeatherOverviewPage extends StatelessWidget {
final _weatherProvider = WeatherProvider();

@override
Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    title: Text("Weather Overview"),
  ),
  body: Center(
    child: FutureBuilder<Weather>(
      future: _weatherProvider.getCurrentWeather(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return WeatherContainer(weather: snapshot.data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    ),
  ),
);
}
}
