class WeatherModel {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final int time;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.time,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      time: json['dt'],
    );
  }
}
