import 'package:collection/collection.dart';
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

  List<List<String>> calculateMonth(int m, int y) {
    List<List<String>> calendarMonth = List.empty(growable: true);
    int daysInMonth = global.daysInMonth(m, y);
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
    _dayController = FixedExtentScrollController(initialItem: dayIdx);
    _monthController = FixedExtentScrollController(initialItem: monthIdx);
    _yearController = FixedExtentScrollController(initialItem: yearIdx);
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
                        onTap: () => datePicker(context, true),
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
                          onTap: () {
                            datePicker(context, false);
                          },
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

  datePicker(BuildContext context, bool start) {
    showCustomModalBottomSheet(
      context,
      ModalBottomSheet(
        title: start ? 'Starting Date' : 'Ending Date',
        titleSize: global.width(context) * .1,
        height: global.height(context) * .5,
        content: Container(
          height: MediaQuery.of(context).size.height * .175,
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
                height: MediaQuery.of(context).size.height * .06,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.2,
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
                        width: MediaQuery.of(context).size.width * 0.1,
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
                            //     global.daysInMonth(
                            //   _monthController
                            //       .selectedItem,
                            //   _yearController
                            //       .selectedItem,
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
                        width: MediaQuery.of(context).size.width * 0.1,
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
                        width: MediaQuery.of(context).size.width * 0.15,
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
        (day + 1).toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.height * 0.01 +
              MediaQuery.of(context).size.width * 0.035,
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
        (month + 1).toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.height * 0.01 +
              MediaQuery.of(context).size.width * 0.035,
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
          fontSize: MediaQuery.of(context).size.height * 0.01 +
              MediaQuery.of(context).size.width * 0.035,
        ),
      ),
    );
  }
}
