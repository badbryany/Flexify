import 'dart:math';
import 'package:flexify/SignInSignUp/signIn.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class Photos extends StatefulWidget {
  const Photos({super.key});

  @override
  State<Photos> createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          height: global.height(context) * .4,
          width: global.width(context) * global.containerWidthFactor,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.onPrimary,
                ],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: global.shadow(context)),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              ClipPath(
                clipper: BezierClipper(),
                child: AnimatedContainer(
                  duration: global.standardAnimationDuration,
                  color: Theme.of(context).colorScheme.background,
                  height: global.height(context) * .3,
                  padding: EdgeInsets.only(bottom: global.height(context) * .2),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: global.width(context) * .8,
                    height: global.height(context) * .12,
                    padding: EdgeInsets.only(
                      top: global.height(context) * .03,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, idx) {
                        return Row(
                          children: [
                            ShadedSetsTile(
                              date: DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day - idx,
                              ),
                            ),
                            SizedBox(
                              width: global.width(context) * .02,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: global.height(context) * .14),
                  BounceElement(
                    onTap: () {},
                    child: SizedBox(
                      height: global.height(context) * .1,
                      width: global.height(context) * .1,
                      child: Container(
                        height: global.height(context) * .01,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.8),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black, width: 4),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ShadedSetsTile extends StatelessWidget {
  final DateTime date;
  final int numberOfSets = 0 + Random().nextInt(30 - 0 + 1);

  ShadedSetsTile({
    super.key,
    required this.date,
  });

  int getNumberOfSets() {
    return numberOfSets;
  }

  @override
  Widget build(BuildContext context) {
    return numberOfSets == 0
        ? BaseSetTile(date: date)
        : global.gradient(BaseSetTile(date: date));
  }
}

class BaseSetTile extends StatelessWidget {
  const BaseSetTile({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return BounceElement(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: global.height(context) * 0.09,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          textAlign: TextAlign.center,
          "${date.day}${global.getCardinal(date.day)}\n${global.months[date.month - 1]}",
          style: const TextStyle(color: Colors.white),
        ),
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
