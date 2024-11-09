//the API seems to return forecast data for multiple points throughout the day, often in intervals (e.g., every 3 hours or every 6 hours).
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
  List<WeatherModel>? _forecast; // List to hold 5-day forecast data
  List<String> _dates = []; // List to hold dates

  @override
  void initState() {
    super.initState();
    fetchWeather(); // Fetch weather data on page load
    _generateDates(); // Generate dates to display
  }

  Future<void> fetchWeather() async {
    try {
      String cityName = await weatherService.getCurrentLocation();
      final weather = await weatherService.getWeather(cityName);
      final forecast = await weatherService.getFiveDayForecast(
          weather.latitude, weather.longitude);

      // Log the forecast data to check its structure and size
      print(forecast);
      if (forecast == null || forecast.isEmpty) {
        print("No forecast data received");
      } else {
        print("Forecast data: ${forecast.length} items");
      }

      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          _forecast = forecast;
        });
      }
    } catch (e) {
      print("Error fetching weather: $e");
    }
  }

  void _generateDates() {
    final now = DateTime.now();
    _dates = List.generate(5, (index) {
      final date = now.add(Duration(days: index));
      return "${date.month}-${date.day}";
    });

    // Log the generated dates to verify their correctness
    print("Generated Dates: $_dates");
  }

  String getWeatherIcon(String? mainCondition) {
    if (mainCondition == null) return 'assets/icons/sunny.png';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/icons/cloudy.png';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
      case 'thunderstorm':
        return 'assets/icons/rain.png';
      case 'clear':
        return 'assets/icons/sunny.png';
      default:
        return 'assets/icons/sunny.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator if forecast is null or empty
    if (_forecast == null || _forecast!.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF000000),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Check if the forecast data has enough entries to display (5 days)
    if (_forecast!.length < 5) {
      print("Incomplete forecast data");
      return Scaffold(
        backgroundColor: const Color(0xFF000000),
        body: Center(child: Text("Incomplete forecast data")),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: ListView.builder(
          itemCount: _forecast!.length,
          itemBuilder: (context, index) {
            // Ensure _dates and _forecast lengths are valid
            if (index >= _forecast!.length || index >= _dates.length) {
              return const SizedBox
                  .shrink(); // If there's no data, return an empty widget
            }

            bool isCurrentDay = index == 0; // Current day is the first card
            final dailyWeather = _forecast![index];

            return HourlyCard(
              conditionIcon: getWeatherIcon(dailyWeather.mainCondition),
              cityName: dailyWeather.cityName,
              temperature:
                  '${dailyWeather.temperature.toStringAsFixed(1)}°C', // Ensure two decimal places
              cardCenterName: _dates[index],
              windSpeed:
                  '${dailyWeather.windSpeed.toStringAsFixed(1)} m/s', // If needed, also apply for windSpeed
              humidity: '${dailyWeather.humidity}%',
              mainCondition: dailyWeather.mainCondition,
              precipitation:
                  '${dailyWeather.precipitation.toStringAsFixed(1)} mm', // If needed, apply for precipitation
              isCurrentDay: isCurrentDay,
            );
          },
        ),
      ),
    );
  }
}
