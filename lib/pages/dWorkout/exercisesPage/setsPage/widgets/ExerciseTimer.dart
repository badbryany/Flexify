import 'dart:async';

import 'package:flexify/widgets/ModalBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/data/globalVariables.dart' as global;

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
  bool isDispiosed = false;

  getNewTime() {
    if (widget.sets.isEmpty) {
      minutes = 0;
      seconds = 0;
      setState(() {});
      return;
    }
    Duration difference =
        widget.sets.last.date.difference(DateTime.now()).abs();
    if (difference > const Duration(minutes: 6)) {
      minutes = 0;
      seconds = 0;
      setState(() {});
      return;
    }

    minutes = (difference.inSeconds / 60).floor();
    seconds = (difference.inSeconds - minutes * 60).round();

    setState(() {});
  }

  int minutes = 0;
  int seconds = 0;

  int currentValueSec = 0;
  int currentValueMin = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isDispiosed) {
        timer.cancel();
        return;
      }
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

  @override
  void dispose() {
    isDispiosed = true;
    super.dispose();
  }

  ScrollController listController1 = ScrollController();
  ScrollController listController2 = ScrollController();
  ScrollController listController3 = ScrollController();

  double digitHeight(BuildContext context) => global.height(context) * .08;

  double blockHeightFactor = .175;
  double blockWidthFactor = .1;
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
        fontSize: global.width(context) * .15,
      );

  @override
  Widget build(BuildContext context) {
    double sliderWidth = global.width(context) * .6;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        child: Container(
          width: global.containerWidth(context),
          margin: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: global.height(context) * .07,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: global.width(context) * .05,
            vertical: global.height(context) * .05,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: global.darkGrey,
            borderRadius: BorderRadius.circular(global.width(context) * 0.1),
            boxShadow: [global.darkShadow(context)],
          ),
          child: Stack(
            children: [
              // TIMER
              ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: IgnorePointer(
                  ignoring: true,
                  child: global.gradient(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                                    ...List.generate(10, (index) => index)
                                        .map((e) {
                                      bool visible = minutes % 10 == e;

                                      return AnimatedOpacity(
                                        duration:
                                            global.standardAnimationDuration,
                                        opacity: visible ? 1 : 0,
                                        child: digit('0'),
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
                                    ...List.generate(10, (index) => index)
                                        .map((e) {
                                      bool visible = minutes % 10 == e;

                                      return AnimatedOpacity(
                                        duration:
                                            global.standardAnimationDuration,
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
                              top: digitHeight(context),
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
                                    ...List.generate(10, (index) => index)
                                        .map((e) {
                                      bool visible =
                                          ((seconds - (seconds % 10)) / 10) ==
                                              e;

                                      return AnimatedOpacity(
                                        duration:
                                            global.standardAnimationDuration,
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
                              SizedBox(
                                width: global.width(context) * blockWidthFactor,
                                height: digitHeight(context) * listHeightFactor,
                                child: ListView(
                                  controller: listController1,
                                  children: [
                                    digit(' '),
                                    ...List.generate(10, (index) => index)
                                        .map((e) {
                                      bool visible = (seconds % 10) == e;

                                      return AnimatedOpacity(
                                        duration:
                                            global.standardAnimationDuration,
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
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: global.height(context) * .2),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 6,
                          width: sliderWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                        AnimatedContainer(
                          duration: global.standardAnimationDuration,
                          height: 6,
                          width: (minutes == 0 && seconds == 0) ||
                                  (minutes > 2 && seconds > 30)
                              ? sliderWidth
                              : ((Duration(minutes: minutes, seconds: seconds)
                                          .inSeconds) /
                                      (const Duration(minutes: 2, seconds: 30)
                                          .inSeconds)) *
                                  100 *
                                  (sliderWidth / 100),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: global.height(context) * .015),
                    SizedBox(
                      width: sliderWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ['00:00', '01:30', '02:30']
                            .map((e) => Text(
                                  e,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: global.width(context) * .05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rest-Timer',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                        fontSize: global.width(context) * .08,
                      ),
                    ),
                    IconButton(
                      onPressed: () => showCustomModalBottomSheet(
                        context,
                        ModalBottomSheet(
                          title: 'The "Rest-Timer"',
                          titleSize: 28,
                          height: global.height(context) * .425,
                          content: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: global.width(context) * .1,
                            ),
                            child: Text(
                              'The "Rest-Timer" starts after you enter a set. It will automaticly stop after 6 minutes. Optimal rest depends on muscle size, the bigger the muscle the longer the rest. Studies tend to say 2-4m is optimal!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: global.width(context) * .04,
                              ),
                            ),
                          ),
                          submitButtonText: 'Got it!',
                        ),
                      ),
                      icon: Icon(
                        CupertinoIcons.info_circle,
                        color: Theme.of(context).colorScheme.onBackground,
                        size: global.width(context) * .075,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
