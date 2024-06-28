import 'package:flexify/widgets/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class HIITTimer extends StatefulWidget {
  const HIITTimer({super.key});

  @override
  State<HIITTimer> createState() => _HIITTimerState();
}

class _HIITTimerState extends State<HIITTimer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Navbar(
            title: 'HIIT Timer',
            titleSize: global.width(context) * .075,
          ),
        ],
      ),
    );
  }
}
