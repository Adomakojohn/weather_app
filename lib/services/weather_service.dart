import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  static const FORECAST_URL = 'http://api.openweathermap.org/data/2.5/forecast';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<WeatherModel> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are denied');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    return placemarks[0].locality ?? 'Unknown location';
  }

/*  Future<List<WeatherModel>> getHourlyForecast(
      double latitude, double longitude) async {
    final url = Uri.parse(
      'http://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=current,minutely,daily,alerts&units=metric&appid=$apiKey',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> hourlyData = data['hourly'];

        return hourlyData.map((hour) {
          return WeatherModel(
            precipitation:
                hour['rain'] != null ? hour['rain']['1h'].toString() : '0',
            cityName: data['timezone'],
            temperature: hour['temp'].toDouble(),
            mainCondition: hour['weather'][0]['main'],
            humidity: hour['humidity'],
            tempMax: hour['temp'],
            tempMin: hour['temp'],
            windSpeed: hour['wind_speed'].toDouble(),
            time: hour['dt'],
          );
        }).toList();
      } else {
        throw Exception('Failed to load hourly weather data');
      }
    } catch (e) {
      throw Exception('Error fetching hourly weather data: $e');
    }
  }   */

  Future<List<WeatherModel>> getFiveDayForecast(
      double latitude, double longitude) async {
    final url = Uri.parse(
        '$FORECAST_URL?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> forecastData = data['list'];

      Map<String, List<dynamic>> dailyData = {};

      for (var entry in forecastData) {
        final dateTime =
            DateTime.fromMillisecondsSinceEpoch(entry['dt'] * 1000);
        final dateKey = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
        dailyData.putIfAbsent(dateKey, () => []).add(entry);
      }

      List<WeatherModel> dailyForecasts = dailyData.entries.map((dayEntry) {
        final dailyEntries = dayEntry.value;
        double tempSum = 0;
        double humiditySum = 0;
        double windSpeedSum = 0;
        int count = dailyEntries.length;

        for (var entry in dailyEntries) {
          tempSum += entry['main']['temp'];
          humiditySum += entry['main']['humidity'];
          windSpeedSum += entry['wind']['speed'];
        }

        final sampleEntry = dailyEntries.first;
        return WeatherModel(
          cityName: data['city']['name'],
          temperature: double.parse(
              (tempSum / count).toStringAsFixed(2)), // Round temperature
          mainCondition: sampleEntry['weather'][0]['main'],
          time: sampleEntry['dt'],
          tempMin: double.parse(sampleEntry['main']['temp_min']
              .toStringAsFixed(2)), // Round tempMin
          tempMax: double.parse(sampleEntry['main']['temp_max']
              .toStringAsFixed(2)), // Round tempMax
          humidity: (humiditySum / count).round(),
          windSpeed: double.parse(
              (windSpeedSum / count).toStringAsFixed(2)), // Round windSpeed
          precipitation: double.parse((sampleEntry['rain']?['3h'] ?? 0.0)
              .toStringAsFixed(2)), // Round precipitation
          sunset: data['city']['sunset'],
          sunrise: data['city']['sunrise'],
          latitude: double.parse(data['city']['coord']['lat']
              .toStringAsFixed(2)), // Round latitude
          longitude: double.parse(data['city']['coord']['lon']
              .toStringAsFixed(2)), // Round longitude
          seaLevel: sampleEntry['main']['sea_level'] ?? 0,
          groundLevel: sampleEntry['main']['grnd_level'] ?? 0,
          date: dayEntry.key,
          description: sampleEntry['weather'][0]['description'],
          feelsLike: double.parse(sampleEntry['main']['feels_like']
              .toStringAsFixed(2)), // Round feelsLike
        );
      }).toList();

      return dailyForecasts;
    } else {
      throw Exception('Failed to load 5-day weather forecast');
    }
  }
}
