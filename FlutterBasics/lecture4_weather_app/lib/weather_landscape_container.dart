import 'package:flutter/material.dart';
import 'package:lecture4_weather_app/weather.dart';

class WeatherLandscapeContainer extends StatelessWidget {
  const WeatherLandscapeContainer({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Text(
            '${weather.locationName}: ${weather.temperature} °C',
            style: Theme.of(context).textTheme.display1,
            textAlign: TextAlign.center,
          ),
          Image.network(weather.iconUrl),
        ],
      ),
    );
  }
}
