class WeatherModel {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final int time;
  final double tempMin;
  final String? precipitation;
  final double tempMax;
  final int humidity;
  final double windSpeed;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.time,
    required this.precipitation,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? 'Unknown location',
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      precipitation: json['rain']['1h'].toString(),
      tempMax: json['main']['temp_max'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
      time: json['dt'],
    );
  }
}
