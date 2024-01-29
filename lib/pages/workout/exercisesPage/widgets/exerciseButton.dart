import 'dart:async';

import 'package:flexify/pages/workout/exercisesPage/setsPage/addeditSetPage/addeditSetPage.dart';
import 'package:flexify/pages/workout/exercisesPage/setsPage/setsPage.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/widgets/DeleteAlertBox.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/pages/workout/exercisesPage/widgets/muscleCooldown.dart';
import 'dart:math';
import 'package:flexify/data/globalVariables.dart' as global;

class ExerciseButton extends StatefulWidget {
  const ExerciseButton({
    super.key,
    required this.exercise,
    required this.reload,
    required this.sets,
  });

  final Exercise exercise;
  final Function reload;
  final List<Set> sets;

  @override
  State<ExerciseButton> createState() => _ExerciseButtonState();
}

class _ExerciseButtonState extends State<ExerciseButton> {
  Set getMaxSet(List<Set> sets) {
    if (sets.isEmpty) {
      return Set(
        setID: -1,
        date: DateTime.now(),
        exerciseName: widget.exercise.name,
        reps: 0,
        weight: 0,
      );
    }

    Set pr = sets[0];
    for (int i = 1; i < sets.length; i++) {
      if (sets[i].weight * sets[i].reps > pr.weight * pr.reps) {
        pr = sets[i];
      }
    }
    return pr;
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

  bool thresholdReached = false;
  double thresholdProgress = 0.0;

  String getPR() {
    double max = widget.sets[0].weight;

    for (int i = 1; i < widget.sets.length; i++) {
      if (widget.sets[i].weight > max) {
        max = widget.sets[i].weight;
      }
    }
    return '${max}kg';
  }

  getNewTime() {
    if (widget.sets.isEmpty) {
      timeString = '--:--';
      setState(() {});
      return;
    }
    Duration difference =
        widget.sets.last.date.difference(DateTime.now()).abs();
    if (difference > const Duration(minutes: 6)) {
      timeString = '--:--';
      setState(() {});
      return;
    }

    int minutes = (difference.inSeconds / 60).floor();
    int seconds = (difference.inSeconds - minutes * 60).round();
// ${difference.inSeconds >= 60 ? (difference.inSeconds / 60).round() : '00'}: ${difference.inSeconds / 60 > 1 ? (difference.inSeconds - (difference.inSeconds / 60)).round() : '00'}

    timeString = '${global.zeroBefore(minutes)}:${global.zeroBefore(seconds)}';
    setState(() {});
  }

  String timeString = '--:--';

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isExpanded) {
        getNewTime();
      }
    });
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String name = widget.exercise.name;
    if (name.length > 20) {
      name = '${name.substring(0, 17)}...';
    }
    return Dismissible(
      key: ValueKey(name),
      dismissThresholds: const {DismissDirection.endToStart: 0.7},
      direction: DismissDirection.horizontal,
      background: AnimatedContainer(
        key: const ValueKey(Alignment),
        duration: const Duration(milliseconds: 150),
        alignment:
            thresholdReached ? Alignment.centerLeft : Alignment.centerRight,
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        padding: thresholdReached
            ? EdgeInsets.only(
                left: max(
                    ((1 - thresholdProgress) *
                            (global.containerWidthFactor) *
                            MediaQuery.of(context).size.width) +
                        MediaQuery.of(context).size.width * 0.05,
                    (MediaQuery.of(context).size.width * 0.1)))
            : EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * 0.08),
        ),
        child: Text(
          'delete',
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontSize: MediaQuery.of(context).size.width * 0.035,
          ),
        ),
      ),
      confirmDismiss: (diracion) async {
        bool returnValue = false;
        await showDialog(
          context: context,
          builder: (context) => DeleteAlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  returnValue = false;
                  Navigator.pop(context);
                },
                child: const Text('cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await Save.deleteExercise(widget.exercise);
                  await widget.reload();
                  returnValue = true;
                  Navigator.pop(context);
                },
                child: const Text('delete'),
              ),
            ],
          ),
        );
        return returnValue;
      },
      onUpdate: (details) {
        thresholdReached = details.reached;
        thresholdProgress = details.progress;
        setState(() {});
      },
      child: BounceElement(
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            PageTransition(
              child: ExerciseSets(
                name: widget.exercise.name,
                refresh: widget.reload,
              ),
              type: PageTransitionType.rightToLeft,
            ),
          ).then((value) => widget.reload),
          child: AnimatedContainer(
            duration: global.standardAnimationDuration,
            width:
                MediaQuery.of(context).size.width * global.containerWidthFactor,
            height:
                MediaQuery.of(context).size.height * (isExpanded ? 0.5 : 0.18),
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.08),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(global.borderRadius),
              color: Theme.of(context).colorScheme.background,
              boxShadow: [global.darkShadow],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width *
                          (global.containerWidthFactor - 0.3),
                      child: AnimatedScale(
                        scale: isExpanded ? 1.1 : 1,
                        duration: global.standardAnimationDuration,
                        child: Text(
                          name,
                          key: ValueKey(isExpanded),
                          maxLines: 1,
                          style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: MediaQuery.of(context).size.width *
                                (isExpanded ? 0.058 : 0.0525),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => setState(() {
                        isExpanded = !isExpanded;
                      }),
                      icon: AnimatedSwitcher(
                          duration: global.standardAnimationDuration,
                          key: ValueKey(isExpanded),
                          child: Icon(
                            isExpanded
                                ? Icons.expand_less_rounded
                                : Icons.expand_more_rounded,
                          )),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ],
                ),
                Visibility(
                  visible: isExpanded,
                  child: AnimatedContainer(
                    duration: global.standardAnimationDuration,
                    height: isExpanded
                        ? MediaQuery.of(context).size.height * 0.34
                        : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                getPR(),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                              ),
                              IconButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  PageTransition(
                                    child: AddEditSet(
                                      add: true,
                                      set: null,
                                      exerciseName: widget.exercise.name,
                                    ),
                                    type: PageTransitionType.fade,
                                  ),
                                ).then((value) => widget.reload()),
                                icon: Icon(
                                  Icons.add,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.18,
                                child: Text(
                                  timeString,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.06,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            'last 3 sets:',
                            style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...widget.sets.reversed.take(3).map(
                              (e) => SmallSetWidget(set: e),
                            ),
                      ],
                    ),
                  ),
                ),
                MuscleCooldown(
                  sets: widget.sets,
                  width: MediaQuery.of(context).size.width *
                      (global.containerWidthFactor - 0.12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SmallSetWidget extends StatelessWidget {
  const SmallSetWidget({
    super.key,
    required this.set,
  });

  final Set set;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(global.borderRadius - 20),
        color: Theme.of(context).colorScheme.surface.withOpacity(0.05),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '${set.weight}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${global.zeroBefore(set.date.hour)}:${global.zeroBefore(set.date.minute)}',
                style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${set.reps}',
                style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
