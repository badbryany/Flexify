import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/data/exerciseModels.dart';

class WorkoutTimer extends StatefulWidget {
  const WorkoutTimer({
    super.key,
    required this.sets,
  });

  final List<Set> sets;

  @override
  State<WorkoutTimer> createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends State<WorkoutTimer> {
  DateTime startTime = DateTime.now();

  startTimer() {
    // find first set this workout
    int index = widget.sets.length - 1;
    for (var i = index; i >= 0; i--) {
      if (i == 0 &&
          widget.sets[i].date.difference(DateTime.now()) <
              const Duration(hours: 1)) {
        startTime = widget.sets[i].date;
        break;
      }
      if (widget.sets[i].date.difference(widget.sets[i - 1].date) >
          const Duration(hours: 1)) {
        startTime = widget.sets[i].date;
        break;
      }
    }

    Timer.periodic(
      const Duration(seconds: 1),
      update,
    );
  }

  update(Timer timer) {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: global.width(context) * .25,
      child: Column(
        children: [
          global.gradient(
            Text(
              global.durationString(
                startTime.difference(DateTime.now()).abs(),
                hours: true,
              ),
              style: TextStyle(
                fontSize: global.width(context) * .05,
              ),
            ),
          ),
          const SizedBox(height: 2.5),
          Text(
            'workout time',
            maxLines: 1,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
              fontSize: global.width(context) * .025,
            ),
          ),
        ],
      ),
    );
  }
}
