import 'dart:ffi';

import 'package:flexify/pages/intro/6_birthday.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class FiveBodyFat extends StatefulWidget {
  const FiveBodyFat({super.key});

  @override
  State<FiveBodyFat> createState() => _FiveBodyFatState();
}

class _FiveBodyFatState extends State<FiveBodyFat> {
  double selectedBodyFatPercentage = 20;
  
  int selected = 0;

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
                            builder: (context) => SixBirthday(),
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
                        MediaQuery.of(context).size.width * 0.0525),
                    border: Border.all(
                      color: Theme.of(context).focusColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Estimate your current',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.005 +
                              MediaQuery.of(context).size.width * 0.01,
                        ),
                      ),
                      Text(
                        'body fat percentage',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.005 +
                              MediaQuery.of(context).size.width * 0.01,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                      Container(
                        clipBehavior: Clip.hardEdge,
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.2),
                          border: Border.all(
                            width: 1.2,
                            color: Theme.of(context).focusColor,
                          ),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.0375),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      MediaQuery.of(context).size.width *
                                          0.0375),
                                ),
                                color: Theme.of(context).colorScheme.background,
                              ),
                              child: Text(
                                '${selectedBodyFatPercentage.toStringAsFixed(0)}%',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.01),
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.0125),
                            SliderTheme(
                              data: SliderThemeData(
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius:
                                        MediaQuery.of(context).size.height *
                                            0.0125),
                                thumbColor:
                                    Theme.of(context).colorScheme.primary,
                                trackHeight:
                                    MediaQuery.of(context).size.height * 0.01,
                                activeTrackColor: Colors.transparent,
                                inactiveTrackColor: Colors.transparent,
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.0075,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                  Slider(
                                    min: 5,
                                    max: 50,
                                    value: selectedBodyFatPercentage,
                                    onChanged: (double value) {

                                      setState(
                                        () {
                                          selected = 1;
                                          selectedBodyFatPercentage =
                                              value.clamp(5, 50);
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                          builder: (context) => SixBirthday(),
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
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .surface,
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
