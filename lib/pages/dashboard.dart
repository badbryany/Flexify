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
    const Center(
      child: Text(
        'Food',
        style: TextStyle(fontSize: 50),
      ),
    ),
    const Center(
      child: Text(
        'Statistics',
        style: TextStyle(fontSize: 50),
      ),
    ),
    const Center(
      child: Text(
        'Profile',
        style: TextStyle(fontSize: 50),
      ),
    ),
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
            padding: const EdgeInsets.only(top: 8, bottom: 8, right: 10),

            // COLOURS
            backgroundColor: Color.fromRGBO(29, 29, 29, 1),
            tabBackgroundColor: Color.fromARGB(255, 37, 37, 37),
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
