class Weather {
  final int temperature;
  final String locationName;
  final String iconUrl;

  Weather(this.temperature, this.locationName, this.iconUrl);

    Weather.fromJson(Map<String, dynamic> json)
      : temperature = json['main']['temp'],
        locationName = json['name'],
        iconUrl = _generateIconUrl(json['weather'][0]['icon']);

  static String _generateIconUrl(String icon) {
    return 'https://openweathermap.org/img/wn/$icon@2x.png';
  }
}