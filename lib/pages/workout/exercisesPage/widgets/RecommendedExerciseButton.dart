import 'package:flutter/material.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/pages/workout/exercisesPage/widgets/MuscleCooldown.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class RecommendedExerciseButton extends StatefulWidget {
  const RecommendedExerciseButton({
    super.key,
    required this.exercise,
    required this.reload,
    required this.sets,
  });

  final Exercise exercise;
  final Function reload;
  final List<Set> sets;

  @override
  State<RecommendedExerciseButton> createState() => _RecommendedExerciseButtonState();
}

class _RecommendedExerciseButtonState extends State<RecommendedExerciseButton> {
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

    return Container(
      width:
          MediaQuery.of(context).size.width * global.containerWidthFactor,
      height: MediaQuery.of(context).size.width * 0.3,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.08),
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * 0.08),
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
                    fontSize: MediaQuery.of(context).size.width * 0.035,
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
                  fontSize: MediaQuery.of(context).size.width * 0.02,
                ),
              ),
              widget.sets.isNotEmpty
                  ? Text(
                      'last set: ${dateString(widget.sets.last.date)} at ${zeroBefore(widget.sets.last.date.hour)}:${zeroBefore(widget.sets.last.date.minute)}',
                      style: TextStyle(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.4),
                        fontSize:
                            MediaQuery.of(context).size.width * 0.02,
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
                width: MediaQuery.of(context).size.width * 0.07,
                height: MediaQuery.of(context).size.width * 0.07,
                child: MuscleCooldown(
                  sets: widget.sets,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
