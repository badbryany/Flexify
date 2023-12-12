import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/pages/workout/workoutPage/setPage/setsPage.dart';
import 'package:flexify/pages/workout/workoutPage/widgets/exerciseButton/exerciseButtonContainer.dart';
import 'package:flexify/pages/workout/workoutPage/widgets/exerciseButton/exerciseButtonText.dart';
import 'package:flexify/pages/workout/workoutPage/widgets/exerciseButton/muscleCooldown.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageTransition(
          child: ExerciseSets(
            name: widget.exercise.name,
            refresh: widget.reload,
          ),
          type: PageTransitionType.fade,
        ),
      ),
      child: ExerciseButtonContainer(
        content: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ExerciseButtonText(),
              MuscleCooldown(),
            ],
          ),
        ),
      ),
    );
  }
}
