import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
    
       String getWeatherAnimation(String? mainCondition){
      if (mainCondition == null ) return 'assets/images/suuny.json';

      switch (mainCondition.toLowerCase()) {
        case 'clouds':
        case 'mist':
        case 'smoke':
        case 'haze':
        case 'dust':
        case 'fog':
        return 'assets/images/cloud.json';
           case 'rain':
        case 'drizzle':
        case 'shower rain':
        return 'assets/images/rain.json';
           case 'thunderstorm':
           return 'assets/images/thunder.json';
         case 'clear':
         return 'assets/images/sunny.json';
         default:
         return 'assets/images/sunny.json';
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
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text('${_weather?.temperature.round()} C'),
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}