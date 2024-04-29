import 'package:collection/collection.dart';
import 'package:flexify/pages/workout/workoutStatsPage/widgets/Sets.dart';
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
  String statsValueTag = 'weight';
  List<String> statsValueTags = [
    'weight',
    'reps',
    'weight per reps',
    'moved weight'
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
          case 'weight':
            y = widget.sets[i].weight;
            break;
          case 'reps':
            y = widget.sets[i].reps.toDouble();
            break;
          case 'weight per reps':
            y = widget.sets[i].weight / widget.sets[i].reps;
            break;
          case 'moved weight':
            y = widget.sets[i].weight * widget.sets[i].reps;
            break;
        }

        spots.add(FlSpot(i.toDouble() - offset, y));

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

  List<List<String>> calculateMonth(DateTime date) {
    List<List<String>> calendarMonth = List.empty(growable: true);
    int daysInMonth = global.daysInMonth(date);
    int firstWeekday = 3;
    int day = 1;

    for (int i = 0; i < 6; i++) {
      List<String> week = ['', '', '', '', '', '', ''];
      if (i == 0) {
        for (int j = firstWeekday; j < 7; j++) {
          week[j] = day.toString();
          day++;
        }
      } else {
        for (int j = 0; j < 7; j++) {
          if (day <= daysInMonth) {
            week[j] = day.toString();
          }
          day++;
        }
      }
      if (!week.equals(['', '', '', '', '', '', ''])) {
        calendarMonth.add(week);
      }
    }
    return calendarMonth;
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
      height: MediaQuery.of(context).size.height * 0.53,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.46,
            width:
                MediaQuery.of(context).size.width * global.containerWidthFactor,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: 5,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.1),
              boxShadow: [global.darkShadow(context)],
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width *
                      global.containerWidthFactor,
                  height: MediaQuery.of(context).size.width * 0.1,
                  decoration: BoxDecoration(
                    color: global.darken(
                      Theme.of(context).colorScheme.background,
                      .05,
                    ),
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.1),
                  ),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () => showCustomModalBottomSheet(
                          context,
                          ModalBottomSheet(
                            title: '',
                            height: global.height(context) * .7,
                            content: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .2,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(.3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    color: Colors.amber,
                                    alignment: Alignment.center,
                                    height: global.height(context) * .03,
                                    width: global.width(context),
                                    child: Text(
                                      "Selected Range",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: global.height(context) * .03,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.red,
                                    alignment: Alignment.center,
                                    height: global.height(context) * .02,
                                    width: global.width(context),
                                    child: Text(
                                      "${dateString(firstDate)} - ${dateString(lastDate)}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: global.height(context) * .02,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print(calculateMonth(DateTime.now()));
                                    },
                                    child: Container(
                                      color: Colors.green,
                                      alignment: Alignment.center,
                                      height: global.height(context) * .15,
                                      width: global.width(context),
                                      child: SizedBox(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            bigTitle: true,
                            submitButtonText: 'Enter',
                          ),
                        ),
                        child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            dateString(firstDate),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
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
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => pickNewDate(false),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.4,
                            color: Colors.transparent,
                            child: Text(
                              dateString(lastDate),
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
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
                          height: MediaQuery.of(context).size.width * 0.05,
                          width: MediaQuery.of(context).size.width * 0.05,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : (spots.isEmpty
                        ? noSetLoadingWrapper(
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.11,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.11,
                              ),
                              child: Text(
                                widget.sets.isEmpty
                                    ? 'no sets yet'
                                    : 'no sets in this interval',
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
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'diagram value:',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(),
                    DropdownButton(
                      value: statsValueTag,
                      items: [
                        ...statsValueTags.map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: const TextStyle(fontFamily: 'KronaOne'),
                            ),
                          ),
                        )
                      ],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      borderRadius:
                          BorderRadius.circular(global.borderRadius - 15),
                      dropdownColor: Theme.of(context).colorScheme.background,
                      iconEnabledColor:
                          Theme.of(context).colorScheme.onBackground,
                      underline: const SizedBox(),
                      onChanged: (String? value) {
                        if (value is String) {
                          statsValueTag = value;
                          setState(() {});
                        }
                      },
                    )
                  ],
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
                  tag,
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Text(
                  '${value.round()}',
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onBackground,
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
                    color: Theme.of(context).colorScheme.onBackground,
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
              color: Theme.of(context).colorScheme.onBackground,
              spots: spots,
              isCurved: true,
            ),
          ],
        ),
        duration: global.standardAnimationDuration,
        curve: Curves.linear,
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
        day.toString(),
        style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: MediaQuery.of(context).size.height * 0.01 +
                MediaQuery.of(context).size.width * 0.02),
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
        month.toString(),
        style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: MediaQuery.of(context).size.height * 0.01 +
                MediaQuery.of(context).size.width * 0.02),
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
        year.toString(),
        style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: MediaQuery.of(context).size.height * 0.01 +
                MediaQuery.of(context).size.width * 0.02),
      ),
    );
  }
}
