import 'package:flutter/material.dart';
import 'package:weatherrad/models/services/weather_services.dart';
import 'package:weatherrad/models/weather_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
   final _weatherService = WeatherService('df8d6849364ff857c84a2d924105a215');
   Weather? _weather;

   _fetchWeather()async{
    String cityName = await _weatherService.getCurrentCity();
      
      try {
        final weather = await _weatherService.getWeather(cityName);
        setState(() {
          _weather = weather;
        });
      } catch (e) {
        print(e);
      }
   }
   //init state
    @override
    void initState(){
      super.initState();
      
      _fetchWeather();
    }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? "loading city..."),
            //temperature
            Text('${_weather?.temperature.round()} C'),
          ],
        ),
      ),
    );
  }
}