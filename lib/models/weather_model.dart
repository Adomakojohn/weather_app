//sunset
//sunrise
//lattitude
//longitude
//sea level
//ground level
//date
// description
// feels like
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
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      precipitation: json['rain'] != null ? (json['rain']['1h'] ?? 0.0) : 0.0,
      tempMax: json['main']['temp_max'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
      time: json['dt'],
      sunset: json['sys']['sunset'],
      sunrise: json['sys']['sunrise'],
      latitude: json['coord']['lat'].toDouble(),
      longitude: json['coord']['lon'].toDouble(),
      seaLevel: json['main']['sea_level'] ?? 0,
      groundLevel: json['main']['grnd_level'] ?? 0,
      date: formatDate(json['dt']),
      description: json['weather'][0]['description'],
      feelsLike: json['main']['feels_like'].toDouble(),
    );
  }
}
