import 'package:flutter/material.dart';

class MuscleCooldown extends StatefulWidget {
  const MuscleCooldown({super.key});

  @override
  State<MuscleCooldown> createState() => _MuscleCooldownState();
}

class _MuscleCooldownState extends State<MuscleCooldown> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.scale(
          scale: 3.0,
          child: CircularProgressIndicator(
            value: 0.8,
            color: Theme.of(context).colorScheme.primary,
            strokeCap: StrokeCap.round,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Deltoids',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            Text(
              'Ready',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
                fontSize: 15,
              ),
            )
          ],
        ),
      ],
    );
  }
}
