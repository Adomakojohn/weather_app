import 'package:flutter/material.dart';

class CityCard extends StatelessWidget {
  final String cityName;
  const CityCard({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
        border: Border(
          bottom: BorderSide(color: Colors.white),
          top: BorderSide(color: Colors.white),
          left: BorderSide(color: Colors.white),
          right: BorderSide(color: Colors.white),
        ),
      ),
      child: Text(
        cityName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 19,
        ),
      ),
    );
  }
}
