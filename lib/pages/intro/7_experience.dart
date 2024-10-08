import 'package:flexify/pages/intro/8_schedule.dart';
import 'package:flexify/pages/intro/widgets/IntroNavbarIcon.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class SevenExperience extends StatefulWidget {
  final bool isSettings;
  const SevenExperience({super.key, required this.isSettings});

  @override
  State<SevenExperience> createState() => _SevenExperienceState();
}

class _SevenExperienceState extends State<SevenExperience> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int selected = 0;

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
                                left: global.width(context) * 0.07,
                                right: global.width(context) * 0.15),
                            child: Text(
                              "Experience Level",
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
                                    builder: (context) => const EightSchedule(
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
                                boxShadow: [global.darkShadow(context)],
                              ),
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: global.height(context) * 0.01,
                ),
                Container(
                  alignment: Alignment.center,
                  height: global.height(context) * 0.07,
                  width: global.width(context) * 0.8,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius:
                          BorderRadius.circular(global.width(context) * 0.0375),
                      boxShadow: [global.darkShadow(context)]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'How experienced',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: global.height(context) * 0.01 +
                                global.width(context) * 0.02),
                      ),
                      Text(
                        'are you?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: global.height(context) * 0.01 +
                                global.width(context) * 0.02),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: global.height(context) * 0.55,
                  padding: EdgeInsets.only(top: global.height(context) * 0.05),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          selected = 1;
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: global.standardAnimationDuration,
                          padding: EdgeInsets.only(
                              left: global.width(context) * 0.04),
                          height: global.height(context) * 0.11,
                          width: global.width(context) * 0.8,
                          decoration: BoxDecoration(
                            color: selected == 1
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                                global.width(context) * 0.0375),
                            boxShadow: [global.darkShadow(context)],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: global.height(context) * 0.015,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Beginner',
                                    style: TextStyle(
                                        color: selected == 1
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize:
                                            global.height(context) * 0.02 +
                                                global.width(context) * 0.02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: global.height(context) * 0.005,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'You have been working out',
                                    style: TextStyle(
                                        color: selected == 1
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize:
                                            global.height(context) * 0.015 +
                                                global.width(context) * 0.001),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'for less than a year',
                                    style: TextStyle(
                                        color: selected == 1
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize:
                                            global.height(context) * 0.015 +
                                                global.width(context) * 0.001),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: global.height(context) * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          selected = 2;
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: global.standardAnimationDuration,
                          padding: EdgeInsets.only(
                              left: global.width(context) * 0.04),
                          height: global.height(context) * 0.11,
                          width: global.width(context) * 0.8,
                          decoration: BoxDecoration(
                            color: selected == 2
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                                global.width(context) * 0.0375),
                            boxShadow: [global.darkShadow(context)],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: global.height(context) * 0.015,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Intermediate',
                                    style: TextStyle(
                                        color: selected == 2
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize:
                                            global.height(context) * 0.02 +
                                                global.width(context) * 0.02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: global.height(context) * 0.005,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'You have been working out',
                                    style: TextStyle(
                                        color: selected == 2
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize:
                                            global.height(context) * 0.015 +
                                                global.width(context) * 0.001),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'for more than a year',
                                    style: TextStyle(
                                        color: selected == 2
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize:
                                            global.height(context) * 0.015 +
                                                global.width(context) * 0.001),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: global.height(context) * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          selected = 3;
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: global.standardAnimationDuration,
                          padding: EdgeInsets.only(
                              left: global.width(context) * 0.04),
                          height: global.height(context) * 0.11,
                          width: global.width(context) * 0.8,
                          decoration: BoxDecoration(
                            color: selected == 3
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                              global.width(context) * 0.0375,
                            ),
                            boxShadow: [global.darkShadow(context)],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: global.height(context) * 0.015,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Advanced',
                                    style: TextStyle(
                                        color: selected == 3
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize:
                                            global.height(context) * 0.02 +
                                                global.width(context) * 0.02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: global.height(context) * 0.005,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'You have been working out',
                                    style: TextStyle(
                                        color: selected == 3
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize:
                                            global.height(context) * 0.015 +
                                                global.width(context) * 0.001),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'for more than 2 years',
                                    style: TextStyle(
                                        color: selected == 3
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize:
                                            global.height(context) * 0.015 +
                                                global.width(context) * 0.001),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: global.height(context) * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          selected = 4;
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: global.standardAnimationDuration,
                          padding: EdgeInsets.only(
                              left: global.width(context) * 0.04),
                          height: global.height(context) * 0.11,
                          width: global.width(context) * 0.8,
                          decoration: BoxDecoration(
                              color: selected == 4
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(
                                global.width(context) * 0.0375,
                              ),
                              boxShadow: [global.darkShadow(context)]),
                          child: Column(
                            children: [
                              SizedBox(
                                height: global.height(context) * 0.015,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Pro',
                                    style: TextStyle(
                                      color: selected == 4
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: global.height(context) * 0.02 +
                                          global.width(context) * 0.02,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: global.height(context) * 0.005,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'You have been working out',
                                    style: TextStyle(
                                        color: selected == 4
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize:
                                            global.height(context) * 0.015 +
                                                global.width(context) * 0.001),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'for more than 5 years',
                                    style: TextStyle(
                                        color: selected == 4
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize:
                                            global.height(context) * 0.015 +
                                                global.width(context) * 0.001),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: global.height(context) * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    if (selected != 0 && widget.isSettings == false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EightSchedule(
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
                          : Theme.of(context).colorScheme.background,
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
                                  : Colors.white,
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
