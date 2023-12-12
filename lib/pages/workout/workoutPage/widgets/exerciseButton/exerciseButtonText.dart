import 'package:flutter/material.dart';

class ExerciseButtonText extends StatelessWidget {
  const ExerciseButtonText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bench Press',
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontSize: 30,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
          'PR - 100KG - 12REPS',
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w100,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}