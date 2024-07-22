import 'package:flexify/widgets/ModalBottomSheet.dart';
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
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now();
  String statsValueTag = 'Weight';
  List<String> statsValueTags = [
    'Weight',
    'Repetitions',
    'Weight per repetition',
    'Moved weight'
  ];
  List<FlSpot> spots = [];
  double maxX = 0;
  double maxY = 0;

  late FixedExtentScrollController _dayController;
  int dayIdx = 0;
  bool daySelected = false;
  late FixedExtentScrollController _monthController;
  int monthIdx = 0;
  bool monthSelected = false;
  late FixedExtentScrollController _yearController;
  int yearIdx = 0;
  bool yearSelected = false;

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
    _dayController = FixedExtentScrollController(initialItem: dayIdx);
    _monthController = FixedExtentScrollController(initialItem: monthIdx);
    _yearController = FixedExtentScrollController(initialItem: yearIdx);
    super.initState();
  }

  pickNewDate(bool first) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      builder: (context, child) => Theme(
        data: ThemeData(
          fontFamily: 'KronaOne',
          brightness: Brightness.dark,
          colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.transparent,
            onPrimary: Theme.of(context).colorScheme.primary,
            secondary: Colors.red,
            onSecondary: Colors.red,
            error: Colors.red,
            onError: Colors.red,
            background: Colors.green,
            onBackground: Colors.transparent,
            surface: Theme.of(context).colorScheme.background,
            onSurface: Theme.of(context).focusColor,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        child: child!,
      ),
      firstDate: widget.sets.first.date,
      lastDate: widget.sets.last.date,
      initialDate: first ? firstDate : lastDate,
    );

    if (newDate == null) return;

    if (first) {
      firstDate = newDate;
      if (firstDate.isAfter(lastDate)) {
        lastDate = firstDate;
      }
    } else {
      lastDate = newDate;
    }
    setState(() {});
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
                          onTap: () => setState(() {
                            firstDate = widget.sets.first.date;
                            lastDate = widget.sets.last.date;
                          }),
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

  datePicker(BuildContext context, bool start) {
    showCustomModalBottomSheet(
      context,
      ModalBottomSheet(
        title: start ? 'Starting Date' : 'Ending Date',
        titleSize: global.width(context) * .1,
        height: global.height(context) * .5,
        content: Container(
          height: global.height(context) * .175,
          padding: EdgeInsets.only(
            bottom: global.height(context) * .05,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: global.width(context) * .8,
                height: global.height(context) * .06,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(
                    global.width(context) * 0.2,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: global.width(context) * 0.1,
                        child: ListWheelScrollView.useDelegate(
                          controller: _dayController,
                          onSelectedItemChanged: (index) {
                            daySelected = true;
                            setState(() {});
                          },
                          itemExtent: 50,
                          perspective: 0.005,
                          diameterRatio: 3.5,
                          physics: const FixedExtentScrollPhysics(),
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: 31,
                            // childCount: global.daysInMonth(
                            //   _monthController.selectedItem,
                            //   _yearController.selectedItem,
                            // ),
                            builder: (context, index) {
                              return DayTile(day: index);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: global.width(context) * .12,
                      ),
                      SizedBox(
                        width: global.width(context) * 0.1,
                        child: ListWheelScrollView.useDelegate(
                          controller: _monthController,
                          onSelectedItemChanged: (index) {
                            monthSelected = true;
                            setState(() {});
                          },
                          itemExtent: 50,
                          perspective: 0.005,
                          diameterRatio: 3.5,
                          physics: const FixedExtentScrollPhysics(),
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: 12,
                            builder: (context, index) {
                              return MonthTile(month: index);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: global.width(context) * .11,
                      ),
                      SizedBox(
                        width: global.width(context) * 0.15,
                        child: ListWheelScrollView.useDelegate(
                          controller: _yearController,
                          onSelectedItemChanged: (index) {
                            yearSelected = true;
                            setState(() {});
                          },
                          itemExtent: 50,
                          perspective: 0.005,
                          diameterRatio: 3.5,
                          physics: const FixedExtentScrollPhysics(),
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: global.yearsSinceRelease,
                            builder: (context, index) {
                              return YearTile(year: index);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        bigTitle: true,
        submitButtonText: 'Enter',
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
