import 'package:flutter/material.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class MuscleCooldown extends StatefulWidget {
  const MuscleCooldown({
    super.key,
    required this.sets,
    required this.width,
  });

  final List<Set> sets;
  final double width;

  @override
  State<MuscleCooldown> createState() => _MuscleCooldownState();
}

class _MuscleCooldownState extends State<MuscleCooldown> {
  String loadString = '';

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

    /* 
    
    ----------- TEMPORAL COLOR GRADIENT -----------
    
    RED -> ORANGE
        255, 246, 0, 0 -> 255, 246, 255, 0
        RECOVER VALUE <= 0.5 -> 255, 255, (255 / RECOVERVALUE * 2), 0

    ORANGE -> GREEN
        255, 246, 246, 0 ->  255, 100, 246, 0
        RECOVER VALUE > 0.5  -> 255, (-255 * RECOVERVALUE + 510), 255, 

    */

    // if (recoverValue <= 0.5) {
    //   recoverColor = Color.fromARGB(255, 255, ((255 * recoverValue).toInt()), 0);
    // }

    // if (recoverValue > 0.5) {
    //   recoverColor = Color.fromARGB(255, ((-255 * recoverValue + 510).toInt()), 255, 0);
    // }

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
  Widget build(BuildContext context) {
    getData();
    double height = MediaQuery.of(context).size.height * 0.006;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              height: height,
              width: (widget.width * 0.825),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
              ),
            ),
            AnimatedContainer(
              duration: global.standardAnimationDuration * 2,
              height: height,
              width: (widget.width * 0.825) * recoverValue,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: recoverColor,
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Text(
          '${(recoverValue * 100).round()}%',
          style: TextStyle(
            color: recoverColor,
            fontSize: MediaQuery.of(context).size.width * 0.03,
          ),
        ),
      ],
    );
  }
}
