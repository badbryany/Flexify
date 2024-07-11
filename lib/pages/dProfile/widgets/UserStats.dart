import 'package:fl_chart/fl_chart.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class UserStats extends StatefulWidget {
  const UserStats({super.key});

  @override
  State<UserStats> createState() => _UserStatsState();
}

class _UserStatsState extends State<UserStats> {
  int friends = 5;
  String totalSetsStr = '';

  List<Duration> durations = [];

  getData() async {
    durations.add(const Duration(hours: 1, minutes: 23));
    durations.add(const Duration(hours: 1, minutes: 3));
    durations.add(const Duration(minutes: 23));
    durations.add(const Duration(hours: 1, minutes: 56));
    durations.add(const Duration(minutes: 45));
    durations.add(const Duration(hours: 1));

    List<Set> sets = await Save.getSetList();

    totalSetsStr = global.shrinkNum(sets.length);
    // ! get friends when backend ist not down anymore

    setState(() {});
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
            color: global.darkGrey,
            borderRadius: BorderRadius.circular(global.borderRadius),
            boxShadow: global.shadow(context),
          ),
          width: global.containerWidth(context),
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
                  child: BarChart(
                    swapAnimationDuration: global.standardAnimationDuration,
                    swapAnimationCurve: Curves.easeInOut,
                    BarChartData(
                      maxY: durations
                          .reduce((dur1, dur2) => dur1 >= dur2 ? dur1 : dur2)
                          .inMinutes
                          .toDouble(),
                      minY: 0,
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 16.0,
                                child: Text(
                                  [
                                    'Mon',
                                    'Tue',
                                    'Wed',
                                    'Thu',
                                    'Fri',
                                    'Sat',
                                    'Sun'
                                  ][value.toInt()],
                                ),
                              );
                            },
                            reservedSize: 40,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 20,
                            reservedSize: global.width(context) * .075,
                            getTitlesWidget: (double value, TitleMeta meta) =>
                                SideTitleWidget(
                              angle: 45,
                              axisSide: meta.axisSide,
                              space: global.width(context) * .075,
                              child: Text(
                                value.round().toString(),
                                style: TextStyle(
                                  fontSize: global.width(context) * .025,
                                ),
                              ),
                            ),
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: const FlGridData(
                        show: true,
                        drawVerticalLine: false,
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: durations
                          .asMap()
                          .entries
                          .map(
                            (entry) => BarChartGroupData(
                              x: entry.key,
                              showingTooltipIndicators:
                                  durations.map((e) => e.inMinutes).toList(),
                              barRods: [
                                BarChartRodData(
                                  toY: entry.value.inMinutes.toDouble(),
                                  width: global.width(context) * .03,
                                  color: Theme.of(context).colorScheme.primary,
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).colorScheme.primary,
                                      Theme.of(context).colorScheme.onPrimary,
                                    ],
                                  ),
                                  backDrawRodData: BackgroundBarChartRodData(
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
                      color: global.lightGrey,
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
                    subtitle: 'Total Sets',
                  ),
                ),
                Positioned(
                  right: global.width(context) * .265,
                  top: 0,
                  bottom: 0,
                  child: SmallBox(
                    title: '$friends',
                    subtitle: 'Friends',
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
        color: global.lightGrey,
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
