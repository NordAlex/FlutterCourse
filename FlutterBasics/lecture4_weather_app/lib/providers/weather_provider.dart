import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lecture4_weather_app/models/weather.dart';

class WeatherProvider {
  Future<Weather> getCurrentWeather() async {
    final response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=Kharkiv&units=metric&APPID=1ea55013049215603ece3fee22806975');
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
