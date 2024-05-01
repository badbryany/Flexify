import 'package:flexify/pages/intro/9_duration.dart';
import 'package:flutter/material.dart';
import 'package:flexify/pages/intro/widgets/IntroNavbarIcon.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class EightSchedule extends StatefulWidget {
  final bool isSettings;
  const EightSchedule({super.key, required this.isSettings});

  @override
  State<EightSchedule> createState() => _EightScheduleState();
}

class _EightScheduleState extends State<EightSchedule> {
  int selected = 0;
  int daysPerWeekIdx = 1;
  bool daysPerWeek = true;
  List<bool> whichDays = [true, false, false, false, false, false, false];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
                                left: MediaQuery.of(context).size.width * 0.07,
                                right:
                                    MediaQuery.of(context).size.width * 0.12),
                            child: Text(
                              "Training Schedule",
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
                                    builder: (context) => const NineDuration(
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
                  height: MediaQuery.of(context).size.height * 0.01,
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
                    boxShadow: [global.darkShadow(context)],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'When do you want',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.007 +
                              MediaQuery.of(context).size.width * 0.02,
                        ),
                      ),
                      Text(
                        'to workout?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.007 +
                              MediaQuery.of(context).size.width * 0.02,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.045,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              daysPerWeek
                                  ? daysPerWeek = false
                                  : daysPerWeek = true;
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Stack(
                              alignment: daysPerWeek
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    borderRadius: BorderRadius.circular(1000),
                                    boxShadow: [global.darkShadow(context)],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width),
                                    ),
                                    child: Center(
                                      child: daysPerWeek
                                          ? Text(
                                              "Days per Week",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.015),
                                            )
                                          : Text(
                                              "Which days?",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.015),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.035,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(
                                        () {
                                          selected = 1;
                                          daysPerWeek
                                              ? daysPerWeekIdx = 1
                                              : whichDays[0] = !whichDays[0];
                                        },
                                      );
                                    },
                                    child: RightButton(
                                      daysPerWeekText: "Once per Week",
                                      whichDaysText: "Monday",
                                      index: 1,
                                      daysPerWeek: daysPerWeek,
                                      daysPerWeekIdx: daysPerWeekIdx,
                                      whichDays: whichDays,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected = 1;
                                        daysPerWeek
                                            ? daysPerWeekIdx = 2
                                            : whichDays[1] = !whichDays[1];
                                      });
                                    },
                                    child: RightButton(
                                      daysPerWeekText: "Twice per Week",
                                      whichDaysText: "Tuesday",
                                      index: 2,
                                      daysPerWeek: daysPerWeek,
                                      daysPerWeekIdx: daysPerWeekIdx,
                                      whichDays: whichDays,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected = 1;
                                        daysPerWeek
                                            ? daysPerWeekIdx = 3
                                            : whichDays[2] = !whichDays[2];
                                      });
                                    },
                                    child: RightButton(
                                      daysPerWeekText: "Three times per Week",
                                      whichDaysText: "Wednesday",
                                      index: 3,
                                      daysPerWeek: daysPerWeek,
                                      daysPerWeekIdx: daysPerWeekIdx,
                                      whichDays: whichDays,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected = 1;
                                        daysPerWeek
                                            ? daysPerWeekIdx = 4
                                            : whichDays[3] = !whichDays[3];
                                      });
                                    },
                                    child: RightButton(
                                      daysPerWeekText: "Four times per Week",
                                      whichDaysText: "Thursday",
                                      index: 4,
                                      daysPerWeek: daysPerWeek,
                                      daysPerWeekIdx: daysPerWeekIdx,
                                      whichDays: whichDays,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected = 1;
                                        daysPerWeek
                                            ? daysPerWeekIdx = 5
                                            : whichDays[4] = !whichDays[4];
                                      });
                                    },
                                    child: RightButton(
                                      daysPerWeekText: "Five times per Week",
                                      whichDaysText: "Friday",
                                      index: 5,
                                      daysPerWeek: daysPerWeek,
                                      daysPerWeekIdx: daysPerWeekIdx,
                                      whichDays: whichDays,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected = 1;
                                        daysPerWeek
                                            ? daysPerWeekIdx = 6
                                            : whichDays[5] = !whichDays[5];
                                      });
                                    },
                                    child: RightButton(
                                      daysPerWeekText: "Six times per Week",
                                      whichDaysText: "Saturday",
                                      index: 6,
                                      daysPerWeek: daysPerWeek,
                                      daysPerWeekIdx: daysPerWeekIdx,
                                      whichDays: whichDays,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected = 1;
                                        daysPerWeek
                                            ? daysPerWeekIdx = 7
                                            : whichDays[6] = !whichDays[6];
                                      });
                                    },
                                    child: RightButton(
                                      daysPerWeekText: "Seven times per Week",
                                      whichDaysText: "Sunday",
                                      index: 7,
                                      daysPerWeek: daysPerWeek,
                                      daysPerWeekIdx: daysPerWeekIdx,
                                      whichDays: whichDays,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                width: MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(
                                          () {
                                            selected = 1;
                                            daysPerWeek
                                                ? daysPerWeekIdx = 1
                                                : whichDays[0] = !whichDays[0];
                                          },
                                        );
                                      },
                                      child: LeftButton(
                                        daysPerWeekText: "1",
                                        whichDaysText: "Mon",
                                        index: 1,
                                        daysPerWeek: daysPerWeek,
                                        daysPerWeekIdx: daysPerWeekIdx,
                                        whichDays: whichDays,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selected = 1;
                                          daysPerWeek
                                              ? daysPerWeekIdx = 2
                                              : whichDays[1] = !whichDays[1];
                                        });
                                      },
                                      child: LeftButton(
                                        daysPerWeekText: "2",
                                        whichDaysText: "Tue",
                                        index: 2,
                                        daysPerWeek: daysPerWeek,
                                        daysPerWeekIdx: daysPerWeekIdx,
                                        whichDays: whichDays,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selected = 1;
                                          daysPerWeek
                                              ? daysPerWeekIdx = 3
                                              : whichDays[2] = !whichDays[2];
                                        });
                                      },
                                      child: LeftButton(
                                        daysPerWeekText: "3",
                                        whichDaysText: "Wed",
                                        index: 3,
                                        daysPerWeek: daysPerWeek,
                                        daysPerWeekIdx: daysPerWeekIdx,
                                        whichDays: whichDays,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selected = 1;
                                          daysPerWeek
                                              ? daysPerWeekIdx = 4
                                              : whichDays[3] = !whichDays[3];
                                        });
                                      },
                                      child: LeftButton(
                                        daysPerWeekText: "4",
                                        whichDaysText: "Thu",
                                        index: 4,
                                        daysPerWeek: daysPerWeek,
                                        daysPerWeekIdx: daysPerWeekIdx,
                                        whichDays: whichDays,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selected = 1;
                                          daysPerWeek
                                              ? daysPerWeekIdx = 5
                                              : whichDays[4] = !whichDays[4];
                                        });
                                      },
                                      child: LeftButton(
                                        daysPerWeekText: "5",
                                        whichDaysText: "Fri",
                                        index: 5,
                                        daysPerWeek: daysPerWeek,
                                        daysPerWeekIdx: daysPerWeekIdx,
                                        whichDays: whichDays,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selected = 1;
                                          daysPerWeek
                                              ? daysPerWeekIdx = 6
                                              : whichDays[5] = !whichDays[5];
                                        });
                                      },
                                      child: LeftButton(
                                        daysPerWeekText: "6",
                                        whichDaysText: "Sat",
                                        index: 6,
                                        daysPerWeek: daysPerWeek,
                                        daysPerWeekIdx: daysPerWeekIdx,
                                        whichDays: whichDays,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selected = 1;
                                          daysPerWeek
                                              ? daysPerWeekIdx = 7
                                              : whichDays[6] = !whichDays[6];
                                        });
                                      },
                                      child: LeftButton(
                                        daysPerWeekText: "7",
                                        whichDaysText: "Sun",
                                        index: 7,
                                        daysPerWeek: daysPerWeek,
                                        daysPerWeekIdx: daysPerWeekIdx,
                                        whichDays: whichDays,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    if (selected != 0 && widget.isSettings == false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NineDuration(
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

class LeftButton extends StatefulWidget {
  final String daysPerWeekText;
  final String whichDaysText;
  final int index;

  final bool daysPerWeek;
  final int daysPerWeekIdx;
  final List<bool> whichDays;

  const LeftButton({
    super.key,
    required this.daysPerWeekText,
    required this.whichDaysText,
    required this.index,
    required this.daysPerWeek,
    required this.daysPerWeekIdx,
    required this.whichDays,
  });

  @override
  State<LeftButton> createState() => _LeftButtonState();
}

class _LeftButtonState extends State<LeftButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * (0.4 / 8),
        ),
        AnimatedContainer(
          duration: global.standardAnimationDuration * .5,
          height: MediaQuery.of(context).size.height * ((0.4 / 8) * 3 / 4),
          width: MediaQuery.of(context).size.height * ((0.4 / 8) * 3 / 4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                  color: Theme.of(context).colorScheme.background, width: 1),
            ),
            color: widget.daysPerWeek
                ? (widget.daysPerWeekIdx == widget.index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surface)
                : (widget.whichDays[widget.index - 1]
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surface),
            borderRadius: BorderRadius.circular(1000),
          ),
          child: Text(
            widget.daysPerWeek ? widget.daysPerWeekText : widget.whichDaysText,
            style: TextStyle(
                color: widget.daysPerWeek
                    ? (widget.daysPerWeekIdx == widget.index
                        ? Colors.black
                        : Theme.of(context).focusColor)
                    : (widget.whichDays[widget.index - 1]
                        ? Colors.black
                        : Theme.of(context).focusColor),
                fontSize: widget.daysPerWeek
                    ? MediaQuery.of(context).size.height * 0.02
                    : MediaQuery.of(context).size.height * 0.013),
          ),
        ),
      ],
    );
  }
}

class RightButton extends StatefulWidget {
  final String daysPerWeekText;
  final String whichDaysText;
  final int index;

  final bool daysPerWeek;
  final int daysPerWeekIdx;
  final List<bool> whichDays;

  const RightButton({
    super.key,
    required this.daysPerWeekText,
    required this.whichDaysText,
    required this.index,
    required this.daysPerWeek,
    required this.daysPerWeekIdx,
    required this.whichDays,
  });

  @override
  State<RightButton> createState() => _RightButtonState();
}

class _RightButtonState extends State<RightButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: global.standardAnimationDuration * .5,
          height: MediaQuery.of(context).size.height * 0.4 / 7,
          width: MediaQuery.of(context).size.width * 0.8,
          alignment: Alignment.center,
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          decoration: BoxDecoration(
            border: widget.index != 7
                ? Border(
                    bottom: BorderSide(
                        color: Theme.of(context).colorScheme.background,
                        width: 5),
                  )
                : const Border(),
            color: widget.daysPerWeek
                ? (widget.daysPerWeekIdx == widget.index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background)
                : (widget.whichDays[widget.index - 1]
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background),
          ),
          child: Text(
            widget.daysPerWeek ? widget.daysPerWeekText : widget.whichDaysText,
            style: TextStyle(
                color: widget.daysPerWeek
                    ? (widget.daysPerWeekIdx == widget.index
                        ? Colors.black
                        : Theme.of(context).colorScheme.background)
                    : (widget.whichDays[widget.index - 1]
                        ? Colors.black
                        : Theme.of(context).colorScheme.background),
                fontSize: MediaQuery.of(context).size.height * 0.015),
          ),
        ),
      ],
    );
  }
}
