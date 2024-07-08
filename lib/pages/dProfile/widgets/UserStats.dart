import 'package:fl_chart/fl_chart.dart';
import 'package:flexify/pages/dProfile/pages/QRScanner.dart';
import 'package:flexify/pages/dProfile/widgets/SmallQRWidget.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class UserStats extends StatefulWidget {
  const UserStats({super.key});

  @override
  State<UserStats> createState() => _UserStatsState();
}

class _UserStatsState extends State<UserStats> {
  int totalSets = 200;
  int friends = 5;

  List<Duration> durations = [];

  getData() async {
    durations.add(const Duration(hours: 1, minutes: 23));
    durations.add(const Duration(hours: 1, minutes: 3));
    durations.add(const Duration(minutes: 23));
    durations.add(const Duration(hours: 1, minutes: 56));
    durations.add(const Duration(minutes: 45));
    durations.add(const Duration(hours: 1));

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
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(global.borderRadius),
          ),
          width: global.containerWidth(context),
          height: global.height(context) * 1.075,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              global.largeHeight(context),
              global.largeHeight(context),
              Padding(
                padding: EdgeInsets.only(left: global.width(context) * .05),
                child: Text(
                  'Your daily stats',
                  style: TextStyle(
                    fontSize: global.width(context) * .075,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              global.largeHeight(context),
              Padding(
                padding: EdgeInsets.all(global.width(context) * .05),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: BarChart(
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

              //
              global.largeHeight(context),
              global.largeHeight(context),
              //

              Center(
                child: Container(
                  width: global.width(context) * .75,
                  height: global.height(context) * .075,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(global.borderRadius - 10),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.onPrimary,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Invite Friends',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: global.width(context) * .05,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.share,
                        color: Colors.black,
                        size: global.width(context) * .06,
                      ),
                    ],
                  ),
                ),
              ),

              //
              global.largeHeight(context),
              global.largeHeight(context),
              //
              Padding(
                padding: EdgeInsets.only(left: global.width(context) * .05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Share with friends',
                      style: TextStyle(
                        fontSize: global.width(context) * .075,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    BounceElement(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QRScanner(),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(global.borderRadius - 10),
                          color: Colors.black,
                        ),
                        child: Icon(
                          CupertinoIcons.qrcode_viewfinder,
                          size: global.width(context) * .06,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
              global.largeHeight(context),
              const Center(child: SmallQRWidget()),
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
                      color: Theme.of(context).colorScheme.surface,
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
                    title: '$totalSets',
                    subtitle: 'total sets',
                  ),
                ),
                Positioned(
                  right: global.width(context) * .265,
                  top: 0,
                  bottom: 0,
                  child: SmallBox(
                    title: '$friends',
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
        color: Theme.of(context).colorScheme.surface,
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
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 2.5),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: global.width(context) * .025,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(.75),
            ),
          ),
        ],
      ),
    );
  }
}
