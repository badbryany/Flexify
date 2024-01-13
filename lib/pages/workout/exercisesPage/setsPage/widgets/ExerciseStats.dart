import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/data/exerciseModels.dart';

class ExerciseStats extends StatefulWidget {
  const ExerciseStats({
    super.key,
    required this.exerciseName,
    required this.sets,
  });

  final String exerciseName;
  final List<Set> sets;

  @override
  State<ExerciseStats> createState() => _ExerciseStatsState();
}

class _ExerciseStatsState extends State<ExerciseStats> {
  List<FlSpot> spots = [];
  double maxX = 0;
  double maxY = 0;

  getData() {
    spots = [];
    maxX = 0;
    maxY = 0;

    for (int i = 0; i < widget.sets.length; i++) {
      if (widget.sets[i].exerciseName == widget.exerciseName) {
        double y = widget.sets[i].weight / widget.sets[i].reps;

        spots.add(FlSpot(i.toDouble(), y));

        if (y > maxY) maxY = y;
      }
    }

    maxX = spots.length.toDouble();
    maxY *= 1.35;

    if (maxX == 0 && maxY == 0) {
      maxX = 1;
      maxY = 1;
    }

    setState(() {});
  }

  String dateString(DateTime date) {
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

    return '$month ${date.day}';
  }

  Widget noSetLoadingWrapper(Widget child) => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Theme.of(context).colorScheme.surface.withOpacity(0.035),
        ),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    String name = widget.exerciseName;
    if (name.length > 30) {
      name = '${name.substring(0, 27)}...';
    }
    getData();
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.53,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.46,
            width:
                MediaQuery.of(context).size.width * global.containerWidthFactor,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.1),
              boxShadow: [global.darkShadow],
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width *
                      global.containerWidthFactor,
                  height: MediaQuery.of(context).size.width * 0.1,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(134, 190, 190, 190),
                        spreadRadius: -15.0,
                        blurRadius: 7.0,
                        offset: Offset(-8, -10),
                      ),
                      BoxShadow(
                        color: Color.fromARGB(137, 0, 0, 0),
                        spreadRadius: -10.0,
                        blurRadius: 10.0,
                        offset: Offset(10, 10),
                      ),
                    ],
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.1),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          dateString(widget.sets.first.date),
                          style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.width * 0.1,
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.01),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.1),
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.onPrimary,
                              ],
                            ),
                          ),
                          child: Text(
                            ' - ',
                            style: TextStyle(
                              color: Theme.of(context).focusColor,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                        Text(
                          dateString(widget.sets.last.date),
                          style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03),
                        )
                      ]),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                (maxX == 0 && maxY == 0
                    ? noSetLoadingWrapper(
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.05,
                          width: MediaQuery.of(context).size.width * 0.05,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : (spots.isEmpty
                        ? noSetLoadingWrapper(
                            Text(
                              'no sets yet',
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          )
                        : Statistics(maxX: maxX, maxY: maxY, spots: spots))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Statistics extends StatelessWidget {
  const Statistics({
    super.key,
    required this.maxX,
    required this.maxY,
    required this.spots,
  });

  final double maxX;
  final double maxY;
  final List<FlSpot> spots;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.025,
        right: MediaQuery.of(context).size.width * 0.05,
      ),
      height: MediaQuery.of(context).size.height * 0.225,
      width: MediaQuery.of(context).size.width * 0.85,
      child: LineChart(
        LineChartData(
          baselineX: maxX,
          baselineY: maxY,
          gridData: const FlGridData(show: false),
          lineTouchData: const LineTouchData(
            enabled: false,
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              axisNameSize: 30,
              axisNameWidget: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Text(
                  'weight / rep',
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Text(
                  '${value.round()}',
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Text(
                  '${value.round()}',
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
            ),
          ),
          maxX: maxX,
          maxY: maxY,
          minY: 0,
          minX: 0,
          lineBarsData: [
            LineChartBarData(
              dotData: spots.length == 1
                  ? const FlDotData(show: true)
                  : const FlDotData(show: false),
              color: Theme.of(context).scaffoldBackgroundColor,
              spots: spots,
              isCurved: true,
            ),
          ],
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
