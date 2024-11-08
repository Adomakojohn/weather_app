import 'package:flutter/material.dart';
import 'package:weather_app/widgets/hourly_card.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';

class FiveDaysAheadPage extends StatefulWidget {
  const FiveDaysAheadPage({super.key});

  @override
  State<FiveDaysAheadPage> createState() => _FiveDaysAheadPageState();
}

class _FiveDaysAheadPageState extends State<FiveDaysAheadPage> {
  final WeatherService weatherService =
      WeatherService('1772a4af222b2bfa4cc0f65b3c04714d');
  WeatherModel? _weather;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return HourlyCard(
                      cardCenterName: 'May 05',
                      temperature: _weather != null
                          ? '${_weather!.temperature.round()}°C'
                          : '...');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
