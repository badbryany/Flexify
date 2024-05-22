import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class WorkoutStatsPage extends StatefulWidget {
  const WorkoutStatsPage({super.key});

  @override
  State<WorkoutStatsPage> createState() => _WorkoutStatsPageState();
}

class _WorkoutStatsPageState extends State<WorkoutStatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: global.width(context) * 0.075,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: global.width(context) * 0.037,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: global.width(context) * 0.06,
                  ),
                ),
                SizedBox(
                  width: global.width(context) * 0.11,
                ),
                Text(
                  "Statistics",
                  style: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                    fontSize: global.width(context) * 0.07,
                  ),
                ),
                SizedBox(
                  width: global.width(context) * 0.125,
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: Share button
                  },
                  child: Icon(
                    Icons.share_sharp,
                    size: global.width(context) * 0.05,
                  ),
                ),
                SizedBox(
                  width: global.width(context) * 0.05,
                ),
              ],
            ),
            SizedBox(
              height: global.height(context) * 0.04,
            ),
          ],
        ),
      ),
    );
  }
}
