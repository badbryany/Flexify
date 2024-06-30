import 'package:flexify/pages/dWorkout/hiitTimer/widgets/SetTime.dart';
import 'package:flexify/widgets/Navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';

class HIITTimer extends StatefulWidget {
  const HIITTimer({super.key});

  @override
  State<HIITTimer> createState() => _HIITTimerState();
}

class _HIITTimerState extends State<HIITTimer> {
  Duration roundTime = Duration.zero;
  Duration restTime = Duration.zero;

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

  startTimer() async {
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

    // saved Data

    // !Start timer
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
        child: Column(
          children: [
            Navbar(
              title: 'HIIT Timer',
              titleSize: global.width(context) * .075,
              actionButton: ActionButton(
                iconData: CupertinoIcons.play,
                action: startTimer,
              ),
            ),
            roundTime == Duration.zero
                ? global.loadingWidget(context, 1)
                : SetTime(
                    title: 'Rundenzeit',
                    initDuration: roundTime,
                    update: (Duration newDur) => roundTime = newDur,
                  ),
            global.smallHeight(context),
            restTime == Duration.zero
                ? global.loadingWidget(context, 1)
                : SetTime(
                    title: 'Ruhezeit',
                    initDuration: restTime,
                    update: (Duration newDur) => restTime = newDur,
                  ),
          ],
        ),
      ),
    );
  }
}
