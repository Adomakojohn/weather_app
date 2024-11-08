import 'package:flutter/material.dart';
import 'package:weather_app/widgets/city_card.dart';

class HourlyCard extends StatelessWidget {
  final String temperature;
  final String cardCenterName;
  const HourlyCard(
      {super.key, required this.temperature, required this.cardCenterName});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Container(
        height: 142,
        width: screenWidth * 0.999,
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            //time
            //cityname
            const Positioned(
              top: 10,
              left: 10,
              child: CityCard(cityName: 'Kumasi'),
            ),
            //temperature,
            Positioned(
              top: 62.4,
              left: 15,
              child: Text(
                temperature,
                style: const TextStyle(
                  fontSize: 43,
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(173, 235, 235, 245),
                ),
              ),
            ),
            const Positioned(
              top: 52,
              left: 110,
              child: SizedBox(
                height: 80,
                child: VerticalDivider(
                  thickness: 1,
                  color: Colors.grey,
                  width: 20,
                  indent: 15,
                  endIndent: 15,
                ),
              ),
            ),

            //humidity
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
                          'assets/icons/moon.png',
                          height: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const Text(
                        'Clear',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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
                      const Text(
                        //precipitation
                        '0mm',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Details..',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              right: 151,
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        cardCenterName,
                        style: const TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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
                      const Text(
                        //humidity
                        '30%',
                        style: TextStyle(
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
                      const Text(
                        //wind speed
                        '40 m/s',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //windspeed
            //precipitation
          ],
        ),
      ),
    );
  }
}
