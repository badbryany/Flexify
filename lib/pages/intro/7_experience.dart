import 'dart:ffi';

import 'package:flexify/pages/intro/8_schedule.dart';
import 'package:flexify/pages/intro/9_duration.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class SevenExperience extends StatefulWidget {
  const SevenExperience({super.key});

  @override
  State<SevenExperience> createState() => _SevenExperienceState();
}

class _SevenExperienceState extends State<SevenExperience> {
  @override
  void initState() {
    super.initState();
  }

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
                            builder: (context) => EightSchedule(),
                          ),
                        );
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
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
                      boxShadow: [global.lightShadow(context)]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'How experienced',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.01 +
                                    MediaQuery.of(context).size.width * 0.01),
                      ),
                      Text(
                        'are you?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.01 +
                                    MediaQuery.of(context).size.width * 0.01),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          selected = 1;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03),
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: selected == 1
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.0375),
                            border: Border.all(
                              color: Theme.of(context).focusColor,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Beginner',
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'You have been working out',
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'for less than a year',
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          selected = 2;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03),
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: selected == 2
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.0375),
                            border: Border.all(
                              color: Theme.of(context).focusColor,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Intermediate',
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'You have been working out',
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'for more than a year',
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          selected = 3;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03),
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: selected == 3
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.0375),
                            border: Border.all(
                              color: Theme.of(context).focusColor,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Advanced',
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'You have been working out',
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'for more than 2 years',
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          selected = 4;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03),
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: selected == 4
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.0375),
                            border: Border.all(
                              color: Theme.of(context).focusColor,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Pro',
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'You have been working out',
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'for more than 5 years',
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
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
                GestureDetector(
                  onTap: () {
                    if (selected != 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EightSchedule(),
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
                                  MediaQuery.of(context).size.height * 0.02),
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
