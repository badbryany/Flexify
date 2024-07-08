import 'package:flexify/pages/dWorkout/workoutStatsPage/workoutStatsPage.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class DashboardWorkoutStats extends StatefulWidget {
  const DashboardWorkoutStats({
    super.key,
    required this.sets,
  });

  final List<Set> sets;

  @override
  State<DashboardWorkoutStats> createState() => _DashboardWorkoutStatsState();
}

class _DashboardWorkoutStatsState extends State<DashboardWorkoutStats> {
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

  int selectedIntesity = 6; // yesterday
  bool initial = true;

  getData() async {
    for (int i = 0; i < dates.length; i++) {
      int thisDaySets = 0;
      for (int j = 0; j < widget.sets.length; j++) {
        if (widget.sets[j].date.day == dates[i].day &&
            widget.sets[j].date.month == dates[i].month &&
            widget.sets[j].date.year == dates[i].year) {
          thisDaySets++;
        }
      }
      intensityPerDay[i] = thisDaySets;
      if (initial && intensityPerDay[i] != 0) {
        selectedIntesity = i;
        break;
      }
      initial = false;
      await Future.delayed(const Duration(milliseconds: 125));
      setState(() {});
    }
  }

  double max(List<int> list) {
    int maxValue = list[0];
    for (int i = 1; i < list.length; i++) {
      if (list[i] > maxValue) {
        maxValue = list[i];
      }
    }
    if (maxValue == 0) return 0.1;
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

      double realIntensity = intensityPerDay[i].toDouble();
      if (max(intensityPerDay) == 0.1) realIntensity = 0.005;

      returnList.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BounceElement(
              onTap: () => setState(() => selectedIntesity = i),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: global.height(context) * 0.17,
                    width: global.width(context) * 0.11,
                    color: Theme.of(context).colorScheme.background,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: (global.height(context) * 0.17) /
                        max(intensityPerDay) *
                        realIntensity,
                    width: global.width(context) * 0.11,
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
            const SizedBox(height: 10),
            Text(
              day,
              style: TextStyle(
                fontSize: 16,
                fontWeight: selectedIntesity == i ? FontWeight.bold : null,
                color: Theme.of(context).colorScheme.onBackground,
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
    getData();
    return Container(
      width: global.width(context) * global.containerWidthFactor,
      height: global.height(context) * 0.4,
      padding: EdgeInsets.only(
          top: global.height(context) * .03,
          bottom: global.containerPadding,
          left: global.containerPadding,
          right: global.containerPadding),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(global.borderRadius),
        boxShadow: [global.lightShadow(context)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: global.width(context) * 0.3,
                child: Text(
                  dateString(dates[selectedIntesity]),
                  key: ValueKey(selectedIntesity),
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.6),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.onPrimary,
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(global.width(context) * 0.1)),
                child: Padding(
                  padding: EdgeInsets.all(global.width(context) * 0.03),
                  child: Text(
                    'Activity',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: global.width(context) * 0.03,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                '${intensityPerDay[selectedIntesity]} sets',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // CHART
          SizedBox(
            height: global.height(context) * 0.225,
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
