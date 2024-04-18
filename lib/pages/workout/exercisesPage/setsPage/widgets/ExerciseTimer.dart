import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter/widgets.dart';

class ExerciseTimer extends StatefulWidget {
  const ExerciseTimer({
    super.key,
    required this.sets,
  });

  final List<Set> sets;

  @override
  State<ExerciseTimer> createState() => _ExerciseTimerState();
}

class _ExerciseTimerState extends State<ExerciseTimer> {
  getNewTime() {
    if (widget.sets.isEmpty) {
      // currentDuration = Duration.zero;
      minutes = 0;
      seconds = 0;
      setState(() {});
      return;
    }
    Duration difference =
        widget.sets.last.date.difference(DateTime.now()).abs();
    if (difference > const Duration(minutes: 6)) {
      // currentDuration = Duration.zero;
      minutes = 0;
      seconds = 0;
      setState(() {});
      return;
    }

    minutes = (difference.inSeconds / 60).floor();
    seconds = (difference.inSeconds - minutes * 60).round();

    // currentDuration = Duration(minutes: minutes, seconds: seconds);

    setState(() {});
  }

  /* Map<String, int> durationToMinSec(Duration dur) {
    int minutes = (dur.inSeconds / 60).floor();
    int seconds = (dur.inSeconds - minutes * 60).round();

    return {
      'minutes': minutes,
      'seconds': seconds,
    };
  } */

  int minutes = 0;
  int seconds = 0;

  int currentValueSec = 0;
  int currentValueMin = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      getNewTime();

      int num = seconds % 10;

      listController1.animateTo(
        num * digitHeight(context),
        duration: global.standardAnimationDuration,
        curve: Curves.ease,
      );

      num = ((seconds - (seconds % 10)) / 10).round();

      if (currentValueSec != num) {
        listController2.animateTo(
          num * digitHeight(context),
          duration: global.standardAnimationDuration,
          curve: Curves.ease,
        );
        currentValueSec = num;
      }

      num = minutes % 10;

      if (currentValueMin != num) {
        listController3.animateTo(
          num * digitHeight(context),
          duration: global.standardAnimationDuration,
          curve: Curves.ease,
        );
        currentValueMin = num;
      }
    });
  }

  ScrollController listController1 = ScrollController();
  ScrollController listController2 = ScrollController();
  ScrollController listController3 = ScrollController();

  double digitHeight(BuildContext context) => global.height(context) * .08;

  double blockHeightFactor = .2;
  double blockWidthFactor = .12;
  double listHeightFactor = 3;

  Widget digit(String digit) => SizedBox(
        height: digitHeight(context),
        child: Center(
          child: Text(
            digit,
            textAlign: TextAlign.center,
            style: digitTextStyle(context),
          ),
        ),
      );

  TextStyle digitTextStyle(BuildContext context) => TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: global.width(context) * .2,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * global.containerWidthFactor,
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.all(global.containerPadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
          boxShadow: [global.darkShadow(context)],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Text(
                'Rest-Timer',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: global.width(context) * .08,
                ),
              ),
            ),

            // TIMER
            IgnorePointer(
              ignoring: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: global.height(context) * blockHeightFactor,
                    width: global.width(context) * blockWidthFactor,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: digitHeight(context) * .5,
                          ),
                          alignment: Alignment.center,
                          width: global.width(context) * blockWidthFactor,
                          height: digitHeight(context) * listHeightFactor,
                          child: digit('0'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: global.height(context) * blockHeightFactor,
                    width: global.width(context) * blockWidthFactor,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: global.width(context) * blockWidthFactor,
                          height: digitHeight(context) * listHeightFactor,
                          child: ListView(
                            controller: listController3,
                            children: [
                              digit(''),
                              ...List.generate(10, (index) => index).map((e) {
                                bool visible = minutes % 10 == e;

                                return AnimatedOpacity(
                                  duration: global.standardAnimationDuration,
                                  opacity: visible ? 1 : 0,
                                  child: digit('$e'),
                                );
                              }),
                              digit(''),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: global.height(context) * blockHeightFactor,
                    width: global.width(context) * blockWidthFactor,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: digitHeight(context) * .5,
                      ),
                      alignment: Alignment.center,
                      width: global.width(context) * .04,
                      height: digitHeight(context),
                      child: Text(
                        ':',
                        textAlign: TextAlign.center,
                        style: digitTextStyle(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: global.height(context) * blockHeightFactor,
                    width: global.width(context) * blockWidthFactor,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: global.width(context) * blockWidthFactor,
                          height: digitHeight(context) * listHeightFactor,
                          child: ListView(
                            controller: listController2,
                            children: [
                              digit(' '),
                              ...List.generate(10, (index) => index).map((e) {
                                bool visible =
                                    ((seconds - (seconds % 10)) / 10) == e;

                                return AnimatedOpacity(
                                  duration: global.standardAnimationDuration,
                                  opacity: visible ? 1 : 0,
                                  child: digit('$e'),
                                );
                              }),
                              digit(' '),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: global.height(context) * blockHeightFactor,
                    width: global.width(context) * blockWidthFactor,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: global.width(context) * blockWidthFactor,
                          height: digitHeight(context) * listHeightFactor,
                          child: ListView(
                            controller: listController1,
                            children: [
                              digit(' '),
                              ...List.generate(10, (index) => index).map((e) {
                                bool visible = (seconds % 10) == e;

                                return AnimatedOpacity(
                                  duration: global.standardAnimationDuration,
                                  opacity: visible ? 1 : 0,
                                  child: digit('$e'),
                                );
                              }),
                              digit(' '),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
