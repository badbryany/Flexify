import 'package:flexify/pages/dWorkout/widgets/WorkoutTimer.dart';
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
  bool isTraining = false;

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

  bool _isDisposed = false;

  @override
  void initState() {
    _isDisposed = false;
    super.initState();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  getData() async {
    for (int i = 0; i < dates.length; i++) {
      if (_isDisposed) return;

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
      if (!_isDisposed) setState(() {});
    }

    if (widget.sets.isNotEmpty) {
      if (widget.sets.last.date.difference(DateTime.now()).abs() <=
          const Duration(minutes: 20)) {
        isTraining = true;
        if (!_isDisposed) setState(() {});
      }
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
                    color: global.darkGrey
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    height: (global.height(context) * 0.17) /
                        max(intensityPerDay) *
                        realIntensity,
                    width: global.width(context) * 0.11,
                    margin: const EdgeInsets.only(
                      left: 0.5,
                      right: 0.5,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      gradient: selectedIntesity == i
                          ? LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.onPrimary,
                              ],
                            )
                          : null,
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
        color: global.darkGrey,
        borderRadius: BorderRadius.circular(global.borderRadius),
        boxShadow: [global.lightShadow(context)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(
                height: global.height(context) * .04,
                child: AnimatedSwitcher(
                  duration: global.standardAnimationDuration,
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: animation.drive(
                        Tween(
                          begin: const Offset(1, 0),
                          end: const Offset(0, 0),
                        ),
                      ),
                      child: child,
                    ),
                  ),
                  child: isTraining
                      ? WorkoutTimer(
                          sets: widget.sets,
                          getData: getData,
                        )
                      : Container(
                          width: global.width(context) * .25,
                          height: global.height(context) * .0375,
                          key: const ValueKey('activity text'),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context).colorScheme.onPrimary,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(
                                  global.width(context) * 0.1)),
                          child: Text(
                            'Activity',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: global.width(context) * 0.035,
                            ),
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: chartWidgets(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
