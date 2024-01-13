import 'package:flexify/pages/food/dashboardFood.dart';
import 'package:flexify/pages/profile/dashboardProfile.dart';
import 'package:flexify/pages/measurements/dashboardMeasurements.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:flexify/pages/workout/dashboardWorkout.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  final List<dynamic> dashboardOptions = [
    {
      'title': 'Workout',
      'widget': const DashboardWorkout(),
      'icon': Icons.fitness_center_rounded,
    },
    {
      'title': 'Food',
      'widget': const DashboardFood(),
      'icon': Icons.restaurant_rounded,
    },
    {
      'title': 'Measurements',
      'widget': const DashboardMeasurements(),
      'icon': Icons.bar_chart_rounded,
    },
    {
      'title': 'Profile',
      'widget': const DashboardProfile(),
      'icon': Icons.person,
    },
  ];

  Duration duration = const Duration(milliseconds: 250);
  double imageSize = 0.125;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).colorScheme.background,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              // HEADER
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: MediaQuery.of(context).size.width * imageSize,
                        height: MediaQuery.of(context).size.width * imageSize,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                        ),
                        child: Image.asset(
                          'assets/img/logo.png',
                          height: MediaQuery.of(context).size.width * imageSize,
                        ),
                      ),
                    ),
                    Text(
                      'flexify',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sacramento',
                        fontSize: 40,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      iconSize: 30,
                      icon: Icon(
                        Icons.more_horiz_rounded,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ],
                ),
              ),

              AnimatedSwitcher(
                duration: duration,
                child: SizedBox(
                  key: ValueKey(_selectedIndex),
                  child: dashboardOptions[_selectedIndex]['widget'],
                ),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // SPACING
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.025),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        child: GNav(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          padding: const EdgeInsets.only(top: 8, left: 5, right: 5),

          // COLORS
          tabBackgroundColor: Theme.of(context).colorScheme.surface,
          activeColor: Theme.of(context).focusColor,

          // CONTENT
          gap: 10,
          tabs: dashboardOptions
              .map(
                (e) => GButton(
                  icon: e['icon'],
                  text: e['title'],
                  padding: const EdgeInsets.all(15),
                  iconColor: Theme.of(context).scaffoldBackgroundColor,
                  iconActiveColor: Theme.of(context).focusColor,
                ),
              )
              .toList(),

          // FUNCTIONALITY
          selectedIndex: 0,
          duration: duration,
          onTabChange: (index) => setState(() {
            _selectedIndex = index;
          }),
        ),
      ),
    );
  }
}
