import 'package:flutter/material.dart';

class WorkoutCreator extends StatelessWidget {
  const WorkoutCreator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Text('Super geile Knöpfe für weight und reps und so'),
      ),
    );
  }
}