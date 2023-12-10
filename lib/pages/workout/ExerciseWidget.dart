import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/pages/workout/ExerciseSets.dart';
import 'package:flexify/pages/workout/addSet.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

class ExerciseWidget extends StatelessWidget {
  const ExerciseWidget({
    super.key,
    required this.exercise,
  });

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageTransition(
          child: ExerciseSets(
            name: exercise.name,
            refresh: () {},
          ),
          type: PageTransitionType.fade,
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(exercise.name),
      ),
    );
  }
}
