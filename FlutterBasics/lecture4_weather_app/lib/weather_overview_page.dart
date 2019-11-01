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
          title: const Text('Weather Overview'),
        ),
        body: Center(
          child: FutureBuilder<Weather>(
            future: _weatherProvider.getCurrentWeather(),
            builder: (context, snapshot) {
              return OrientationBuilder(
                builder: (context, orientation) {
                  if (orientation == Orientation.portrait) {
                    if (snapshot.hasData) {
                      return WeatherContainer(weather: snapshot.data);
                    } else if (snapshot.hasError) {
                      return const Icon(Icons.network_locked);
                    }
                    return const CircularProgressIndicator();
                  } else {
                    return Text('lanscape');
                  }
                },
              );
            },
          ),
        ));
  }
}
