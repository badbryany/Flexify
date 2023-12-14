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
  Color recoverColor = Colors.red;

  getData(BuildContext context) {
    if (sets.isEmpty) {
      recoverValue = 1;
      loadString = 'let\'s go!';
      recoverColor = Theme.of(context).colorScheme.primary;
      return;
    }

    // CALC recoverValue
    recoverValue =
        (sets.last.date.difference(DateTime.now()).inHours).abs() / 72;

    if (recoverValue <= 0.6) {
      loadString = 'recovering';
      recoverColor = Theme.of(context).colorScheme.error;
    }

    if (recoverValue > 0.6) {
      loadString = 'nearly done';
      recoverColor = Theme.of(context).colorScheme.onPrimary;
    }

    if (recoverValue == 1) {
      loadString = 'done';
      recoverColor = Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    getData(context);
    return Container(
      margin: const EdgeInsets.all(20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: 2,
            child: CircularProgressIndicator(
              value: 1,
              color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
              strokeCap: StrokeCap.round,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          Transform.scale(
            scale: 2,
            child: CircularProgressIndicator(
              value: recoverValue,
              color: recoverColor,
              strokeCap: StrokeCap.round,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                loadString,
                style: TextStyle(
                  color: recoverColor,
                  fontStyle: FontStyle.italic,
                  fontSize: 10,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
