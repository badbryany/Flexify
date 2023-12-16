import 'package:flexify/pages/workout/exercisesPage/setsPage/setsPage.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/pages/workout/exercisesPage/widgets/muscleCooldown.dart';

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
        s_id: -1,
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

  @override
  Widget build(BuildContext context) {
    String name = widget.exercise.name;
    if (name.length > 40) {
      name = '${name.substring(0, 37)}...';
    }

    return Dismissible(
      key: ValueKey(name),
      background: Container(
        margin: const EdgeInsets.all(7.5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error.withOpacity(0.3),
          borderRadius: BorderRadius.circular(35),
        ),
        child: const Text(
          'delete exercise',
          // style: TextStyle(fontSize: 25),
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

                  await Save.deleteExercise(widget.exercise);
                  await widget.reload();

                  await Save.saveExercise(widget.exercise);

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
              type: PageTransitionType.fade,
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.2,
            padding: const EdgeInsets.all(30),
            margin: const EdgeInsets.all(7.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Theme.of(context).colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).focusColor,
                  spreadRadius: -10.0,
                  blurRadius: 10.0,
                  offset: const Offset(0, 10.0),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                          fontSize: name.length > 13 ? 20 : 30,
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
                      ),
                    ),

                    const SizedBox(height: 20),
                    // LAST TRAIN DATE
                    widget.sets.isNotEmpty
                        ? Text(
                            'last set: ${dateString(widget.sets.last.date)} at ${zeroBefore(widget.sets.last.date.hour)}:${zeroBefore(widget.sets.last.date.minute)}',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.4),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                MuscleCooldown(
                  sets: widget.sets,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
