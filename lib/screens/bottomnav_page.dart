import 'package:flutter/material.dart';

import 'package:weather_app/screens/search_page.dart';
import 'package:weather_app/screens/tabpage.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavBarpageState();
}

class _BottomNavBarpageState extends State<BottomNavPage> {
  int currentIndex = 0;

  final List _pages = [
    const WeatherTabScreen(),
    const SearchPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          enableFeedback: false,
          backgroundColor: const Color(0xFF000000),
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Image.asset(
                'assets/icons/home-icon.png',
                height: 22,
              ),
            ),
            const BottomNavigationBarItem(
                label: 'Search',
                icon: Icon(
                  Icons.search,
                  size: 22,
                )),
          ],
        ),
      ),
    );
  }
}
