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
  List<String> _dates = [];

  Future<void> fetchWeather() async {
    try {
      String cityName = await weatherService.getCurrentLocation();
      final weather = await weatherService.getWeather(cityName);

      setState(() {
        _weather = weather;
        _generateDates(); // Generate the dates after fetching the weather
      });
    } catch (e) {
      print(e);
    }
  }

  // Generate the list of dates for the next 5 days, including today
  void _generateDates() {
    final now = DateTime.now();
    _dates = List.generate(5, (index) {
      final date = now.add(Duration(days: index));
      return "${date.month}-${date.day}";
    });
  }

  @override
  void initState() {
    super.initState();
    fetchWeather(); // Fetch weather data on page load
  }

  @override
  Widget build(BuildContext context) {
    // Ensure _weather is not null before using the _dates list
    if (_weather == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF000000),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            bool isCurrentDay =
                index == 0; // Current day is always the first card

            return HourlyCard(
              cardCenterName: _dates[index],
              temperature: _weather != null
                  ? '${_weather!.temperature.round()}°C'
                  : '...',
              isCurrentDay:
                  isCurrentDay, // Pass isCurrentDay to highlight the card
            );
          },
        ),
      ),
    );
  }
}
