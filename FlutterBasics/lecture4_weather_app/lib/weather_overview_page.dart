import 'package:flutter/material.dart';
import 'package:lecture4_weather_app/weather.dart';
import 'package:lecture4_weather_app/weather_landscape_container.dart';
import 'package:lecture4_weather_app/weather_portrait_container.dart';
import 'package:lecture4_weather_app/weather_provider.dart';

class WeatherOverviewPage extends StatelessWidget {
  final _weatherProvider = WeatherProvider();

  final _title = 'Weather Overview';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: SafeArea(child: _fetchWeatherInfo()));
  }

  Widget _fetchWeatherInfo() {
    return FutureBuilder<Weather>(
      future: _weatherProvider.getCurrentWeather(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _showResult(snapshot.data);
        } else if (snapshot.hasError) {
          return _showError();
        }
        return _showProgresIndicator();
      },
    );
  }

  Widget _showResult(Weather weather) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return WeatherPortraitContainer(weather: weather);
      } else {
        return WeatherLandscapeContainer(weather: weather);
      }
    });
  }

  Widget _showProgresIndicator() => const CircularProgressIndicator();

  Widget _showError() => const Icon(Icons.network_locked);
}
