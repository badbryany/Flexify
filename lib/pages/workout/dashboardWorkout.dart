import 'package:flutter/material.dart';

import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/pages/DashboardOptionButton.dart';
import 'package:flexify/pages/workout/workoutPage/workoutPage.dart';

class DashboardWorkout extends StatefulWidget {
  const DashboardWorkout({super.key});

  @override
  State<DashboardWorkout> createState() => _DashboardWorkoutState();
}

class _DashboardWorkoutState extends State<DashboardWorkout> {
  reload() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const WorkoutDashboard(),
        const SizedBox(height: 10),
        DashboardXOptionButton(
          title: 'Recommended Workout',
          targetPage: WorkoutPage(
            reload: reload,
          ),
          content: const Text(''),
        ),
        const SizedBox(height: 10),
        DashboardXOptionButton(
          title: 'Custom Workout',
          targetPage: WorkoutPage(
            reload: reload,
          ),
          content: const Text(''),
        ),
        const SizedBox(height: 10),
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
    DateTime.now().subtract(const Duration(days: 6)),
    DateTime.now().subtract(const Duration(days: 5)),
    DateTime.now().subtract(const Duration(days: 4)),
    DateTime.now().subtract(const Duration(days: 3)),
    DateTime.now().subtract(const Duration(days: 2)),
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.now(),
  ];

  List<int> intensityPerDay = [0, 0, 0, 0, 0, 0, 0];

  int selectedIntesity = 5; // yesterday

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

  double max(List<int> list, BuildContext context) {
    int maxValue = list[0];
    for (int i = 1; i < list.length; i++) {
      if (list[i] > maxValue) {
        maxValue = list[i];
      }
    }
    return maxValue.toDouble();
  }

  String dateString(DateTime date) {
    String day = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ][date.weekday - 1];
    String month = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ][date.month - 1];

    return '$day, $month ${date.day}';
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
              onTap: () => setState(() => selectedIntesity = i),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.22,
                    width: MediaQuery.of(context).size.width * 0.114,
                    color: Theme.of(context).colorScheme.background
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: max(intensityPerDay, context) == 0
                        ? 0
                        : ((MediaQuery.of(context).size.height * 0.18) /
                            max(intensityPerDay, context) *
                            realIntensity),
                    width: MediaQuery.of(context).size.width * 0.114,
                    margin: const EdgeInsets.only(
                      left: 0.5,
                      right: 0.5,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      gradient: selectedIntesity == i
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
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              day,
              style: TextStyle(
                fontSize: 18,
                fontWeight: selectedIntesity == i ? FontWeight.bold : null,
                color: Theme.of(context).scaffoldBackgroundColor,
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
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.38,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        dateString(dates[selectedIntesity]),
                        key: ValueKey(selectedIntesity),
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.037,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.6),
                        ),
                      ),
                    ),
                    Text(
                      '${intensityPerDay[selectedIntesity]} sets',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.onPrimary,
                      ],
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      
                    },
                    child: Row(
                      children: [
                        Text(
                          'See more',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.027,
                            color: Theme.of(context).focusColor.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).focusColor,
                          size: 13,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // CHART
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.23,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: chartWidgets(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
