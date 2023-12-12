import 'package:flutter/material.dart';

class ExerciseButtonContainer extends StatefulWidget {
  const ExerciseButtonContainer({super.key, required this.content});
  final Widget content;

  @override
  State<ExerciseButtonContainer> createState() => _ExerciseButtonContainerState();
}

class _ExerciseButtonContainerState extends State<ExerciseButtonContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white60),
        borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.height * 0.9 * 0.075),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.background,
            blurRadius: 10,
            offset: const Offset(5.0, 5.0),
          ),
        ],
      ),
      child: widget.content
    );
  }
}
