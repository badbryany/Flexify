import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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

  Widget noSetLoadingWrapper(Widget child) => Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.26,
        width: MediaQuery.of(context).size.width * 0.8,
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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.53,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Stack(
        children: [
          Positioned(
            top: 15,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.46,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(35),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Column(
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: name.length > 13 ? 20 : 30,
                      ),
                    ),
                    const SizedBox(height: 20),
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
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                ),
                              )
                            : Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.025,
                                  right:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.225,
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
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      topTitles: const AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      leftTitles: AxisTitles(
                                        axisNameSize: 30,
                                        axisNameWidget: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 0),
                                          child: Text(
                                            'weight / rep',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                            ),
                                          ),
                                        ),
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, meta) =>
                                              Padding(
                                            padding:
                                                const EdgeInsets.only(right: 0),
                                            child: Text(
                                              '${value.round()}',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, meta) =>
                                              Text(
                                            '${value.round()}',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
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
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        spots: spots,
                                        isCurved: true,
                                      ),
                                    ],
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              ))),
                  ],
                ),
              ),
            ),
          ),

          // TOP ICON
          Positioned(
            left: 1,
            right: 12.5,
            child: Center(
              child: Container(
                // alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.175,
                height: MediaQuery.of(context).size.width * 0.175,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.onPrimary,
                    ],
                  ),
                ),
                child: Icon(
                  Icons.fitness_center_rounded,
                  color: Theme.of(context).focusColor,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
