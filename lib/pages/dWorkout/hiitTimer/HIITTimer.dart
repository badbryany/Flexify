import 'dart:async';
import 'dart:math';
import 'package:flexify/pages/dShop/pages/widgets/ShopNavbar.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'Round.dart';
import 'package:flutter/services.dart';

class HiitTimer extends StatefulWidget {
  const HiitTimer({
    super.key,
    required this.rounds,
  });

  final List<Round> rounds;

  @override
  State<HiitTimer> createState() => _HiitTimerState();
}

class _HiitTimerState extends State<HiitTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  Timer? timer;
  bool paused = false;

  bool done = false;
  int roundCount = -1;
  int roundIndex = 0;

  Soundpool? _pool;
  int? beepId;
  int? boxingBellId;

  List<Map<String, dynamic>> durations = [
    {
      'title': 'Get ready!',
      'isRound': false,
      'duration': const Duration(seconds: 5),
    },
  ];

  Duration currentCountDuration = Duration.zero;
  Duration currentCountDurationInitValue = Duration.zero;

  updateTimer(Timer tim) {
    currentCountDuration -= const Duration(seconds: 1);

    if (currentCountDuration == const Duration(seconds: 2) ||
        currentCountDuration == const Duration(seconds: 1) ||
        currentCountDuration == Duration.zero) {
      _playSound(beepId);
    }

    if (currentCountDuration < Duration.zero) {
      _playSound(boxingBellId);
      if (durations[roundIndex]['isRound']) {
        roundCount++;
      }
      roundIndex++;

      currentCountDurationInitValue = durations[roundIndex]['duration'];
      currentCountDuration = durations[roundIndex]['duration'];
    }

    if (roundIndex == durations.length - 1) {
      tim.cancel();
      done = true;
    }
    setState(() {});
  }

  skipRound() {
    currentCountDuration = Duration.zero;
    setState(() {});
  }

  startTimer() async {
    List<String> restSequences = [
      "Catch your breath!",
      "Relax and recover!",
      "Take it easy!",
      "Slow down!",
      "Rest up!",
      "Breathe deeply!",
      "Pause and relax!",
      "Take a break!",
      "Cool down now!",
      "Unwind for a moment!"
    ];

    for (int i = 0; i < widget.rounds.length; i++) {
      durations.add({
        'title': widget.rounds[i].title,
        'isRound': true,
        'duration': widget.rounds[i].roundDuration,
      });
      durations.add({
        'title': restSequences[Random().nextInt(restSequences.length - 1)],
        'isRound': false,
        'duration': widget.rounds[i].restDuration,
      });
    }

    roundCount = 0;
    currentCountDurationInitValue = durations[roundIndex]['duration'];
    currentCountDuration = durations[roundIndex]['duration'];
    setState(() {});

    timer = Timer.periodic(const Duration(seconds: 1), updateTimer);
  }

  stopTimer() => timer?.cancel();

  Future<void> _initSounds() async {
    _pool = Soundpool(streamType: StreamType.notification);

    beepId = await _loadSound('assets/sounds/beep.mp3');
    boxingBellId = await _loadSound('assets/sounds/boxing-bell.mp3');
  }

  Future<int> _loadSound(String asset) async {
    return await rootBundle.load(asset).then((ByteData soundData) {
      return _pool!.load(soundData);
    });
  }

  void _playSound(int? soundId) {
    if (soundId != null) {
      _pool?.play(soundId);
    }
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: global.standardAnimationDuration,
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    KeepScreenOn.turnOn();

    super.initState();
    _initSounds();
    startTimer();
  }

  @override
  void dispose() {
    controller.dispose();
    _pool?.dispose();
    KeepScreenOn.turnOff();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ShopNavbar(
              title: 'HIIT Timer - ${widget.rounds.length} Rounds',
              titleSize: global.width(context) * .06,
              alignmentWidth: 0,
            ),
            Visibility(
              visible: !done,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: global.width(context) * .825,
                      width: global.width(context) * .825,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        color: global.darkGrey,
                      ),
                      child: Center(
                        child: CircularPercentIndicator(
                          radius: global.width(context) * .8 / 2,
                          lineWidth: global.width(context) * .045,
                          animationDuration: 1000,
                          curve: Curves.linear,
                          animation: true,
                          linearGradient: global.linearGradient,
                          percent: currentCountDuration.inSeconds /
                              currentCountDurationInitValue.inSeconds,
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          animateFromLastPercent: true,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                durations[roundIndex]['isRound']
                                    ? 'Round ${roundCount + 1}'
                                    : 'Rest',
                                style: TextStyle(
                                  fontSize: global.width(context) * .07,
                                  color: Colors.white,
                                ),
                              ),
                              global.mediumHeight(context),
                              Text(
                                global.durationString(currentCountDuration),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: global.width(context) * .15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  global.largeHeight(context),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: global.width(context) * .03,
                      vertical: global.width(context) * .015,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(.25),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      'LAP',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: global.width(context) * .05,
                      ),
                    ),
                  ),
                  global.mediumHeight(context),
                  Text(
                    '${roundCount + 1}/${widget.rounds.length}',
                    style: TextStyle(
                      color: Theme.of(context).focusColor,
                      fontSize: global.width(context) * .1125,
                    ),
                  ),
                ],
              ),
            ),
            // Positioned(
            //   top: global.height(context) * .2,
            //   left: 0,
            //   right: 0,
            //   child: AnimatedOpacity(
            //     duration: global.standardAnimationDuration,
            //     opacity: done ? 1 : 0,
            //     child: Container(
            //       padding: const EdgeInsets.all(15),
            //       margin: EdgeInsets.symmetric(
            //         horizontal: global.width(context) *
            //             ((1 - global.containerWidthFactor) / 2),
            //       ),
            //       width: global.containerWidth(context),
            //       decoration: BoxDecoration(
            //         boxShadow: global.shadow(context),
            //         color: Theme.of(context).colorScheme.background,
            //         borderRadius:
            //             BorderRadius.circular(global.borderRadius - 5),
            //       ),
            //       child: Column(
            //         children: [
            //           Text(
            //             'Finished!',
            //             style: TextStyle(
            //               fontSize: global.width(context) * .1,
            //             ),
            //           ),
            //           Text(
            //             'Total Workouttime: ${global.durationString(Duration(seconds: durations.map((e) => (e['duration'] as Duration).inSeconds).reduce((a, b) => a + b)))}',
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            global.largeHeight(context),
            global.largeHeight(context),
            global.largeHeight(context),
            global.largeHeight(context),

            AnimatedOpacity(
              duration: global.standardAnimationDuration,
              opacity: done ? 0 : 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(global.borderRadius - 2.5),
                  color: global.darkGrey,
                ),
                width: global.width(context) * 825,
                margin: EdgeInsets.symmetric(
                    horizontal: global.width(context) * .075),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () => setState(
                        () => currentCountDuration =
                            currentCountDurationInitValue,
                      ),
                      icon: Icon(
                        CupertinoIcons.refresh,
                        color: Colors.white,
                        size: global.width(context) * .075,
                      ),
                    ),
                    IconButton(
                      onPressed: () => setState(
                        () {
                          paused = !paused;
                          if (paused) {
                            timer?.cancel();
                            controller.forward();
                          } else {
                            updateTimer(timer!);
                            timer = Timer.periodic(
                                const Duration(seconds: 1), updateTimer);
                            controller.reverse();
                          }
                        },
                      ),
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.pause_play,
                        progress: animation,
                        color: Colors.white,
                        size: global.width(context) * .15,
                      ),
                    ),
                    IconButton(
                      onPressed: skipRound,
                      icon: Icon(
                        CupertinoIcons.arrow_right_to_line_alt,
                        color: Colors.white,
                        size: global.width(context) * .08,
                      ),
                    ),
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
