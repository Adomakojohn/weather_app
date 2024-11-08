import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
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
      'http://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> forecastData = data['list'];

      return forecastData.map((entry) => WeatherModel.fromJson(entry)).toList();
    } else {
      throw Exception('Failed to load 5-day weather forecast');
    }
  }
}
