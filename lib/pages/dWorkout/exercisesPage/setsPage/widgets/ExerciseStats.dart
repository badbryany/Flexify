import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/data/exerciseModels.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now();

  String statsValueTag = 'Weight';
  List<String> statsValueTags = [
    'Weight',
    'Repetitions',
    'Weight per repetition',
    'Moved weight',
    'Duration'
  ];
  List<FlSpot> spots = [];
  double maxX = 0;
  double maxY = 0;

  getData() {
    lastDate = widget.sets.last.date;
    spots = [];
    maxX = 0;
    maxY = 0;

    int offset = 0;
    for (int i = 0; i < widget.sets.length; i++) {
      if (widget.sets[i].date.isBefore(firstDate)) {
        offset++;
        continue;
      }
      if (widget.sets[i].date.isAfter(lastDate)) break;

      if (widget.sets[i].exerciseName == widget.exerciseName) {
        double y = 0;

        switch (statsValueTag) {
          case 'Weight':
            y = widget.sets[i].weight;
            break;
          case 'Repetitions':
            y = widget.sets[i].reps.toDouble();
            break;
          case 'Weight per repetition':
            y = widget.sets[i].weight / widget.sets[i].reps;
            break;
          case 'Moved weight':
            y = widget.sets[i].weight * widget.sets[i].reps;
            break;
          case 'Duration':
            y = widget.sets[i].weight * widget.sets[i].reps;
            break;
        }

        spots.add(FlSpot(i.toDouble() - offset, y));

        if (y > maxY) maxY = y;
      }
    }

    maxX = spots.length.toDouble() - 1;
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
          borderRadius: BorderRadius.circular(global.borderRadius - 10),
          color: Theme.of(context).colorScheme.surface.withOpacity(0.035),
        ),
        child: child,
      );

  @override
  void initState() {
    firstDate = widget.sets.first.date;
    lastDate = widget.sets.last.date;

    super.initState();
  }

  datePicker(BuildContext context, bool start) {
    DateTime? startDate;
    DateTime? endDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choose a Range',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: global.width(context) * .075,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('cancle'),
            ),
            TextButton(
              onPressed: () {
                if (startDate != null && endDate != null) {
                  firstDate = startDate!;
                  lastDate = endDate!;
                  setState(() {});
                }
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
          content: SizedBox(
            height: global.height(context) * .4,
            width: global.height(context) * .4,
            child: SfDateRangePicker(
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                startDate = (args.value as PickerDateRange).startDate;
                endDate = (args.value as PickerDateRange).endDate;
              },
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedDate: DateTime.now(),
              todayHighlightColor: Theme.of(context).colorScheme.primary,
              selectionColor: Theme.of(context).colorScheme.onPrimary,
              backgroundColor: Theme.of(context).colorScheme.background,
              headerStyle: DateRangePickerHeaderStyle(
                textAlign: TextAlign.center,
                backgroundColor: Theme.of(context).colorScheme.background,
                textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 18,
                ),
              ),
              monthViewSettings: const DateRangePickerMonthViewSettings(
                firstDayOfWeek: 1,
              ),
              selectionTextStyle: const TextStyle(color: Colors.black),
              maxDate: widget.sets.last.date,
              minDate: widget.sets.first.date,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Container(
      alignment: Alignment.center,
      height: global.height(context) * 0.53,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height:
                global.width(context) * .4 + global.height(context) * .4 - 200,
            width: global.containerWidth(context),
            margin: const EdgeInsets.all(10),
            padding: EdgeInsets.all(
              global.width(context) * .05,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: global.darkGrey,
              borderRadius: BorderRadius.circular(global.width(context) * 0.1),
              boxShadow: [global.darkShadow(context)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: global.width(context) * global.containerWidthFactor,
                  height: global.width(context) * 0.1,
                  decoration: BoxDecoration(
                    color: global.lightGrey,
                    borderRadius:
                        BorderRadius.circular(global.width(context) * 0.1),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => datePicker(context, true),
                          child: Container(
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            width: global.width(context) * 0.4,
                            child: Text(
                              dateString(firstDate),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: global.width(context) * 0.03,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          // onTap: () => setState(
                          //   () {
                          //     firstDate = widget.sets.first.date;
                          //     lastDate = widget.sets.last.date;
                          //   },
                          // ),
                          child: Container(
                            alignment: Alignment.center,
                            width: global.width(context) * 0.1,
                            height: global.width(context) * 0.1,
                            padding:
                                EdgeInsets.all(global.width(context) * 0.01),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(
                                  global.width(context) * 0.1),
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
                                color: Colors.black,
                                fontSize: global.width(context) * 0.05,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            datePicker(context, false);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: global.width(context) * 0.4,
                            color: Colors.transparent,
                            child: Text(
                              dateString(lastDate),
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: global.width(context) * 0.03,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: global.width(context) * .04),
                (maxX == 0 && maxY == 0
                    ? noSetLoadingWrapper(
                        SizedBox(
                          height: global.width(context) * 0.05,
                          width: global.width(context) * 0.05,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : (spots.isEmpty
                        ? noSetLoadingWrapper(
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: global.height(context) * 0.11,
                              ),
                              child: Text(
                                widget.sets.isEmpty
                                    ? 'No sets found'
                                    : 'No sets found in this interval',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                            ),
                          )
                        : Statistics(
                            maxX: maxX,
                            maxY: maxY,
                            spots: spots,
                            tag: statsValueTag,
                          ))),
                SizedBox(
                  height: global.height(context) * .02,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: global.lightGrey,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Choose Metric:',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: global.width(context) * .03),
                      ),
                      const SizedBox(),
                      Theme(
                        data: Theme.of(context).copyWith(
                            canvasColor:
                                Theme.of(context).colorScheme.background,
                            focusColor: Colors.transparent),
                        child: DropdownButton(
                          value: statsValueTag,
                          items: [
                            ...statsValueTags.map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      fontFamily: 'KronaOne',
                                      color: Colors.white,
                                      fontSize: global.width(context) * .03),
                                ),
                              ),
                            )
                          ],
                          iconDisabledColor: Colors.white,
                          iconEnabledColor: Colors.white,
                          autofocus: true,
                          borderRadius: BorderRadius.circular(30),
                          underline: const SizedBox(),
                          onChanged: (String? value) {
                            if (value is String) {
                              statsValueTag = value;
                              statsValueTags.remove(value);
                              statsValueTags.insert(0, value);
                              setState(() {});
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
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
    required this.tag,
  });

  final double maxX;
  final double maxY;
  final List<FlSpot> spots;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: global.height(context) * 0.225,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: global.lightGrey,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [global.darkShadow(context)]),
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: maxX,
          minY: 0,
          maxY: maxY,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
                getTitlesWidget: (value, meta) {
                  return value != 0
                      ? Text(value.round().toString(),
                          style: const TextStyle(fontSize: 10))
                      : const SizedBox();
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
                getTitlesWidget: (value, meta) {
                  return value != 0
                      ? Text(value.round().toString(),
                          style: const TextStyle(fontSize: 10))
                      : const SizedBox();
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          lineTouchData: LineTouchData(
            enabled: true,
            getTouchedSpotIndicator:
                (LineChartBarData barData, List<int> indicators) {
              return indicators.map(
                (int index) {
                  const line = FlLine(
                    color: Colors.white,
                    strokeWidth: 2,
                    dashArray: [2, 4],
                  );
                  return const TouchedSpotIndicatorData(
                    line,
                    FlDotData(show: false),
                  );
                },
              ).toList();
            },
            getTouchLineEnd: (_, __) => double.infinity,
            touchTooltipData: LineTouchTooltipData(
              tooltipBorder: const BorderSide(
                color: Colors.white,
                width: 1,
              ),
              getTooltipColor: (touchedSpot) => global.darkGrey,
              tooltipRoundedRadius: 15,
              tooltipPadding: EdgeInsets.symmetric(
                  horizontal: global.width(context) * .025,
                  vertical: global.height(context) * .01),
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map(
                  (LineBarSpot touchedSpot) {
                    return LineTooltipItem(
                      "${spots[touchedSpot.spotIndex].y.round()}${global.isKg ? "kg" : "oz"}",
                      TextStyle(
                        fontSize: global.width(context) * .0225,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    );
                  },
                ).toList();
              },
            ),
          ),
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.white.withOpacity(.2),
                strokeWidth: 1,
              );
            },
            drawVerticalLine: true,
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.white.withOpacity(.2),
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(
            show: false,
            border: const Border(
              left: BorderSide(color: Colors.white, width: 2),
              bottom: BorderSide(color: Colors.white, width: 2),
              top: BorderSide(color: Colors.transparent),
              right: BorderSide(color: Colors.transparent),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              gradient: global.linearGradient,
              barWidth: 1,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xffa4fba4).withOpacity(.8),
                    const Color(0xfff2f58d).withOpacity(.8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DayTile extends StatelessWidget {
  final int day;

  const DayTile({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        (day + 1).toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize:
              global.height(context) * 0.01 + global.width(context) * 0.033,
        ),
      ),
    );
  }
}

class MonthTile extends StatelessWidget {
  final int month;

  const MonthTile({super.key, required this.month});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        global.months[month],
        style: TextStyle(
          color: Colors.white,
          fontSize:
              global.height(context) * 0.01 + global.width(context) * 0.03,
        ),
      ),
    );
  }
}

class YearTile extends StatelessWidget {
  final int year;

  const YearTile({super.key, required this.year});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        (year + 2024).toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize:
              global.height(context) * 0.01 + global.width(context) * 0.033,
        ),
      ),
    );
  }
}
