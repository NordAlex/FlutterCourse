class Weather { 

  Weather.fromJson(Map<String, dynamic> json)
      : temperature = json['main']['temp'],
        locationName = json['name'],
        pressure = json['main']['pressure'],
        humidity = json['main']['humidity'],
        iconUrl = _generateIconUrl(json['weather'][0]['icon']);

  final int temperature;
  final String locationName;
  final String iconUrl;
  final int pressure;
  final int humidity;

  static String _generateIconUrl(String icon) {
    return 'https://openweathermap.org/img/wn/$icon@2x.png';
  }
}
