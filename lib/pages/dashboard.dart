import 'dart:convert';

import 'package:flexify/pages/dPlan/dashboardPlan.dart';
import 'package:flexify/pages/dShop/dashboardShop.dart';
import 'package:flexify/pages/dStats/dashboardStats.dart';
import 'package:flexify/pages/dProfile/dashboardProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:http/http.dart' as http;

import 'package:flexify/pages/dWorkout/dashboardWorkout.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings/settingsPage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 2;
  bool gotRequests = false;

  bool _isDesposed = false;

  final List<dynamic> dashboardOptions = [
    {
      'title': 'Shop',
      'widget': const DashboardShop(),
      'icon': Icons.shopping_bag_outlined,
    },
    {
      'title': 'Plan',
      'widget': const DashboardPlan(),
      'icon': Icons.event_note_rounded
    },
    {
      'title': 'Workout',
      'widget': const DashboardWorkout(),
      'icon': Icons.fitness_center_rounded,
    },
    {
      'title': 'Stats',
      'widget': const DashboardStats(),
      'icon': Icons.bar_chart_rounded,
    },
    {
      'title': 'Profile',
      'widget': const DashboardProfile(),
      'icon': Icons.person,
    },
  ];

  getData() async {
    if (_isDesposed) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    http.Response res = await http.get(Uri.parse(
        '${global.host}/getFriendshipRequests?jwt=${prefs.getString('jwt')}'));

    if (res.body == 'jwt not valid') {
      debugPrint('jwt not valid');
      return;
    }

    if ((jsonDecode(res.body) as List).isNotEmpty) {
      gotRequests = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    _isDesposed = false;
    super.initState();
  }

  @override
  void dispose() {
    _isDesposed = true;
    super.dispose();
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
        appBar: AppBar(),
        body: SafeArea(
          child: SizedBox(
            width: global.width(context),
            height: global.height(context),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                // HEADER
                Container(
                  width: global.width(context),
                  height: global.height(context) * 0.1,
                  padding: EdgeInsets.only(
                    left: global.width(context) * 0.1,
                    right: global.width(context) * 0.1,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        global.isDarkMode(context)
                            ? 'assets/logo/darklogo.png'
                            : 'assets/logo/lightlogo.png',
                        width: global.width(context) * 0.11,
                        height: global.width(context) * 0.11,
                      ),
                      Container(
                        width: global.width(context) * .5,
                        alignment: Alignment.center,
                        child: AnimatedSwitcher(
                          duration: global.standardAnimationDuration,
                          child: Text(
                            dashboardOptions[_selectedIndex]['title'],
                            key: ValueKey(
                              dashboardOptions[_selectedIndex]['title'],
                            ),
                            style: TextStyle(
                              color: Theme.of(context).focusColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -1,
                              fontSize: global.width(context) * 0.08,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsPage(),
                            ),
                          );
                        },
                        iconSize: global.width(context) * .0675,
                        icon: Icon(
                          Icons.settings_rounded,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
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
                    child: SlideTransition(
                      position: animation.drive(
                        Tween(
                          begin: const Offset(0, .2),
                          end: const Offset(0, 0),
                        ),
                      ),
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
          padding:
              EdgeInsets.symmetric(vertical: global.height(context) * 0.025),
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
                    textColor: Theme.of(context).colorScheme.onSurface,
                    iconColor: Theme.of(context).colorScheme.onSurface,
                    iconActiveColor: Theme.of(context).colorScheme.onSurface,
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
