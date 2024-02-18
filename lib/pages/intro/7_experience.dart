import 'dart:ffi';

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
                  height: MediaQuery.of(context).size.height * 0.087,
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
                        width: MediaQuery.of(context).size.height * 0.0725,
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
                  height: MediaQuery.of(context).size.height * 0.055,
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
                    boxShadow: [global.lightShadow(context)]
                  ),
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
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.03),
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
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
                              height: MediaQuery.of(context).size.height * 0.01,
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
                              height: MediaQuery.of(context).size.height * 0.01,
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.03),
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
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
                              height: MediaQuery.of(context).size.height * 0.01,
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
                              height: MediaQuery.of(context).size.height * 0.01,
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.03),
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
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
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Advanced',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).focusColor,
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
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Row(
                              children: [
                                Text(
                                  'You have been working out',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).focusColor,
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
                                      color:
                                          Theme.of(context).focusColor,
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.03),
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
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
                              height: MediaQuery.of(context).size.height * 0.01,
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
                              height: MediaQuery.of(context).size.height * 0.01,
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
                    
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    boxShadow: [global.darkShadow(context)],
                    color: Theme.of(context).primaryColor,
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
