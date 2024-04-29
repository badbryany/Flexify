import 'package:flexify/pages/intro/10_split.dart';
import 'package:flexify/pages/intro/widgets/IntroNavbarIcon.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class NineDuration extends StatefulWidget {
  final bool isSettings;
  const NineDuration({super.key, required this.isSettings});

  @override
  State<NineDuration> createState() => _NineDurationState();
}

class _NineDurationState extends State<NineDuration> {
  DateTime birthday = DateTime.now();

  late FixedExtentScrollController _hourController;
  int hourIdx = 0;
  late FixedExtentScrollController _minuteController;
  int minuteIdx = 0;

  int selected = 0;

  @override
  void initState() {
    super.initState();
    _hourController = FixedExtentScrollController(initialItem: hourIdx);
    _minuteController = FixedExtentScrollController(initialItem: minuteIdx);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
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
                    const IntroNavBarIcon(),
                    widget.isSettings
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.08,
                                right:
                                    MediaQuery.of(context).size.width * 0.13),
                            child: Text(
                              "Training Duration",
                              style: TextStyle(
                                  color: Theme.of(context).focusColor,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06),
                            ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                    widget.isSettings
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: () {
                              if (widget.isSettings == false) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TenSplit(
                                      isSettings: false,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                  color: Theme.of(context).focusColor,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.035),
                            ),
                          ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02)
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                widget.isSettings
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      )
                    : Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width * 0.045,
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
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.005),
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.035,
                              width: MediaQuery.of(context).size.width * 0.035,
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
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.25,
                      bottom: MediaQuery.of(context).size.height * 0.3),
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.2),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .04,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).focusColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.2,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.075,
                              child: ListWheelScrollView.useDelegate(
                                controller: _hourController,
                                onSelectedItemChanged: (index) {
                                  selected = 1;
                                  setState(() {});
                                },
                                itemExtent: 50,
                                perspective: 0.005,
                                diameterRatio: 3.5,
                                physics: const FixedExtentScrollPhysics(),
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 7,
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
                                  fontSize: MediaQuery.of(context).size.height *
                                          0.01 +
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.075,
                              child: ListWheelScrollView.useDelegate(
                                controller: _minuteController,
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
                                  fontSize: MediaQuery.of(context).size.height *
                                          0.01 +
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (selected != 0 && widget.isSettings == false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TenSplit(
                            isSettings: false,
                          ),
                        ),
                      );
                    } else {
                      Navigator.pop(context);
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
                          widget.isSettings ? "Enter" : 'Next',
                          style: TextStyle(
                              color: selected != 0
                                  ? Colors.black
                                  : Theme.of(context).focusColor,
                              fontSize: global.height(context) * 0.025),
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
        hours.toString(),
        style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: MediaQuery.of(context).size.height * 0.01 +
                MediaQuery.of(context).size.width * 0.02),
      ),
    );
  }
}
