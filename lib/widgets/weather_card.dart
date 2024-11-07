import 'package:flutter/material.dart';
import 'package:weather_app/widgets/city_card.dart';

class WeatherCard extends StatefulWidget {
  final String cityName;
  const WeatherCard({super.key, required this.cityName});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 262,
      width: 361,
      decoration: const ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF062D66),
            Color(0xFF316477),
          ],
          stops: [0.755, 1.0], // Adjusts color transition points
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 15,
            left: 10,
            child: CityCard(
              cityName: widget.cityName,
            ),
          ),
          const Positioned(
            top: 50.4,
            left: 15,
            child: Text(
              '20°C',
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ),
          const Positioned(
            bottom: 95,
            left: 21,
            child: SizedBox(
              width: 320,
              child: Divider(
                thickness: 0.2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
