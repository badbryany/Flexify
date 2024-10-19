import 'package:flexify/pages/dWorkout/workoutPlanPage/workoutPlanPage.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flexify/data/globalVariables.dart' as global;

class WorkoutPlan extends StatelessWidget {
  const WorkoutPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return BounceElement(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WorkoutPlanPage(),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(global.containerPadding),
        decoration: BoxDecoration(
          color: global.darkGrey,
          borderRadius: BorderRadius.circular(global.borderRadius),
          boxShadow: global.shadow(context),
        ),
        width: global.width(context) * global.containerWidthFactor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                global.gradient(
                  Text(
                    'Personal Plan',
                    style: TextStyle(
                      fontSize: global.width(context) * .0625,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerLeft,
                  width:
                      global.width(context) * global.containerWidthFactor * .7,
                  child: Text(
                    'Your personal recommended exercises of your regular plan',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            Icon(
              CupertinoIcons.arrow_right,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}
