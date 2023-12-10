import 'package:flexify/pages/food/dashboardFood.dart';
import 'package:flexify/pages/profile/dashboardProfile.dart';
import 'package:flexify/pages/measurements/dashboardStatistics.dart';
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
      'title': 'Statistics',
      'widget': const DashboardStatistics(),
      'icon': Icons.bar_chart_rounded,
    },
    {
      'title': 'Profile',
      'widget': const DashboardProfile(),
      'icon': Icons.person,
    },
  ];

  Duration duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).colorScheme.background,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
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
      ),
      // SPACING
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        child: GNav(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 5, right: 5),

          // COLORS
          // 
          tabBackgroundColor: Theme.of(context).colorScheme.background,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
          activeColor: Theme.of(context).colorScheme.primary,

          // CONTENT
          gap: 10,
          tabs: dashboardOptions
              .map(
                (e) => GButton(
                  icon: e['icon'],
                  text: e['title'],
                  padding: const EdgeInsets.all(15),
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
