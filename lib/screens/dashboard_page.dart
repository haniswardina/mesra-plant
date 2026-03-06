import 'package:flutter/material.dart';
import '../models/plant.dart';

import 'home_page.dart';
import 'my_plants_page.dart';
import 'care_tools_page.dart';
import 'shops_page.dart';
import 'chatbot_page.dart';
import 'device_page.dart';
import 'vacation_page.dart';

class DashboardPage extends StatefulWidget {
  final String username;

  DashboardPage({required this.username});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int currentIndex = 3;

  // 🌿 CENTRAL PLANT LIST HERE
  List<Plant> plants = [
    Plant(
      name: "Rose",
      image: "🌹",
      ph: 6.5,
      moisture: 70.0,
      potSize: 3.0,
      type: "Flowering",
    ),
    Plant(
      name: "Monstera",
      image: "🌿",
      ph: 6.8,
      moisture: 60.0,
      potSize: 5.0,
      type: "Tropical",
    ),
  ];

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      MyPlantsPage(plants: plants),
      CareToolsPage(),
      ShopsPage(),
      HomePage(username: widget.username),
      ChatbotPage(),
      DevicePage(),
      VacationPage(plants: plants), // ✅ FIXED
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlue.shade100,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.local_florist), label: "Plants"),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: "Tools"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Shops"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: "AI"),
          BottomNavigationBarItem(icon: Icon(Icons.memory), label: "Device"),
          BottomNavigationBarItem(icon: Icon(Icons.beach_access), label: "Vacation"),
        ],
      ),
    );
  }
}