import 'package:flexify/pages/intro/10_split.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class NineDuration extends StatefulWidget {
  const NineDuration({super.key});

  @override
  State<NineDuration> createState() => _NineDurationState();
}

class _NineDurationState extends State<NineDuration> {
  DateTime birthday = DateTime.now();

  late FixedExtentScrollController _dayController;
  int dayIdx = 0;
  late FixedExtentScrollController _monthController;
  int monthIdx = 0;
  late FixedExtentScrollController _yearController;
  int yearIdx = 99;

  int selected = 0;

  @override
  void initState() {
    super.initState();
    _dayController = FixedExtentScrollController(initialItem: dayIdx);
    _monthController = FixedExtentScrollController(initialItem: monthIdx);
    _yearController = FixedExtentScrollController(initialItem: yearIdx);
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  children: [
                    IconButton(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Theme.of(context).focusColor,
                      icon: const Icon(Icons.arrow_back_rounded),
                      iconSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TenSplit(),
                          ),
                        );
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(color: Theme.of(context).focusColor, fontSize: MediaQuery.of(context).size.width * 0.035),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02)
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        border: Border.all(
                            color: Theme.of(context).focusColor,
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(1000),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.0225,
                        width: MediaQuery.of(context).size.height * 0.0325,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.0375),
                    border: Border.all(
                      color: Theme.of(context).focusColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'How long do you',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.01 +
                                    MediaQuery.of(context).size.width * 0.02),
                      ),
                      Text(
                        'want to workout?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.01 +
                                    MediaQuery.of(context).size.width * 0.02),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.25,
                      bottom: MediaQuery.of(context).size.height * 0.3),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.01,
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.075,
                                child: ListWheelScrollView.useDelegate(
                                  controller: _dayController,
                                  onSelectedItemChanged: (index) {
                                    selected = 1;
                                    setState(() {});
                                  },
                                  itemExtent: 50,
                                  perspective: 0.005,
                                  diameterRatio: 3.5,
                                  physics: const FixedExtentScrollPhysics(),
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: 5,
                                    builder: (context, index) {
                                      return HourTile(hours: index);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  "h",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                                0.01 +
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.075,
                                child: ListWheelScrollView.useDelegate(
                                  controller: _dayController,
                                  onSelectedItemChanged: (index) {
                                    selected = 1;
                                    setState(() {});
                                  },
                                  itemExtent: 50,
                                  perspective: 0.005,
                                  diameterRatio: 3.5,
                                  physics: const FixedExtentScrollPhysics(),
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: 60,
                                    builder: (context, index) {
                                      return MinuteTile(minutes: index);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  "m",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                                0.01 +
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (selected != 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TenSplit(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      boxShadow: [global.darkShadow(context)],
                      color: selected != 0
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                              color: Theme.of(context).focusColor,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MinuteTile extends StatelessWidget {
  final int minutes;

  const MinuteTile({super.key, required this.minutes});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        minutes.toString(),
        style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: MediaQuery.of(context).size.height * 0.01 +
                MediaQuery.of(context).size.width * 0.02),
      ),
    );
  }
}

class HourTile extends StatelessWidget {
  final int hours;

  const HourTile({super.key, required this.hours});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        (hours + 1).toString(),
        style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: MediaQuery.of(context).size.height * 0.01 +
                MediaQuery.of(context).size.width * 0.02),
      ),
    );
  }
}
