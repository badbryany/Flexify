import 'package:flutter/material.dart';
import 'package:flexify/data/exerciseModels.dart';

// ignore: must_be_immutable
class MuscleCooldown extends StatelessWidget {
  MuscleCooldown({
    super.key,
    required this.sets,
  });

  final List<Set> sets;

  String loadString = '';
  double recoverValue = 0.0;
  Color recoverColor = Color.fromARGB(255, 255, 116, 116);
  getData(BuildContext context) {
    if (sets.isEmpty) {
      recoverValue = 1;
      recoverColor = Color.fromARGB(255, 162, 251, 162);
      return;
    }

    recoverValue =
        (sets.last.date.difference(DateTime.now()).inHours).abs() / 72;

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
      recoverColor = Color.fromARGB(255, 251, (164 * recoverValue + 164).toInt(), 164);
    }

    if (recoverValue > 0.5) {
      recoverColor = Color.fromARGB(255, (-164 * recoverValue + 328).toInt() ,251, 164);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    getData(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.scale(
          scale: 2,
          child: CircularProgressIndicator(
            value: recoverValue,
            color: recoverColor,
            backgroundColor:
                Theme.of(context).colorScheme.surface.withOpacity(0.1),
            strokeWidth: MediaQuery.of(context).size.width * 0.005,
            strokeCap: StrokeCap.round,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        Text(
          '${(recoverValue*100).round()}%',
          style: TextStyle(
              color: recoverColor,
              fontSize: MediaQuery.of(context).size.width * 0.02),
        ),
      ],
    );
  }
}
