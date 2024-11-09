import 'package:flutter/material.dart';
import 'package:weather_app/widgets/city_card.dart';

class WeatherCard extends StatefulWidget {
  final String cityName;
  final String temperature;
  final String tempMin;
  final String tempMax;
  final String windSpeed;
  final String humidity;
  final String precipitation;
  final String mainCondition;
  final String conditionIcon;

  const WeatherCard({
    super.key,
    required this.cityName,
    required this.conditionIcon,
    required this.mainCondition,
    required this.temperature,
    required this.humidity,
    required this.precipitation,
    required this.tempMax,
    required this.tempMin,
    required this.windSpeed,
  });

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return Container(
      height: screenHeight * 0.316,
      width: screenWidth * 0.973,
      decoration: const ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF062D66),
            Color(0xFF316477),
          ],
          stops: [0.910, 1.0], // Adjusts color transition points
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
          Positioned(
            top: 50.4,
            left: 15,
            child: Text(
              widget.temperature,
              style: const TextStyle(
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
          ),
          Positioned(
            bottom: 20,
            left: 21,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        'assets/icons/humidity.png',
                        height: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      //humidity
                      widget.humidity,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        'assets/icons/wind-speed.png',
                        height: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      //wind speed
                      widget.windSpeed,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 21,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        widget.conditionIcon,
                        height: 23,
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget.mainCondition,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                // maximum day temperature
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        'assets/icons/arrow_up.png',
                        height: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget.tempMax,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                // minimum day temperature
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        'assets/icons/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget.tempMin,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 21,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        'assets/icons/precipitation.png',
                        height: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      //precipitation
                      widget.precipitation,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                /* const Text(
                  'Details..',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),  */
              ],
            ),
          ),
        ],
      ),
    );
  }
}
