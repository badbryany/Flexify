import 'package:flexify/data/exerciseModels.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class ExerciseButtonLight extends StatefulWidget {
  const ExerciseButtonLight({
    super.key,
    required this.exercise,
    required this.sets,
  });

  final Exercise exercise;
  final List<Set> sets;

  @override
  State<ExerciseButtonLight> createState() => _ExerciseButtonLightState();
}

class _ExerciseButtonLightState extends State<ExerciseButtonLight> {
  double recoverValue = 0.0;

  Color recoverColor = const Color.fromARGB(255, 255, 116, 116);

  getData() {
    if (widget.sets.isEmpty) {
      recoverValue = 1;
      recoverColor = const Color.fromARGB(255, 162, 251, 162);
      return;
    }

    recoverValue =
        (widget.sets.last.date.difference(DateTime.now()).inHours).abs() / 72;

    if (recoverValue > 1) {
      recoverValue = 1;
    }

    if (recoverValue <= 0.5) {
      recoverColor =
          Color.fromARGB(255, 251, (164 * recoverValue + 164).toInt(), 164);
    }

    if (recoverValue > 0.5) {
      recoverColor =
          Color.fromARGB(255, (-164 * recoverValue + 328).toInt(), 251, 164);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight = global.height(context) * .1;

    String name = widget.exercise.name;
    if (name.length > 29) {
      name = '${name.substring(0, 26).trim()}...';
    }

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        vertical: 6,
        horizontal:
            (global.width(context) * (1 - global.containerWidthFactor)) / 2,
      ),
      height: containerHeight,
      width: global.containerWidth(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(global.borderRadius - 5),
        child: Stack(
          children: [
            // recoverystate indicator
            Container(
              width: global.containerWidth(context) * recoverValue,
              height: containerHeight,
              color: recoverColor,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: global.width(context) * .05,
              ),
              height: containerHeight,
              width: global.containerWidth(context),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background.withOpacity(.9),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: global.width(context) * .05,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
