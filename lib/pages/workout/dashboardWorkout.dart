import 'package:flutter/material.dart';

import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/widgets/dashboardXOptionButton.dart';
import 'package:flexify/pages/workout/workoutPage.dart';

class DashboardWorkout extends StatefulWidget {
  const DashboardWorkout({super.key});

  @override
  State<DashboardWorkout> createState() => _DashboardWorkoutState();
}

class _DashboardWorkoutState extends State<DashboardWorkout> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        WorkoutDashboard(),
        SizedBox(height: 10),
        DashboardXOptionButton(
          title: 'Recommended Workout',
          targetPage: WorkoutPage(),
          content: Text(''),
        ),
        SizedBox(height: 10),
        DashboardXOptionButton(
          title: 'Custom Workout',
          targetPage: WorkoutPage(),
          content: Text(''),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

class WorkoutDashboard extends StatefulWidget {
  const WorkoutDashboard({super.key});

  @override
  State<WorkoutDashboard> createState() => _WorkoutDashboardState();
}

class _WorkoutDashboardState extends State<WorkoutDashboard> {
  List<DateTime> dates = [
    DateTime.now().subtract(const Duration(days: 3)),
    DateTime.now().subtract(const Duration(days: 2)),
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.now(),
  ];

  List<int> intensityPerDay = [0, 0, 0, 0];
  int selectedIintensity = 2; // yesterday

  getData() async {
    List<Set> sets = (await Save.setSetIfNull())
        .map((e) => Set.fromStringToObject(e))
        .toList();

    for (int i = 0; i < dates.length; i++) {
      int thisDaySets = 0;
      for (int j = 0; j < sets.length; j++) {
        if (sets[j].date.day == dates[i].day &&
            sets[j].date.month == dates[i].month &&
            sets[j].date.year == dates[i].year) {
          thisDaySets++;
        }
      }
      intensityPerDay[i] = thisDaySets;
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  int max(List<int> list) {
    int maxValue = list[0];
    for (int i = 1; i < list.length; i++) {
      if (list[i] > maxValue) {
        maxValue = list[i];
      }
    }
    return maxValue;
  }

  List<Widget> chartWidgets() {
    List<Widget> returnList = [];

    for (int i = 0; i < dates.length; i++) {
      String day = [
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat',
        'Sun'
      ][dates[i].weekday - 1];

      int realIntensity = intensityPerDay[i];
      if (realIntensity == 0) realIntensity = 1;

      returnList.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => setState(() => selectedIintensity = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                height: (MediaQuery.of(context).size.height * 0.2) /
                    16 *
                    realIntensity,
                width: MediaQuery.of(context).size.width * 0.19,
                margin: const EdgeInsets.only(
                  left: 0.5,
                  right: 0.5,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  gradient: selectedIintensity == i
                      ? LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.onPrimary,
                          ],
                        )
                      : LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.surface,
                            Theme.of(context).colorScheme.surface,
                          ],
                        ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              day,
              style: TextStyle(
                fontSize: 18,
                fontWeight: selectedIintensity == i ? FontWeight.bold : null,
              ),
            )
          ],
        ),
      );
    }
    return returnList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.41,
      padding: const EdgeInsets.all(30),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sets per day',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context)
                      .scaffoldBackgroundColor,
                ),
              ),
              Text(
                'last 4 days',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.075,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) => ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                      child: Text(
                        '${intensityPerDay[selectedIintensity]}',
                        key: ValueKey(selectedIintensity),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).scaffoldBackgroundColor
                        ),
                      ),
                    ),
                  ),
                  Text(
                    ' sets',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).scaffoldBackgroundColor
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // CHART
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.22,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: chartWidgets(),
            ),
          ),
        ],
      ),
    );
  }
}