import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class SetsWidget extends StatefulWidget {
  const SetsWidget({super.key});

  @override
  State<SetsWidget> createState() => _SetsWidgetState();
}

class _SetsWidgetState extends State<SetsWidget> {
  String currentMonthString = global.monthsLong[DateTime.now().month - 1];
  int selectedDay = DateTime.now().day;
  int selectedDaySets = 0;
  List<SetsTile> days =
      getDaysInMonth(DateTime.now()).map((e) => SetsTile(date: e)).toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * global.containerWidthFactor,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: 3,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sets",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: MediaQuery.of(context).size.width * 0.08 +
                                MediaQuery.of(context).size.height * 0.01),
                      ),
                      Text(
                        currentMonthString,
                        style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: MediaQuery.of(context).size.width * 0.05 +
                                MediaQuery.of(context).size.height * 0.01),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.01),
                ),
                child: Column(
                  children: [
                    Text(
                      getCurrentDateString(days.elementAt(selectedDay).date),
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                      ),
                    ),
                    Text(
                      '${days[selectedDay].numberOfSets} Sets',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.015,
              ),
              Row(
                children: [
                  ...days
                      .sublist(0, 7)
                      .map(
                        (tile) => Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  selectedDay = tile.date.day - 1;
                                  setState(() {});
                                },
                                child: days[tile.date.day - 1]),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.015,
                            )
                          ],
                        ),
                      )
                      .toList(),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.015,
              ),
              Row(
                children: [
                  ...days
                      .sublist(7, 14)
                      .map(
                        (tile) => Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  selectedDay = tile.date.day - 1;
                                  setState(() {});
                                },
                                child: days[tile.date.day - 1]),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.015,
                            )
                          ],
                        ),
                      )
                      .toList(),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.015,
              ),
              Row(
                children: [
                  ...days
                      .sublist(14, 21)
                      .map(
                        (tile) => Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  selectedDay = tile.date.day - 1;
                                  setState(() {});
                                },
                                child: days[tile.date.day - 1]),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.015,
                            )
                          ],
                        ),
                      )
                      .toList(),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.015,
              ),
              Row(
                children: [
                  ...days
                      .sublist(21, 28)
                      .map(
                        (tile) => Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  selectedDay = tile.date.day - 1;
                                  setState(() {});
                                },
                                child: days[tile.date.day - 1]),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.015,
                            )
                          ],
                        ),
                      )
                      .toList(),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.015,
              ),
              days.length > 28
                  ? Row(
                      children: [
                        ...days
                            .sublist(28, days.length)
                            .map(
                              (tile) => Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        selectedDay = tile.date.day - 1;
                                        setState(() {});
                                      },
                                      child: days[tile.date.day - 1]),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.015,
                                  )
                                ],
                              ),
                            )
                            .toList(),
                      ],
                    )
                  : const Row(
                      children: [],
                    ),
            ],
          )
        ],
      ),
    );
  }
}

class SetsTile extends StatelessWidget {
  final DateTime date;

  SetsTile({super.key, required this.date});

  int numberOfSets = 0 + Random().nextInt(30 - 0 + 1);

  int getNumberOfSets() {
    return numberOfSets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.03,
      height: MediaQuery.of(context).size.height * 0.03,
      decoration: BoxDecoration(
        color: numberOfSets == 0
            ? Theme.of(context).colorScheme.surface.withOpacity(0.1)
            : Theme.of(context)
                .colorScheme
                .primary
                .withOpacity(0.4 + numberOfSets * 0.02),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

List<DateTime> getDaysInMonth(DateTime date) {
  List<DateTime> daysList = [];
  DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
  DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

  for (int i = 0; i < lastDayOfMonth.day; i++) {
    DateTime day = firstDayOfMonth.add(Duration(days: i));
    daysList.add(day);
  }

  return daysList;
}

String getCurrentDateString(DateTime date) {
  return '${date.day.toString()}${date.day > 3 ? global.cardinals[3] : global.cardinals[date.day - 1]} ${global.monthsLong[date.month - 1]}';
}
