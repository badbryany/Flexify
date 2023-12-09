import 'package:flexify/pages/dashboardFood.dart';
import 'package:flexify/pages/dashboardProfile.dart';
import 'package:flexify/pages/dashboardStatistics.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flexify/pages/dashboardWorkout.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  final List<Widget> dashboardOptions = [
    const DashboardWorkout(),
    const DashboardFood(),
    const DashboardStatistics(),
    const DashboardProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: dashboardOptions.elementAt(_selectedIndex),
      ),
      // SPACING
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(29, 29, 29, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: GNav(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 5, right: 5),

            // COLOURS
            backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
            tabBackgroundColor: const Color.fromARGB(255, 37, 37, 37),
            color: Colors.white54,
            activeColor: Colors.white,

            // CONTENT
            tabs: const [
              GButton(
                icon: Icons.anchor,
                gap: 10,
                text: 'Workout',
              ),
              GButton(
                icon: Icons.free_breakfast,
                gap: 10,
                text: 'Food',
              ),
              GButton(
                icon: Icons.data_exploration,
                gap: 10,
                text: 'Statistics',
              ),
              GButton(
                icon: Icons.face,
                gap: 10,
                text: 'Profile',
              ),
            ],

            // FUNCTIONALITY
            selectedIndex: 0,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            
          ),
        ),
      ),
    );
  }
}
