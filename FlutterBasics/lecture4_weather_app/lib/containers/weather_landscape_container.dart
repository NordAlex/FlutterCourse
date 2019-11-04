import 'package:flutter/material.dart';
import 'package:lecture4_weather_app/models/weather.dart';

class WeatherLandscapeContainer extends StatelessWidget {
  const WeatherLandscapeContainer({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildTitle(context),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildMainInfoColumn(context),
            _buildWeatherIndicator()
          ],
        )
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      weather.locationName,
      style: Theme.of(context).textTheme.display1,
    );
  }

  Widget _buildMainInfoColumn(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Teperature ${weather.temperature} °C',
          style: Theme.of(context).textTheme.title,
        ),
        Text(
          'Pressure: ${weather.pressure} Pa',
          style: Theme.of(context).textTheme.title,
        ),
        Text(
          'Humidity: ${weather.humidity} %',
          style: Theme.of(context).textTheme.title,
        ),
      ],
    );
  }

  Widget _buildWeatherIndicator() => Image.network(weather.iconUrl);
}
