import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/widgets/hourly_card.dart';
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
              const SizedBox(
                height: 10,
              ),
              Center(
                child: WeatherCard(
                  temperature: _weather != null
                      ? '${_weather!.temperature.round()}°C'
                      : '...',
                  cityName: _weather?.cityName ?? "Loading city...",
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  top: 15,
                ),
                child: Text(
                  'Hourly Weather',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Center(
                child: SizedBox(
                  height: 950,
                  width: 390,
                  child: ListView.builder(
                    itemCount: 6,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return HourlyCard(
                        cardCenterName: '00 : 00',
                        temperature: _weather != null
                            ? '${_weather!.temperature.round()}°C'
                            : '...',
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
