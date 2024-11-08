import 'package:flutter/material.dart';

import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/widgets/detail_card.dart';

import 'package:weather_app/widgets/weather_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService weatherService =
      WeatherService('1772a4af222b2bfa4cc0f65b3c04714d');
  WeatherModel? _weather;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    try {
      String cityName = await weatherService.getCurrentLocation();
      final weather = await weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String formatTime(int timestamp) {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Center(
                child: WeatherCard(
                  precipitation: '${_weather?.precipitation ?? "0.0"} mm',
                  mainCondition: _weather?.mainCondition ?? "...",
                  windSpeed: _weather != null
                      ? '${_weather!.windSpeed.round()} m/s'
                      : '...',
                  tempMin: _weather != null
                      ? '${_weather!.tempMin.round()}°'
                      : '...',
                  tempMax: _weather != null
                      ? '${_weather!.tempMax.round()}°'
                      : '...',
                  humidity: _weather != null
                      ? '${_weather!.humidity.round()}%'
                      : '...',
                  temperature: _weather != null
                      ? '${_weather!.temperature.round()}°C'
                      : '...',
                  cityName: _weather?.cityName ?? "Loading city...",
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 15),
                child: Text(
                  'DETAILS',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              DetailCard(
                sunset:
                    '${_weather != null ? formatTime(_weather!.sunset) : "..."} PM',
                sunrise:
                    '${_weather != null ? formatTime(_weather!.sunrise) : "..."} AM',
                latitude:
                    _weather != null ? "${_weather!.latitude.round()}" : "...",
                longitude:
                    _weather != null ? "${_weather!.longitude.round()}" : "...",
                seaLevel: _weather != null ? "${_weather!.seaLevel} m" : "...",
                groundLevel:
                    _weather != null ? "${_weather!.groundLevel} m" : "...",
                date: "${_weather?.date ?? "..."}",
                description: _weather != null ? _weather!.description : "...",
                feelsLike: _weather != null
                    ? '${_weather!.feelsLike.round()}°C'
                    : '...',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
