import 'package:flexify/pages/workout/exercisesPage/setsPage/setsPage.dart';
import 'package:flexify/widgets/BounceElement.dart';
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

  String zeroBefore(int num) {
    if (num <= 9) {
      return '0$num';
    }
    return '$num';
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

  @override
  Widget build(BuildContext context) {
    String name = widget.exercise.name;
    if (name.length > 40) {
      name = '${name.substring(0, 37)}...';
    }

    return Dismissible(
      key: ValueKey(name),
      dismissThresholds: const {DismissDirection.endToStart: 0.7},
      direction: DismissDirection.endToStart,
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
          'DELETE',
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontSize: MediaQuery.of(context).size.width * 0.025,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onDismissed: (direction) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.background,
            content: Text(
              'Do you want to delete this exercise?',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  List<Set> sets = (await Save.getSetList())
                      .where((element) =>
                          element.exerciseName == widget.exercise.name)
                      .toList();

                  for (var i = 0; i < sets.length; i++) {
                    await Save.saveSet(sets[i]);
                  }

                  await widget.reload();

                  Navigator.pop(context);
                },
                child: const Text('cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await Save.deleteExercise(widget.exercise);
                  await widget.reload();
                  Navigator.pop(context);
                },
                child: const Text('delete'),
              ),
            ],
          ),
        );
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
                refresh: () {
                  widget.reload();
                },
              ),
              type: PageTransitionType.rightToLeft,
            ),
          ),
          child: Container(
            width:
                MediaQuery.of(context).size.width * global.containerWidthFactor,
            height: MediaQuery.of(context).size.width * 0.34,
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.08),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(global.borderRadius),
              color: Theme.of(context).colorScheme.background,
              boxShadow: [global.darkShadow],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        name,
                        style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'best set: ${getMaxSet(widget.sets).reps} x ${getMaxSet(widget.sets).weight}kg',
                      style: TextStyle(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.4),
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // LAST TRAIN DATE
                    widget.sets.isNotEmpty
                        ? Text(
                            'last set: ${dateString(widget.sets.last.date)} at ${zeroBefore(widget.sets.last.date.hour)}:${zeroBefore(widget.sets.last.date.minute)}',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.4),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.1),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.08,
                      height: MediaQuery.of(context).size.width * 0.08,
                      child: MuscleCooldown(
                        sets: widget.sets,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
