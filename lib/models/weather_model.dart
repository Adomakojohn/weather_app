class WeatherModel {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final int time;

  final double tempMin;
  final double precipitation;
  final double tempMax;
  final int humidity;
  final double windSpeed;
  final int sunset;
  final int sunrise;
  final double latitude;
  final double longitude;
  final int seaLevel;
  final int groundLevel;
  final String date;
  final String description;
  final double feelsLike;

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
    required this.sunset,
    required this.sunrise,
    required this.latitude,
    required this.longitude,
    required this.seaLevel,
    required this.groundLevel,
    required this.date,
    required this.description,
    required this.feelsLike,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    String formatDate(int timestamp) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}";
    }

    return WeatherModel(
      cityName: json['name'] ?? 'Unknown location',
      temperature: double.parse(json['main']['temp'].toStringAsFixed(2)),
      mainCondition: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      precipitation: double.parse(
          (json['rain'] != null ? (json['rain']['1h'] ?? 0.0) : 0.0)
              .toStringAsFixed(2)),
      tempMax: double.parse(json['main']['temp_max'].toStringAsFixed(2)),
      tempMin: double.parse(json['main']['temp_min'].toStringAsFixed(2)),
      windSpeed: double.parse(json['wind']['speed'].toStringAsFixed(2)),
      time: json['dt'],
      sunset: json['sys']['sunset'],
      sunrise: json['sys']['sunrise'],
      latitude: double.parse(json['coord']['lat'].toStringAsFixed(2)),
      longitude: double.parse(json['coord']['lon'].toStringAsFixed(2)),
      seaLevel: json['main']['sea_level'] ?? 0,
      groundLevel: json['main']['grnd_level'] ?? 0,
      date: formatDate(json['dt']),
      description: json['weather'][0]['description'],
      feelsLike: double.parse(json['main']['feels_like'].toStringAsFixed(2)),
    );
  }

  @override
  String toString() {
    return 'WeatherModel(cityName: $cityName, temperature: $temperature, windSpeed: $windSpeed, humidity: $humidity, description: $description, precipitation: $precipitation)';
  }
}
