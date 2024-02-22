import 'dart:ffi';

import 'package:flexify/pages/intro/11_targetMuscles.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class TenSplit extends StatefulWidget {
  const TenSplit({super.key});

  @override
  State<TenSplit> createState() => _TenSplitState();
}

class _TenSplitState extends State<TenSplit> {
  int selected = 0;
  int selectedSplit = 1;

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
                            builder: (context) => ElevenTargetMuscles(),
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
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Choose your',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.01 +
                                    MediaQuery.of(context).size.width * 0.01),
                      ),
                      Text(
                        'training split',
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
                          selectedSplit = 1;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03),
                          height: MediaQuery.of(context).size.height * 0.105,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: selectedSplit == 1
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
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
                              Padding(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.025),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'AI Generated',
                                      style: TextStyle(
                                          color: selectedSplit == 1
                                              ? Theme.of(context).focusColor
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0075 +
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.height *
                                              0.009),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.025),
                                          border: Border.all(
                                            color: selectedSplit == 1
                                                ? Theme.of(context).focusColor
                                                : Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                            width: 2,
                                          ),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background),
                                      child: Text(
                                        "Recommended",
                                        style: TextStyle(
                                            color: selectedSplit == 1
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                            fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01 +
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.001),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Optimized based on your',
                                    style: TextStyle(
                                        color: selectedSplit == 1
                                            ? Theme.of(context).focusColor
                                            : Theme.of(context)
                                                .colorScheme
                                                .shadow,
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
                                    'personal fitness journey',
                                    style: TextStyle(
                                        color: selectedSplit == 1
                                            ? Theme.of(context).focusColor
                                            : Theme.of(context)
                                                .colorScheme
                                                .shadow,
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
                          selected = 1;
                          selectedSplit = 2;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03),
                          height: MediaQuery.of(context).size.height * 0.105,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: selectedSplit == 2
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
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
                                    'Push/Pull/Legs',
                                    style: TextStyle(
                                        color: selectedSplit == 2
                                            ? Theme.of(context).focusColor
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
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
                                    MediaQuery.of(context).size.height * 0.005,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Well suited for beginners',
                                    style: TextStyle(
                                        color: selectedSplit == 2
                                            ? Theme.of(context).focusColor
                                            : Theme.of(context)
                                                .colorScheme
                                                .shadow,
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
                                    'and intermediate trainees',
                                    style: TextStyle(
                                        color: selectedSplit == 2
                                            ? Theme.of(context).focusColor
                                            : Theme.of(context)
                                                .colorScheme
                                                .shadow,
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
                          selected = 1;
                          selectedSplit = 3;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03),
                          height: MediaQuery.of(context).size.height * 0.105,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: selectedSplit == 3
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
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
                                    'Upper Lower',
                                    style: TextStyle(
                                        color: selectedSplit == 3
                                            ? Theme.of(context).focusColor
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
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
                                    'Separate training days into upper',
                                    style: TextStyle(
                                        color: selectedSplit == 3
                                            ? Theme.of(context).focusColor
                                            : Theme.of(context)
                                                .colorScheme
                                                .shadow,
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
                                    'or lower body workouts',
                                    style: TextStyle(
                                        color: selectedSplit == 3
                                            ? Theme.of(context).focusColor
                                            : Theme.of(context)
                                                .colorScheme
                                                .shadow,
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
                          selected = 1;
                          selectedSplit = 4;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03),
                          height: MediaQuery.of(context).size.height * 0.105,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: selectedSplit == 4
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
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
                                    'Full Body',
                                    style: TextStyle(
                                        color: selectedSplit == 4
                                            ? Theme.of(context).focusColor
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
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
                                    'No restrictions. Well suited',
                                    style: TextStyle(
                                        color: selectedSplit == 4
                                            ? Theme.of(context).focusColor
                                            : Theme.of(context)
                                                .colorScheme
                                                .shadow,
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
                                    'for more experienced trainees',
                                    style: TextStyle(
                                        color: selectedSplit == 4
                                            ? Theme.of(context).focusColor
                                            : Theme.of(context)
                                                .colorScheme
                                                .shadow,
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
                        height: MediaQuery.of(context).size.height * 0.075,
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
                          builder: (context) => ElevenTargetMuscles(),
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
