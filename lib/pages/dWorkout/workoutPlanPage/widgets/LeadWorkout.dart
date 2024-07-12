import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class LeadWorkout extends StatefulWidget {
  const LeadWorkout({super.key});

  @override
  State<LeadWorkout> createState() => _LeadWorkoutState();
}

class _LeadWorkoutState extends State<LeadWorkout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(global.borderRadius),
        color: Theme.of(context).colorScheme.surface,
      ),
      width: global.containerWidth(context),
      height: global.height(context) * .4,
      margin: EdgeInsets.symmetric(
        vertical: 6,
        horizontal:
            (global.width(context) * (1 - global.containerWidthFactor)) / 2,
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(global.width(context) * .1),
            alignment: Alignment.topLeft,
            child: Text(
              'next set:',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
                fontSize: global.width(context) * .05,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Reverse Buttefly',
                  style: TextStyle(
                    fontSize: global.width(context) * .075,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    global.gradient(Text(
                      '54kg',
                      style: TextStyle(
                        fontSize: global.width(context) * .07,
                      ),
                    )),
                    Text(
                      ' x 12',
                      style: TextStyle(
                        fontSize: global.width(context) * .07,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          global.gradient(Container(
            margin: EdgeInsets.all(global.width(context) * .1),
            alignment: Alignment.bottomRight,
            child: const Text('done'),
          )),
          Container(
            margin: EdgeInsets.all(global.width(context) * .1),
            alignment: Alignment.bottomLeft,
            child: const Text('timer'),
          ),
        ],
      ),
    );
  }
}
