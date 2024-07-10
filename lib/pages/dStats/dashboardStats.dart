import 'package:fl_chart/fl_chart.dart';
import 'package:flexify/pages/dPlan/data/planData.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/widgets/ModalBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/data/dateUtils.dart' as dateUtils;
import 'dart:math' as math;

import 'package:flutter/rendering.dart';

class DashboardStats extends StatefulWidget {
  const DashboardStats({super.key});

  @override
  State<DashboardStats> createState() => _DashboardStatsState();
}

class _DashboardStatsState extends State<DashboardStats> {
  bool showExercises = false;
  String selectedExercise = 'Select Exercise';

  setShowExercises() {
    showExercises = !showExercises;
    setState(() {});
  }

  getShowExercises() => showExercises;

  setSelectedExercise(String val) {
    selectedExercise = val;
    setState(() {});
  }

  getSelectedExercise() => selectedExercise;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: global.containerWidth(context),
          height: global.height(context) * .3625 + 40,
          padding: const EdgeInsets.all(19),
          decoration: global.boxDecoration(context),
          child: Stack(
            children: [
              ChartTitle(
                setShowExercises: setShowExercises,
                getShowExercises: getShowExercises,
                setSelectedExercise: setSelectedExercise,
                getSelectedExercise: getSelectedExercise,
              ),
              Positioned(
                top: global.height(context) * .06,
                child: ChartBody(),
              ),
              Positioned(
                top: global.height(context) * .05,
                child: AnimatedContainer(
                  duration: global.standardAnimationDuration,
                  height: showExercises ? global.height(context) * .3 : 0,
                  width: (global.containerWidth(context) - 38) * (4 / 11),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    border: Border(
                      left: BorderSide(color: Colors.white.withOpacity(.5)),
                      right: BorderSide(color: Colors.white.withOpacity(.5)),
                      bottom: BorderSide(color: Colors.white.withOpacity(.5)),
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: dummyExercises.length,
                    itemBuilder: (context, idx) {
                      return BounceElement(
                        onTap: () {
                          setSelectedExercise(dummyExercises[idx].name);
                          setShowExercises();
                          setState(() {});
                        },
                        child: Container(
                          height: global.height(context) * .1,
                          padding: EdgeInsets.all(global.width(context) * .03),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: idx != 0
                                ? Border(
                                    top: BorderSide(
                                      color: Colors.white.withOpacity(.5),
                                    ),
                                  )
                                : null,
                          ),
                          child: Text(
                            dummyExercises[idx].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: global.width(context) * .0275),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: global.height(context) * .01,
        ),
        Container(
          height: global.height(context) * .15,
          width: global.containerWidth(context),
          child: Row(
            children: [
              const Flexible(
                flex: 3,
                child: StreaksWIdget(),
              ),
              SizedBox(
                width: global.height(context) * .01,
              ),
              Flexible(
                flex: 2,
                child: TimeWidget(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: global.height(context) * .01,
        ),
        Container(
          height: global.height(context) * .01 + global.width(context) * .25,
          width: global.containerWidth(context),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: global.boxDecoration(context),
                ),
              ),
              SizedBox(
                width: global.height(context) * .01,
              ),
              Flexible(
                flex: 3,
                child: AchievementsDashboardWidget(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: global.boxDecoration(context),
      child: Column(
        
      ),
    );
  }
}

class StreaksWIdget extends StatelessWidget {
  const StreaksWIdget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Flexible dayWidget = Flexible(
      flex: 1,
      child: Container(
        height: global.height(context) * .055 * (1 / 2),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: global.linearGradient,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(
        global.height(context) * .02,
      ),
      decoration: global.boxDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: global.gradient(
                    Icon(
                      Icons.whatshot_outlined,
                      size: global.width(context) * .075,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Streaks',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: global.width(context) * .06,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 4,
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Row(
                        children: [
                          const Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: double.infinity,
                              )),
                          dayWidget,
                          const Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: double.infinity,
                              )),
                          dayWidget,
                          const Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: double.infinity,
                              )),
                          dayWidget,
                          const Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: double.infinity,
                              )),
                          dayWidget,
                          const Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: double.infinity,
                              )),
                          dayWidget,
                          const Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: double.infinity,
                              )),
                          dayWidget,
                          const Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: double.infinity,
                              )),
                          dayWidget,
                          const Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: double.infinity,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: global.linearGradient,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        '16',
                        style: TextStyle(
                          fontSize: global.width(context) * .06,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AchievementsDashboardWidget extends StatelessWidget {
  const AchievementsDashboardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(
        global.height(context) * .02,
      ),
      decoration: global.boxDecoration(context),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Row(
              children: [
                global.gradient(
                  Icon(
                    Icons.assistant_photo_outlined,
                    size: global.width(context) * .2 - 50,
                  ),
                ),
                SizedBox(
                  width: global.width(context) * .03,
                ),
                Text(
                  'Achievements',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: global.width(context) * .05 - 5),
                )
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                height: global.height(context) * .02,
                padding: const EdgeInsets.all(2),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  height: double.infinity,
                  width: (global.containerWidth(context) -
                          global.height(context) * .01) *
                      (3 / 5) *
                      .5,
                  decoration: BoxDecoration(
                      gradient: global.linearGradient,
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChartTitle extends StatefulWidget {
  const ChartTitle(
      {super.key,
      required this.setShowExercises,
      required this.getShowExercises,
      required this.getSelectedExercise,
      required this.setSelectedExercise});

  final Function setShowExercises;
  final Function getShowExercises;
  final void Function(String val) setSelectedExercise;
  final Function getSelectedExercise;

  @override
  State<ChartTitle> createState() => _ChartTitleState();
}

class _ChartTitleState extends State<ChartTitle> {
  bool showExercises = false;
  List<String> repRanges = [
    '1',
    '2 - 4',
    '5 - 7',
    '8 - 11',
    '12 - 14',
    '15 - 19',
    '20 +'
  ];
  String repSelected = 'Select Rep-Range';

  late FixedExtentScrollController _repRangeController;

  @override
  void initState() {
    super.initState();
    _repRangeController = FixedExtentScrollController(initialItem: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 4,
          child: GestureDetector(
            onTap: () {
              widget.setShowExercises();
              setState(() {});
            },
            child: AnimatedContainer(
              duration: widget.getShowExercises()
                  ? Duration.zero
                  : global.standardAnimationDuration * 2,
              curve: const _ReLUCurve._(),
              height: global.height(context) * .05,
              width: double.infinity,
              padding: EdgeInsets.all(global.width(context) * .01),
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(global.borderRadius - 10),
                  topRight: Radius.circular(global.borderRadius - 10),
                  bottomLeft: widget.getShowExercises()
                      ? Radius.zero
                      : Radius.circular(global.borderRadius - 10),
                  bottomRight: widget.getShowExercises()
                      ? Radius.zero
                      : Radius.circular(global.borderRadius - 10),
                ),
                boxShadow: global.shadow(context),
                border: Border.all(color: Colors.white.withOpacity(.5)),
              ),
              child: Text(
                widget.getSelectedExercise(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: global.width(context) * .0275,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: SizedBox(
            child: Text(
              'Friends',
              style: TextStyle(
                  color: Colors.white, fontSize: global.width(context) * .045),
            ),
          ),
        ),
        Flexible(
          flex: 4,
          child: GestureDetector(
            onTap: () {
              showCustomModalBottomSheet(
                context,
                ModalBottomSheet(
                  title: "Select Rep-Range",
                  titleSize: global.width(context) * .1,
                  height: global.height(context) * .6,
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
                        SizedBox(
                          width: global.containerWidth(context),
                          child: ListWheelScrollView.useDelegate(
                            controller: _repRangeController,
                            onSelectedItemChanged: (index) {
                              repSelected = repRanges[index];
                              setState(() {});
                            },
                            itemExtent: 75,
                            perspective: 0.01,
                            physics: const FixedExtentScrollPhysics(),
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: repRanges.length,
                              builder: (context, index) {
                                return RepTile(repRange: repRanges[index]);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  bigTitle: true,
                  submitButtonText: 'Enter',
                ),
              );
            },
            child: Container(
              height: global.height(context) * .05,
              width: double.infinity,
              alignment: Alignment.center,
              padding:
                  EdgeInsets.symmetric(horizontal: global.width(context) * .01),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(global.borderRadius - 10),
                boxShadow: global.shadow(context),
                border: Border.all(color: Colors.white.withOpacity(.5)),
              ),
              child: repSelected == 'Select Rep-Range'
                  ? Container(
                      alignment: Alignment.center,
                      child: Text(
                        repSelected,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: global.width(context) * .025),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: global.containerWidth(context) * .1,
                          alignment: Alignment.center,
                          child: Text(
                            repSelected,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: global.width(context) * .03),
                          ),
                        ),
                        repSelected != 'Select Rep-Range'
                            ? Text(
                                'REP MAX',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: global.width(context) * .03,
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class RepTile extends StatelessWidget {
  final String repRange;

  const RepTile({super.key, required this.repRange});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        repRange,
        style: TextStyle(
          color: Colors.white,
          fontSize:
              global.height(context) * 0.02 + global.width(context) * 0.033,
        ),
      ),
    );
  }
}

class ChartBody extends StatelessWidget {
  ChartBody({
    super.key,
  });

  final List<(DateTime, double)> points = [
    (DateTime(2024, 1, 1), 3),
    (DateTime(2024, 1, 2), 2),
    (DateTime(2024, 1, 3), 5),
    (DateTime(2024, 1, 4), 2.5),
    (DateTime(2024, 1, 5), 4),
    (DateTime(2024, 1, 6), 3),
    (DateTime(2024, 1, 7), 4)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: global.containerWidth(context) - 38,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        gradient: global.linearGradient,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: global.height(context) * .3,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15),
        ),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 11,
            minY: 0,
            maxY: 6,
            titlesData: const FlTitlesData(
              show: false,
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
                        "${points[touchedSpot.spotIndex].$2.toStringAsFixed(0)}${global.isKg ? "kg" : "oz"} - ${dateUtils.dateString(points[touchedSpot.spotIndex].$1)}",
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
                  color: Theme.of(context).colorScheme.surface.withOpacity(.5),
                  strokeWidth: 1,
                );
              },
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Theme.of(context).colorScheme.surface.withOpacity(.5),
                  strokeWidth: 1,
                );
              },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(0, 3),
                  FlSpot(2.6, 2),
                  FlSpot(4.9, 5),
                  FlSpot(6.8, 2.5),
                  FlSpot(8, 4),
                  FlSpot(9.5, 3),
                  FlSpot(11, 4),
                ],
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
      ),
    );
  }
}

class _ReLUCurve extends Curve {
  const _ReLUCurve._();

  @override
  double transformInternal(double t) {
    return math.max(0, (2 * t) - 1);
  }
}