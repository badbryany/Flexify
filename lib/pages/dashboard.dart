import 'dart:convert';

import 'package:flexify/pages/food/dashboardFood.dart';
import 'package:flexify/pages/leaderboards/dashboardLeaderboards.dart';
import 'package:flexify/pages/profile/dashboardProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:http/http.dart' as http;

import 'package:flexify/pages/workout/dashboardWorkout.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings/settingsPage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  bool gotRequests = false;

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
      'title': 'Leaderboards',
      'widget': const DashboardLeaderboards(),
      'icon': Icons.bar_chart_rounded,
    },
    {
      'title': 'Profile',
      'widget': const DashboardProfile(),
      'icon': Icons.person,
    },
  ];

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    http.Response res = await http.get(Uri.parse(
        '${global.host}/getFriendshipRequests?jwt=${prefs.getString('jwt')}'));

    if ((jsonDecode(res.body) as List).isNotEmpty) {
      gotRequests = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).colorScheme.background,
        systemNavigationBarIconBrightness: Theme.of(context).brightness,
      ),
    );
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Image.asset(
                        global.isDarkMode(context)
                            ? 'assets/logo/darklogo.png'
                            : 'assets/logo/lightlogo.png',
                        width: MediaQuery.of(context).size.width * 0.11,
                        height: MediaQuery.of(context).size.width * 0.11,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Text(
                        'Flexify',
                        style: TextStyle(
                          color: Theme.of(context).focusColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1,
                          fontSize: global.width(context) * 0.07,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.12,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsPage(),
                            ),
                          );
                        },
                        iconSize: 30,
                        icon: Icon(
                          Icons.more_horiz_rounded,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      )
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: global.standardAnimationDuration,
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
                  (e) => e['title'] == 'Profile'
                      ? GButton(
                          icon: e['icon'],
                          text: e['title'],
                          padding: const EdgeInsets.all(15),
                          textStyle: gotRequests
                              ? TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              : null,
                          iconColor: gotRequests
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onBackground,
                          iconActiveColor: gotRequests
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onBackground,
                        )
                      : GButton(
                          icon: e['icon'],
                          text: e['title'],
                          padding: const EdgeInsets.all(15),
                          iconColor: Theme.of(context).colorScheme.onBackground,
                          iconActiveColor:
                              Theme.of(context).colorScheme.onBackground,
                        ),
                )
                .toList(),

            // FUNCTIONALITY
            selectedIndex: _selectedIndex,
            duration: global.standardAnimationDuration,
            onTabChange: (index) => setState(() {
              _selectedIndex = index;
            }),
          ),
        ),
      ),
    );
  }
}
