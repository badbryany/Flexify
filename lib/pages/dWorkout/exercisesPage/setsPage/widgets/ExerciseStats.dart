import 'package:flexify/widgets/ModalBottomSheet.dart';
import 'package:flutter/cupertino.dart';
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

  bool lastDateSet = false;

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
    if (!lastDateSet) lastDate = widget.sets.last.date;

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
            y = widget.sets[i].getDuration().inSeconds.toDouble();
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
    getData();
  }

  pickNewDate(bool first) async {
    DateTime? newDate;

    await showCustomModalBottomSheet(
      context,
      ModalBottomSheet(
        title: '${first ? 'Starting' : 'Ending'} Date',
        titleSize: global.width(context) * .075,
        height: global.height(context) * .5,
        content: SizedBox(
          height: global.height(context) * .25,
          child: CupertinoDatePicker(
            onDateTimeChanged: (date) => newDate = date,
            initialDateTime: first ? firstDate : lastDate,
            mode: CupertinoDatePickerMode.date,
            showDayOfWeek: true,
            use24hFormat: true,
            minimumDate: widget.sets.first.date,
            maximumDate: widget.sets.last.date,
          ),
        ),
      ),
    );

    if (newDate == null) return;
    if (newDate!.isBefore(widget.sets.first.date)) return;
    if (newDate!.isAfter(widget.sets.last.date)) return;

    if (first) {
      firstDate = newDate!;
      if (firstDate.isAfter(lastDate)) {
        lastDate = firstDate;
      }
    } else {
      lastDateSet = true;
      lastDate = newDate!;
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
            width: global.containerWidth(context),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.only(
              top: 15,
              right: 20,
              left: 20,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: global.darkGrey,
              borderRadius: BorderRadius.circular(global.width(context) * 0.09),
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
                          onTap: () => pickNewDate(true),
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
                          onTap: () => pickNewDate(false),
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
                Row(
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
                          canvasColor: Theme.of(context).colorScheme.background,
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
                            setState(() {});
                          }
                        },
                      ),
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
      alignment: Alignment.center,
      padding: EdgeInsets.all(global.width(context) * .1),
      height: global.height(context) * 0.225,
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
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
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
