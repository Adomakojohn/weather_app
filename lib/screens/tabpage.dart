import 'package:flutter/material.dart';
import 'package:weather_app/screens/five_days_ahead_page.dart';
import 'package:weather_app/screens/home.dart';

class WeatherTabScreen extends StatelessWidget {
  const WeatherTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF000000),
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF1C1C1E),
                ),
                height: 37,
                width: 350,
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  dividerHeight: 0,
                  dividerColor: Colors.black,
                  tabs: const [
                    Tab(text: 'Today'),
                    Tab(text: '5 Days Ahead'),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    HomePage(),
                    FiveDaysAheadPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
