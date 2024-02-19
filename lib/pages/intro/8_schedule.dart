import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class EightSchedule extends StatefulWidget {
  const EightSchedule({super.key});

  @override
  State<EightSchedule> createState() => _EightScheduleState();
}

class _EightScheduleState extends State<EightSchedule> {
  bool daysPerWeek = true;
  int daysPerWeekIdx = 1;
  List<bool> whichDays = [false, false, false, false, false, false, false];

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
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.0225,
                        width: MediaQuery.of(context).size.height * 0.08125,
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
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'When do you want',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.007 +
                              MediaQuery.of(context).size.width * 0.01,
                        ),
                      ),
                      Text(
                        'to workout?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.007 +
                              MediaQuery.of(context).size.width * 0.01,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
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
                                    border: Border.all(
                                        color: Theme.of(context).focusColor,
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(1000),
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
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.0085),
                                            )
                                          : Text(
                                              "Which days?",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.009),
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
                      daysPerWeek
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.073),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                daysPerWeekIdx = 1;
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4 /
                                                    7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.05),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: daysPerWeekIdx == 1
                                                        ? Theme.of(context)
                                                            .focusColor
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .background,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  color: daysPerWeekIdx == 1
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                ),
                                                child: Text(
                                                  "Once per Week",
                                                  style: TextStyle(
                                                      color: daysPerWeekIdx == 1
                                                          ? Theme.of(context)
                                                              .focusColor
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .background,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                daysPerWeekIdx = 2;
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4 /
                                                    7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.05),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: daysPerWeekIdx == 2
                                                        ? Theme.of(context)
                                                            .focusColor
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .background,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  color: daysPerWeekIdx == 2
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                ),
                                                child: Text(
                                                  "Twice per Week",
                                                  style: TextStyle(
                                                      color: daysPerWeekIdx == 2
                                                          ? Theme.of(context)
                                                              .focusColor
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .background,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                daysPerWeekIdx = 3;
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4 /
                                                    7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.05),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: daysPerWeekIdx == 3
                                                        ? Theme.of(context)
                                                            .focusColor
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .background,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  color: daysPerWeekIdx == 3
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                ),
                                                child: Text(
                                                  "Three times per Week",
                                                  style: TextStyle(
                                                      color: daysPerWeekIdx == 3
                                                          ? Theme.of(context)
                                                              .focusColor
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .background,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                daysPerWeekIdx = 4;
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4 /
                                                    7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.05),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: daysPerWeekIdx == 4
                                                        ? Theme.of(context)
                                                            .focusColor
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .background,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  color: daysPerWeekIdx == 4
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                ),
                                                child: Text(
                                                  "Four times per Week",
                                                  style: TextStyle(
                                                      color: daysPerWeekIdx == 4
                                                          ? Theme.of(context)
                                                              .focusColor
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .background,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                daysPerWeekIdx = 5;
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4 /
                                                    7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.05),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: daysPerWeekIdx == 5
                                                        ? Theme.of(context)
                                                            .focusColor
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .background,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  color: daysPerWeekIdx == 5
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                ),
                                                child: Text(
                                                  "Five times per Week",
                                                  style: TextStyle(
                                                      color: daysPerWeekIdx == 5
                                                          ? Theme.of(context)
                                                              .focusColor
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .background,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                daysPerWeekIdx = 6;
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4 /
                                                    7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.05),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: daysPerWeekIdx == 6
                                                        ? Theme.of(context)
                                                            .focusColor
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .background,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  color: daysPerWeekIdx == 6
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                ),
                                                child: Text(
                                                  "Six times per Week",
                                                  style: TextStyle(
                                                      color: daysPerWeekIdx == 6
                                                          ? Theme.of(context)
                                                              .focusColor
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .background,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                daysPerWeekIdx = 7;
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4 /
                                                    7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.05),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: daysPerWeekIdx == 7
                                                        ? Theme.of(context)
                                                            .focusColor
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .background,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  color: daysPerWeekIdx == 7
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                ),
                                                child: Text(
                                                  "Seven times per Week",
                                                  style: TextStyle(
                                                      color: daysPerWeekIdx == 7
                                                          ? Theme.of(context)
                                                              .focusColor
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .background,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width *
                                              0.2,
                                        ),
                                        border: Border.all(
                                          color: Theme.of(context).focusColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  daysPerWeekIdx = 1;
                                                },
                                              );
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (0.4 / 8),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: daysPerWeekIdx == 1
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                  ),
                                                  child: Text(
                                                    "1",
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  daysPerWeekIdx = 2;
                                                },
                                              );
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (0.4 / 8),
                                                  decoration:
                                                      const BoxDecoration(),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: daysPerWeekIdx == 2
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                  ),
                                                  child: Text(
                                                    "2",
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  daysPerWeekIdx = 3;
                                                },
                                              );
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (0.4 / 8),
                                                  decoration:
                                                      const BoxDecoration(),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: daysPerWeekIdx == 3
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                  ),
                                                  child: Text(
                                                    "3",
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  daysPerWeekIdx = 4;
                                                },
                                              );
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (0.4 / 8),
                                                  decoration:
                                                      const BoxDecoration(),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: daysPerWeekIdx == 4
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                  ),
                                                  child: Text(
                                                    "4",
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  daysPerWeekIdx = 5;
                                                },
                                              );
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (0.4 / 8),
                                                  decoration:
                                                      const BoxDecoration(),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: daysPerWeekIdx == 5
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                  ),
                                                  child: Text(
                                                    "5",
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  daysPerWeekIdx = 6;
                                                },
                                              );
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (0.4 / 8),
                                                  decoration:
                                                      const BoxDecoration(),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: daysPerWeekIdx == 6
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                  ),
                                                  child: Text(
                                                    "6",
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  daysPerWeekIdx = 7;
                                                },
                                              );
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (0.4 / 8),
                                                  decoration:
                                                      const BoxDecoration(),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: daysPerWeekIdx == 7
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                  ),
                                                  child: Text(
                                                    "7",
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
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
                                  ],
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.073),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                whichDays[0]
                                                    ? whichDays[0] = false
                                                    : whichDays[0] = true;
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4 /
                                                    7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: whichDays[0]
                                                        ? Theme.of(context)
                                                            .focusColor
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .background,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  color: whichDays[0]
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                ),
                                                child: Text(
                                                  "Monday",
                                                  style: TextStyle(
                                                      color: whichDays[0]
                                                          ? Theme.of(context)
                                                              .focusColor
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .background,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                whichDays[1]
                                                    ? whichDays[1] = false
                                                    : whichDays[1] = true;
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4 /
                                                    7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: whichDays[1]
                                                        ? Theme.of(context)
                                                            .focusColor
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .background,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  color: whichDays[1]
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                ),
                                                child: Text(
                                                  "Tuesday",
                                                  style: TextStyle(
                                                      color: whichDays[1]
                                                          ? Theme.of(context)
                                                              .focusColor
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .background,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                whichDays[2]
                                                    ? whichDays[2] = false
                                                    : whichDays[2] = true;
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4 /
                                                    7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: whichDays[2]
                                                        ? Theme.of(context)
                                                            .focusColor
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .background,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  color: whichDays[2]
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                ),
                                                child: Text(
                                                  "Wednesday",
                                                  style: TextStyle(
                                                      color: whichDays[2]
                                                          ? Theme.of(context)
                                                              .focusColor
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .background,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                whichDays[3]
                                                    ? whichDays[3] = false
                                                    : whichDays[3] = true;
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4 /
                                                    7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: whichDays[3]
                                                        ? Theme.of(context)
                                                            .focusColor
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .background,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  color: whichDays[3]
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                ),
                                                child: Text(
                                                  "Thursday",
                                                  style: TextStyle(
                                                      color: whichDays[3]
                                                          ? Theme.of(context)
                                                              .focusColor
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .background,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                whichDays[4]
                                                    ? whichDays[4] = false
                                                    : whichDays[4] = true;
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4 /
                                                    7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: whichDays[4]
                                                        ? Theme.of(context)
                                                            .focusColor
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .background,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  color: whichDays[4]
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                ),
                                                child: Text(
                                                  "Friday",
                                                  style: TextStyle(
                                                      color: whichDays[4]
                                                          ? Theme.of(context)
                                                              .focusColor
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .background,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                whichDays[5]
                                                    ? whichDays[5] = false
                                                    : whichDays[5] = true;
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4 /
                                                    7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: whichDays[5]
                                                        ? Theme.of(context)
                                                            .focusColor
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .background,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  color: whichDays[5]
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                ),
                                                child: Text(
                                                  "Saturday",
                                                  style: TextStyle(
                                                      color: whichDays[5]
                                                          ? Theme.of(context)
                                                              .focusColor
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .background,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                whichDays[6]
                                                    ? whichDays[6] = false
                                                    : whichDays[6] = true;
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4 /
                                                    7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: whichDays[6]
                                                        ? Theme.of(context)
                                                            .focusColor
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .background,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  color: whichDays[6]
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                ),
                                                child: Text(
                                                  "Sunday",
                                                  style: TextStyle(
                                                      color: whichDays[6]
                                                          ? Theme.of(context)
                                                              .focusColor
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .background,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width *
                                              0.2,
                                        ),
                                        border: Border.all(
                                          color: Theme.of(context).focusColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  whichDays[0]
                                                      ? whichDays[0] = false
                                                      : whichDays[0] = true;
                                                },
                                              );
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (0.4 / 8),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: whichDays[0]
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                  ),
                                                  child: Text(
                                                    "Mon",
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  whichDays[1]
                                                      ? whichDays[1] = false
                                                      : whichDays[1] = true;
                                                },
                                              );
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (0.4 / 8),
                                                  decoration:
                                                      const BoxDecoration(),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: whichDays[1]
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                  ),
                                                  child: Text(
                                                    "Tue",
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  whichDays[2]
                                                      ? whichDays[2] = false
                                                      : whichDays[2] = true;
                                                },
                                              );
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (0.4 / 8),
                                                  decoration:
                                                      const BoxDecoration(),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: whichDays[2]
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                  ),
                                                  child: Text(
                                                    "Wed",
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  whichDays[3]
                                                      ? whichDays[3] = false
                                                      : whichDays[3] = true;
                                                },
                                              );
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (0.4 / 8),
                                                  decoration:
                                                      const BoxDecoration(),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: whichDays[3]
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                  ),
                                                  child: Text(
                                                    "Thu",
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  whichDays[4]
                                                      ? whichDays[4] = false
                                                      : whichDays[4] = true;
                                                },
                                              );
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (0.4 / 8),
                                                  decoration:
                                                      const BoxDecoration(),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: whichDays[4]
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                  ),
                                                  child: Text(
                                                    "Fri",
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  whichDays[5]
                                                      ? whichDays[5] = false
                                                      : whichDays[5] = true;
                                                },
                                              );
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (0.4 / 8),
                                                  decoration:
                                                      const BoxDecoration(),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: whichDays[5]
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                  ),
                                                  child: Text(
                                                    "Sat",
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  whichDays[6]
                                                      ? whichDays[6] = false
                                                      : whichDays[6] = true;
                                                },
                                              );
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (0.4 / 8),
                                                  decoration:
                                                      const BoxDecoration(),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      ((0.4 / 8) * 3 / 4),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: whichDays[6]
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                  ),
                                                  child: Text(
                                                    "Sun",
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01,
                                                    ),
                                                  ),
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
