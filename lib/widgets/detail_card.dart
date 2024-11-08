import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final String sunset;
  final String sunrise;
  final String latitude;
  final String longitude;
  final String seaLevel;
  final String groundLevel;
  final String date;
  final String description;
  final String feelsLike;

  const DetailCard({
    super.key,
    required this.sunset,
    required this.sunrise,
    required this.latitude,
    required this.longitude,
    required this.seaLevel,
    required this.groundLevel,
    required this.date,
    required this.description,
    required this.feelsLike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      alignment: Alignment.center,
      width: 490,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF000000),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                title: const Text("Description",
                    style: TextStyle(color: Colors.white)),
                subtitle: Text(description,
                    style: const TextStyle(color: Colors.white70)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                title: const Text("Feels Like",
                    style: TextStyle(color: Colors.white)),
                subtitle: Text(feelsLike,
                    style: const TextStyle(color: Colors.white70)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                title: const Text("Sunrise",
                    style: TextStyle(color: Colors.white)),
                subtitle: Text(sunrise,
                    style: const TextStyle(color: Colors.white70)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                tileColor: const Color(0xFF1C1C1E),
                title:
                    const Text("Sunset", style: TextStyle(color: Colors.white)),
                subtitle:
                    Text(sunset, style: const TextStyle(color: Colors.white70)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                title: const Text("Latitude",
                    style: TextStyle(color: Colors.white)),
                subtitle: Text(latitude,
                    style: const TextStyle(color: Colors.white70)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                title: const Text("Longitude",
                    style: TextStyle(color: Colors.white)),
                subtitle: Text(longitude,
                    style: const TextStyle(color: Colors.white70)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                title:
                    const Text("Date", style: TextStyle(color: Colors.white)),
                subtitle:
                    Text(date, style: const TextStyle(color: Colors.white70)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                title: const Text("Sea Level",
                    style: TextStyle(color: Colors.white)),
                subtitle: Text(seaLevel,
                    style: const TextStyle(color: Colors.white70)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                title: const Text("Ground Level",
                    style: TextStyle(color: Colors.white)),
                subtitle: Text(groundLevel,
                    style: const TextStyle(color: Colors.white70)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
