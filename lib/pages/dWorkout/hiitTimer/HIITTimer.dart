import 'package:flexify/pages/dWorkout/hiitTimer/widgets/SetTime.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/widgets/ModalBottomSheet.dart';
import 'package:flexify/widgets/Navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

class HIITTimer extends StatefulWidget {
  const HIITTimer({super.key});

  @override
  State<HIITTimer> createState() => _HIITTimerState();
}

class _HIITTimerState extends State<HIITTimer> {
  Duration roundTime = Duration.zero;
  Duration restTime = Duration.zero;

  final GlobalKey<AnimatedListState> animatedListKey =
      GlobalKey<AnimatedListState>();
  List<Round> rounds = [];

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getInt('roundTimeSeconds') == null ||
        prefs.getInt('roundTimeMinutes') == null ||
        prefs.getInt('restTimeMinutes') == null ||
        prefs.getInt('restTimeSeconds') == null) {
      prefs.setInt('restTimeMinutes', 0);
      prefs.setInt('restTimeSeconds', 10);
      prefs.setInt('roundTimeMinutes', 0);
      prefs.setInt('roundTimeSeconds', 30);
    }

    roundTime = Duration(
      minutes: prefs.getInt('roundTimeMinutes')!,
      seconds: prefs.getInt('roundTimeSeconds')!,
    );

    restTime = Duration(
      minutes: prefs.getInt('restTimeMinutes')!,
      seconds: prefs.getInt('restTimeSeconds')!,
    );

    setState(() {});
  }

  addRoundTime(Duration dur) => setState(() => roundTime += dur);
  subRoundTime(Duration dur) => setState(() => roundTime -= dur);

  addRestTime(Duration dur) => setState(() => restTime += dur);
  subRestTime(Duration dur) => setState(() => restTime -= dur);

  saveTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double microseconds = roundTime.inMicroseconds.toDouble();
    int minutes = microseconds ~/ Duration.microsecondsPerMinute;
    microseconds = microseconds.remainder(Duration.microsecondsPerMinute);
    int seconds = microseconds ~/ Duration.microsecondsPerSecond;
    microseconds = microseconds.remainder(Duration.microsecondsPerSecond);

    prefs.setInt('roundTimeMinutes', minutes);
    prefs.setInt('roundTimeSeconds', seconds);

    microseconds = restTime.inMicroseconds.toDouble();
    minutes = microseconds ~/ Duration.microsecondsPerMinute;
    microseconds = microseconds.remainder(Duration.microsecondsPerMinute);
    seconds = microseconds ~/ Duration.microsecondsPerSecond;
    microseconds = microseconds.remainder(Duration.microsecondsPerSecond);

    prefs.setInt('restTimeMinutes', minutes);
    prefs.setInt('restTimeSeconds', seconds);
  }

  startTimer() async {
    await saveTimer();

    // !Start timer
  }

  resetTimer() async {
    Duration newRoundTime = const Duration(seconds: 30);
    Duration newRestTime = const Duration(seconds: 10);

    while (roundTime != newRoundTime || restTime != newRestTime) {
      if (roundTime != newRoundTime) roundTime -= const Duration(seconds: 1);
      if (restTime != newRestTime) restTime -= const Duration(seconds: 1);

      setState(() {});

      await Future.delayed(const Duration(milliseconds: 50));
    }

    await saveTimer();
  }

  addRound() {
    rounds.add(Round(
      title: 'Round ${rounds.length + 1}',
      roundDuration: const Duration(seconds: 45),
      restDuration: const Duration(seconds: 10),
    ));
    setState(() {});

    animatedListKey.currentState!.insertItem(rounds.length - 1);
  }

  removeRound(Round delRound, Widget child) {
    for (int i = 0; i < rounds.length; i++) {
      if (rounds[i].title == delRound.title) {
        animatedListKey.currentState!.removeItem(
          i,
          (context, animation) => SizeTransition(
            axisAlignment: 0,
            sizeFactor: animation,
            child: SlideTransition(
              position: animation.drive(
                Tween(begin: const Offset(1, .5), end: const Offset(0, 0)),
              ),
              child: child,
            ),
          ),
        );
        rounds.removeAt(i);
        break;
      }
    }

    for (int i = 0; i < rounds.length; i++) {
      if (rounds[i].title.contains('Round ')) {
        rounds[i].title = 'Round ${i + 1}';
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              width: global.width(context),
              child: Navbar(
                title: 'HIIT Timer',
                titleSize: global.width(context) * .075,
                topRightWidget: SizedBox(
                  width: global.width(context) * Navbar.actionButtonWidthFactor,
                  child: Column(
                    children: [
                      Text(
                        '${rounds.length}',
                        style: TextStyle(
                          fontSize: global.width(context) * .075,
                        ),
                      ),
                      Text(
                        'round${rounds.length > 1 ? 's' : ''}',
                        style: TextStyle(
                          fontSize: global.width(context) * .025,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //
            Center(
              child: AnimatedOpacity(
                opacity: rounds.isEmpty ? 1 : 0,
                duration: global.standardAnimationDuration,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Click  \'+\'  to add a round!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: global.width(context) * 0.04,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                    Transform.rotate(
                      angle: -1.8,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: SvgPicture.asset(
                          'assets/Squiggly Arrow.svg',
                          width: global.width(context) * 0.8,
                          height: global.width(context) * 0.6,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedOpacity(
              duration: global.standardAnimationDuration,
              opacity: rounds.isEmpty ? 0 : 1,
              child: Center(
                child: SizedBox(
                  width: global.width(context),
                  height: global.height(context) * .7,
                  child: AnimatedList(
                    key: animatedListKey,
                    initialItemCount: rounds.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index, animation) => SlideTransition(
                      position: animation.drive(
                        Tween(
                          begin: const Offset(1, 0),
                          end: const Offset(0, 0),
                        ),
                      ),
                      child: rounds[index].getWidget(
                        context,
                        setState,
                        removeRound,
                        index,
                        rounds.length,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //
            Positioned(
              bottom: 0,
              child: Container(
                margin: EdgeInsets.all(global.width(context) * .1),
                width: global.containerWidth(context),
                child: Row(
                  children: [
                    BounceElement(
                      child: GestureDetector(
                        onTap: () => addRound(),
                        child: Container(
                          alignment: Alignment.center,
                          height: global.height(context) * .075,
                          width: global.height(context) * .075,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(
                              global.borderRadius - 5,
                            ),
                          ),
                          child: Icon(
                            CupertinoIcons.add,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                    //
                    SizedBox(width: global.width(context) * .05),
                    //
                    BounceElement(
                      child: GestureDetector(
                        onTap: startTimer,
                        child: Container(
                          alignment: Alignment.center,
                          height: global.height(context) * .075,
                          width: global.width(context) * .6,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(
                              global.borderRadius - 5,
                            ),
                          ),
                          child: global.gradient(Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.play,
                                size: global.width(context) * .05,
                              ),
                              SizedBox(width: global.width(context) * .025),
                              Text(
                                'Start HIIT-Timer',
                                style: TextStyle(
                                  fontSize: global.width(context) * .05,
                                ),
                              ),
                            ],
                          )),
                        ),
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

class Round {
  Round({
    required this.title,
    required this.roundDuration,
    required this.restDuration,
  });

  String title;
  Duration roundDuration;
  Duration restDuration;

  editTitle(String newTitle) => title = newTitle;

  editRestDuration(Duration newDur) => restDuration = newDur;

  editRoundDuration(Duration newDur) => roundDuration = newDur;

  Widget getWidget(
    BuildContext context,
    void Function(void Function()) setState,
    dynamic Function(Round, Widget) remove,
    int index,
    int totalLength,
  ) =>
      Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: global.width(context) * .03,
            ),
            padding: const EdgeInsets.all(15),
            width: global.containerWidth(context),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(global.borderRadius - 5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: global.width(context) * .05,
                  ),
                ),
                SetTime(
                  title: 'Rundenzeit',
                  duration: roundDuration,
                  add: (foo) {
                    roundDuration += const Duration(seconds: 1);
                    setState(() {});
                  },
                  sub: (foo) {
                    if (roundDuration == const Duration(seconds: 1)) return;

                    roundDuration -= const Duration(seconds: 1);
                    setState(() {});
                  },
                ),
                IconButton(
                  onPressed: () => remove(
                    this,
                    getWidget(context, setState, remove, index, totalLength),
                  ),
                  icon: Icon(
                    CupertinoIcons.trash,
                    size: global.width(context) * .05,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.5),
                  ),
                ),
              ],
            ),
          ),
          //

          AnimatedOpacity(
            duration: global.standardAnimationDuration,
            opacity: index == totalLength - 1 ? 0 : 1,
            child: GestureDetector(
              onTap: () => showCustomModalBottomSheet(
                context,
                ModalBottomSheet(
                  title: 'Resttime after "$title"',
                  titleSize: global.width(context) * .06,
                  onPop: () => Navigator.pop(context),
                  height: global.height(context) * .4,
                  submitButtonText: 'done',
                  content: StatefulBuilder(builder: (context, innerSetState) {
                    return Padding(
                      padding: EdgeInsets.all(global.height(context) * .05),
                      child: Transform.scale(
                        scale: 2,
                        child: SetTime(
                          title: '',
                          duration: restDuration,
                          add: (foo) {
                            restDuration += const Duration(seconds: 1);
                            innerSetState(() {});
                            setState(() {});
                          },
                          sub: (foo) {
                            if (restDuration == const Duration(seconds: 1)) {
                              return;
                            }

                            restDuration -= const Duration(seconds: 1);
                            innerSetState(() {});
                            setState(() {});
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                height: global.height(context) * .05,
                width: global.containerWidth(context),
                color: Colors.transparent,
                child: Text(
                  '${durationString(restDuration)} rest',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).focusColor.withOpacity(.75),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}

String durationString(Duration dur) {
  double microseconds = dur.inMicroseconds.toDouble();

  var minutes = microseconds ~/ Duration.microsecondsPerMinute;
  microseconds = microseconds.remainder(Duration.microsecondsPerMinute);

  var minutesPadding = minutes < 10 ? "0" : "";

  var seconds = microseconds ~/ Duration.microsecondsPerSecond;
  microseconds = microseconds.remainder(Duration.microsecondsPerSecond);

  var secondsPadding = seconds < 10 ? "0" : "";

  return "$minutesPadding$minutes:"
      "$secondsPadding$seconds";
}

/*Slider(
                      max: 120,
                      min: 1,
                      label: durationString(restDuration),
                      activeColor:
                          Theme.of(context).colorScheme.primary.withOpacity(.4),
                      divisions: 120,
                      inactiveColor: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.3),
                      value: restDuration.inSeconds.toDouble(),
                      onChanged: (double change) => innerSetState(
                        () => setState(
                          () => restDuration = Duration(
                            seconds: change.round(),
                          ),
                        ),
                      ),
                    ); */