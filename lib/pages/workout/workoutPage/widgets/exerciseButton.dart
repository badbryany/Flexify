import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/pages/workout/workoutPage/setPage/setsPage.dart';
import 'package:flexify/pages/workout/workoutPage/widgets/muscleCooldown.dart';

class ExerciseButton extends StatefulWidget {
  const ExerciseButton({
    super.key,
    required this.exercise,
    required this.reload,
  });

  final Exercise exercise;
  final Function reload;

  @override
  State<ExerciseButton> createState() => _ExerciseButtonState();
}

class _ExerciseButtonState extends State<ExerciseButton> {
  List<Set> sets = [];
  getData() async {
    sets = (await Save.setSetIfNull())
        .map((e) => Set.fromStringToObject(e))
        .where((e) => e.exerciseName == widget.exercise.name)
        .toList();

    setState(() {});
  }

  Set getMaxSet(List<Set> sets) {
    if (sets.isEmpty) {
      return Set(
        setId: -1,
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
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.exercise.name;
    if (name.length > 40) {
      name = '${name.substring(0, 37)}...';
    }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageTransition(
          child: ExerciseSets(
            name: widget.exercise.name,
            refresh: () {
              widget.reload();
              getData();
            },
          ),
          type: PageTransitionType.fade,
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.2,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Theme.of(context).colorScheme.background,
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
                  'best set: ${getMaxSet(sets).reps} x ${getMaxSet(sets).weight}kg',
                  style: TextStyle(
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.4),
                  ),
                ),

                const SizedBox(height: 20),
                // LAST TRAIN DATE
                sets.isNotEmpty
                    ? Text(
                        'last set: ${dateString(sets.last.date)} at ${zeroBefore(sets.last.date.hour)}:${zeroBefore(sets.last.date.minute)}',
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
              sets: sets,
            ),
          ],
        ),
      ),
    );
  }
}
