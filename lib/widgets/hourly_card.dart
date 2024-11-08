import 'package:flutter/material.dart';
import 'package:weather_app/widgets/city_card.dart';

class HourlyCard extends StatelessWidget {
  final String temperature;
  final String cardCenterName;
  final bool isCurrentDay;

  const HourlyCard({
    super.key,
    required this.temperature,
    required this.cardCenterName,
    required this.isCurrentDay, // Accept isCurrentDay as a parameter
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;

    // Determine whether it's daytime or nighttime (6 AM to 6 PM as day, otherwise night)
    int currentHour = DateTime.now().hour;
    bool isDay = currentHour >= 6 && currentHour < 18;

    // Set the color for the current day
    Color cardColor = isCurrentDay
        ? (isDay
            ? Colors.blue
            : Colors.deepPurple) // Blue if daytime, deep blue if nighttime
        : const Color(
            0xFF1C1C1E); // Default color for other days // Blue for current day, gray for others

    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Container(
        height: 142,
        width: screenWidth * 0.999,
        decoration: BoxDecoration(
          color: cardColor, // Apply the selected color
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            // City name
            const Positioned(
              top: 10,
              left: 10,
              child: CityCard(cityName: 'Kumasi'),
            ),
            // Temperature
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
            // Humidity, Precipitation, etc.
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
                      const SizedBox(width: 3),
                      const Text(
                        'Clear',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Image.asset(
                          'assets/icons/precipitation.png',
                          height: 14,
                        ),
                      ),
                      const SizedBox(width: 3),
                      const Text(
                        '0mm',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
            // Date and Humidity
            Positioned(
              top: 20,
              right: 151,
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 3),
                      Text(
                        cardCenterName,
                        style: const TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Image.asset(
                          'assets/icons/humidity.png',
                          height: 14,
                        ),
                      ),
                      const SizedBox(width: 3),
                      const Text(
                        '30%',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Image.asset(
                          'assets/icons/wind-speed.png',
                          height: 14,
                        ),
                      ),
                      const SizedBox(width: 3),
                      const Text(
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
          ],
        ),
      ),
    );
  }
}
