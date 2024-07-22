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
                  height: global.height(context) * 0.05,
                ),
                Row(
                  children: [
                    const IntroNavBarIcon(),
                    widget.isSettings
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: global.width(context) * 0.08,
                                right: global.width(context) * 0.13),
                            child: Text(
                              "Training Duration",
                              style: TextStyle(
                                  color: Theme.of(context).focusColor,
                                  fontSize: global.width(context) * 0.06),
                            ),
                          )
                        : SizedBox(
                            width: global.width(context) * 0.7,
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
                                  fontSize: global.width(context) * 0.035),
                            ),
                          ),
                    SizedBox(width: global.width(context) * 0.02)
                  ],
                ),
                SizedBox(
                  height: global.height(context) * 0.03,
                ),
                widget.isSettings
                    ? SizedBox(
                        height: global.height(context) * 0.01,
                      )
                    : Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            height: global.width(context) * 0.045,
                            width: global.width(context) * 0.8,
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
                            padding:
                                EdgeInsets.all(global.width(context) * 0.005),
                            child: Container(
                              height: global.width(context) * 0.035,
                              width: global.width(context) * 0.035,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(
                                    global.width(context)),
                              ),
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: global.height(context) * 0.03,
                ),
                Container(
                  alignment: Alignment.center,
                  height: global.height(context) * 0.07,
                  width: global.width(context) * 0.8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius:
                        BorderRadius.circular(global.width(context) * 0.0375),
                    boxShadow: [global.darkShadow(context)],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'How long do you',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: global.height(context) * 0.01 +
                                global.width(context) * 0.02),
                      ),
                      Text(
                        'want to workout?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: global.height(context) * 0.01 +
                                global.width(context) * 0.02),
                      ),
                    ],
                  ),
                ),
                Container(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  height: global.height(context) * 0.55,
                  width: global.width(context) * 0.8,
                  padding: EdgeInsets.only(
                    top: global.height(context) * 0.2,
                    bottom: global.height(context) * 0.2,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: global.width(context) * global.containerWidthFactor,
                    height: global.height(context) * 0.56,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(global.width(context) * 0.2),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: global.height(context) * .04,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).focusColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              global.width(context) * 0.2,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: global.width(context) * 0.2,
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
                            Text(
                              "h",
                              style: TextStyle(
                                  color: Theme.of(context).focusColor,
                                  fontSize: global.height(context) * 0.005 +
                                      global.width(context) * 0.035),
                            ),
                            SizedBox(
                              width: global.width(context) * .05,
                            ),
                            SizedBox(
                              width: global.width(context) * 0.2,
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
                            Text(
                              "m",
                              style: TextStyle(
                                color: Theme.of(context).focusColor,
                                fontSize: global.height(context) * 0.005 +
                                    global.width(context) * 0.035,
                              ),
                            ),
                            SizedBox(
                              width: global.width(context) * .05,
                            )
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
                    height: global.height(context) * 0.05,
                    width: global.width(context) * 0.8,
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
            fontSize:
                global.height(context) * 0.01 + global.width(context) * 0.035),
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
            fontSize:
                global.height(context) * 0.01 + global.width(context) * 0.035),
      ),
    );
  }
}
