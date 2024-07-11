import 'package:fl_chart/fl_chart.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserStats extends StatefulWidget {
  const UserStats({super.key});

  @override
  State<UserStats> createState() => _UserStatsState();
}

class _UserStatsState extends State<UserStats> {
  int friends = -1;
  String totalSetsStr = '';

  List<Duration> durations = [];

  List<DateTime> dates = [
    DateTime.now().subtract(const Duration(days: 5)),
    DateTime.now().subtract(const Duration(days: 4)),
    DateTime.now().subtract(const Duration(days: 3)),
    DateTime.now().subtract(const Duration(days: 2)),
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.now(),
  ];

  getData() async {
    SharedPreferences.getInstance().then(
      (prefs) => http
          .get(
        Uri.parse('${global.host}/getFriends?jwt=${prefs.getString('jwt')}'),
      )
          .then((res) {
        if (res.body == 'bad request') {
          friends = 0;
          return;
        }
        friends = jsonDecode(res.body).length;
        setState(() {});
      }),
    );

    List<Set> sets = await Save.getSetList();

    totalSetsStr = global.shrinkNum(sets.length);

    getDurations(sets);

    setState(() {});
  }

  getDurations(List<Set> sets) {
    sets = sets.where((set) => set.date.isAfter(dates.first)).toList();

    for (var date in dates) {
      DateTime startOfDay = DateTime(date.year, date.month, date.day);
      DateTime endOfDay = startOfDay.add(const Duration(days: 1));

      List<Set> setsOfTheDay = sets
          .where((set) =>
              set.date.isAfter(startOfDay) && set.date.isBefore(endOfDay))
          .toList();

      if (setsOfTheDay.isNotEmpty) {
        DateTime firstSetTime = setsOfTheDay.first.date;
        DateTime lastSetTime = setsOfTheDay.last.date;

        durations.add(lastSetTime.difference(firstSetTime).abs());
      } else {
        durations.add(Duration.zero);
      }
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: global.height(context) * .025),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(global.borderRadius),
            boxShadow: global.shadow(context),
          ),
          width: global.containerWidth(context),
          height: global.height(context) * .475,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              global.largeHeight(context),
              global.largeHeight(context),
              Padding(
                padding: EdgeInsets.only(left: global.width(context) * .05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your daily stats',
                      style: TextStyle(
                        fontSize: global.width(context) * .075,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    global.smallHeight(context),
                    Text(
                      'Daily total training duration in minutes',
                      style: TextStyle(
                        fontSize: global.width(context) * .04,
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(.5),
                      ),
                    ),
                  ],
                ),
              ),
              global.largeHeight(context),
              Padding(
                padding: EdgeInsets.all(global.width(context) * .05),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: AnimatedSwitcher(
                    duration: global.standardAnimationDuration,
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    child: durations.isEmpty
                        ? global.loadingWidget(context, 1)
                        : durations
                                    .reduce((dur1, dur2) =>
                                        dur1 >= dur2 ? dur1 : dur2)
                                    .inMinutes
                                    .toDouble() ==
                                0
                            ? Text(
                                'no data jet',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(.75),
                                ),
                              )
                            : BarChart(
                                key: const ValueKey('chart'),
                                swapAnimationDuration:
                                    global.standardAnimationDuration,
                                swapAnimationCurve: Curves.easeInOut,
                                BarChartData(
                                  maxY: durations
                                      .reduce((dur1, dur2) =>
                                          dur1 >= dur2 ? dur1 : dur2)
                                      .inMinutes
                                      .toDouble(),
                                  minY: 0,
                                  barTouchData: BarTouchData(
                                    enabled: true,
                                    touchTooltipData: BarTouchTooltipData(
                                      getTooltipColor: (group) =>
                                          Colors.transparent,
                                      getTooltipItem:
                                          (group, groupIndex, rod, rodIndex) {
                                        return BarTooltipItem(
                                          '${rod.toY.round()} min',
                                          TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                            fontSize:
                                                global.width(context) * .03,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  titlesData: FlTitlesData(
                                    show: true,
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget:
                                            (double value, TitleMeta meta) {
                                          return SideTitleWidget(
                                            axisSide: meta.axisSide,
                                            space: 16.0,
                                            child: Text(
                                              global.weekdaysShort[
                                                  dates[value.toInt()].weekday -
                                                      1],
                                            ),
                                          );
                                        },
                                        reservedSize: 40,
                                      ),
                                    ),
                                    leftTitles: const AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: false,
                                      ),
                                    ),
                                    rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    topTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                  ),
                                  gridData: FlGridData(
                                    show: true,
                                    drawVerticalLine: false,
                                    horizontalInterval: durations
                                            .reduce((dur1, dur2) =>
                                                dur1 >= dur2 ? dur1 : dur2)
                                            .inMinutes
                                            .toDouble() /
                                        6,
                                  ),
                                  borderData: FlBorderData(show: false),
                                  barGroups: durations
                                      .asMap()
                                      .entries
                                      .map(
                                        (entry) => BarChartGroupData(
                                          x: entry.key,
                                          showingTooltipIndicators: durations
                                              .map((e) => e.inMinutes)
                                              .toList(),
                                          barRods: [
                                            BarChartRodData(
                                              toY: entry.value.inMinutes
                                                  .toDouble(),
                                              width:
                                                  global.width(context) * .03,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              gradient: LinearGradient(
                                                colors: [
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                ],
                                              ),
                                              backDrawRodData:
                                                  BackgroundBarChartRodData(
                                                show: true,
                                                toY: entry.key.toDouble(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                  ),
                ),
              ),
            ],
          ),
        ),

        //

        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: SizedBox(
            width: global.width(context) * .4125,
            height: global.height(context) * .05,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: global.shadow(context),
                      color: global.darkGrey,
                    ),
                    width: 50,
                    height: global.height(context) * .025,
                  ),
                ),
                Positioned(
                  left: global.width(context) * .265,
                  top: 0,
                  bottom: 0,
                  child: SmallBox(
                    title: totalSetsStr,
                    subtitle: 'total sets',
                  ),
                ),
                Positioned(
                  right: global.width(context) * .265,
                  top: 0,
                  bottom: 0,
                  child: SmallBox(
                    title: friends == -1 ? '---' : '$friends',
                    subtitle: 'friends',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SmallBox extends StatelessWidget {
  const SmallBox({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: global.width(context) * .2,
      height: global.height(context) * .125,
      decoration: BoxDecoration(
        color: global.darkGrey,
        borderRadius: BorderRadius.circular(global.borderRadius - 15),
        boxShadow: global.shadow(context),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: global.width(context) * .045,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2.5),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: global.width(context) * .025,
              color: Colors.white.withOpacity(.75),
            ),
          ),
        ],
      ),
    );
  }
}
