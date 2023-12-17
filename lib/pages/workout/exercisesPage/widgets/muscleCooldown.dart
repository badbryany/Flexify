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
  IconData recoverIcon = Icons.ac_unit;

  getData(BuildContext context) {
    if (sets.isEmpty) {
      recoverValue = 1;
      recoverIcon = Icons.check;
      recoverColor = Theme.of(context).colorScheme.primary;
      return;
    }

    recoverValue =
        (sets.last.date.difference(DateTime.now()).inHours).abs() / 72;

    if (recoverValue <= 0.6) {
      recoverIcon = Icons.close;
      recoverColor = Theme.of(context).colorScheme.error;
    }

    if (recoverValue > 0.6) {
      recoverIcon = Icons.close;
      recoverColor = Theme.of(context).colorScheme.onPrimary;
    }

    if (recoverValue == 1) {
      recoverIcon = Icons.check;
      recoverColor = Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    getData(context);
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: 2,
            child: CircularProgressIndicator(
              value: recoverValue,
              color: recoverColor,
              backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.1),
              strokeWidth: MediaQuery.of(context).size.width * 0.005,
              strokeCap: StrokeCap.round,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          Icon(
            recoverIcon,
            size: MediaQuery.of(context).size.width * 0.05,
            color: recoverColor,
          ),
        ],
      ),
    );
  }
}
