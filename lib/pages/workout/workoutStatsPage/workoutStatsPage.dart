// ignore_for_file: camel_case_types
import 'package:flexify/pages/workout/workoutStatsPage/widgets/Sets.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class workoutStatsPage extends StatefulWidget {
  const workoutStatsPage({super.key});

  @override
  State<workoutStatsPage> createState() => _workoutStatsPageState();
}

class _workoutStatsPageState extends State<workoutStatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.075,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.037,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: MediaQuery.of(context).size.width * 0.06,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.11,
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
                  width: MediaQuery.of(context).size.width * 0.125,
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: Share button
                  },
                  child: Icon(
                    Icons.share_sharp,
                    size: MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SetsWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
