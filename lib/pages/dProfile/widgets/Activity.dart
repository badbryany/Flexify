import 'dart:math';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/widgets/ModalBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: global.width(context) * .05,
            vertical: global.height(context) * .03,
          ),
          height: global.height(context) * .4,
          width: global.width(context) * global.containerWidthFactor,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [global.darkShadow(context)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActivityButton(
                icon: CupertinoIcons.flame,
                text: "Streak",
                textSize: global.width(context) * .05,
                data: "7",
                dataSize: global.width(context) * .05,
                description:
                    "This widget shows your current streak. The streak resets every time you miss two days in a row.\n\n\"Know thyself, know thy enemy.\"\n\n- Sun Tzu",
                descriptionSize: global.width(context) * .05,
              ),
              SizedBox(
                height: global.height(context) * .02,
              ),
              ActivityButton(
                icon: Icons.fitness_center_rounded,
                text: "Total Sets",
                textSize: global.width(context) * .05,
                data: "400",
                dataSize: global.width(context) * .05,
                description:
                    "This widget shows your total number of workouts, add more to increase this number.\n\n\"Climb the mountain so you can see the world, not so the world can see you.\"\n\n- Khabib Nurmagomedov",
                descriptionSize: global.width(context) * .045,
              ),
              SizedBox(
                height: global.height(context) * .02,
              ),
              ActivityButton(
                icon: Icons.timer,
                text: "Total Workouts",
                textSize: global.width(context) * .05,
                data: "20",
                dataSize: global.width(context) * .05,
                description:
                    "This widget shows your total number of workouts, add more to increase this number. \n\n \"Who's gonna carry the boats?\"\n\n- David Goggins",
                descriptionSize: global.width(context) * .05,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ActivityButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final double textSize;
  final String data;
  final double dataSize;
  final String description;
  final double descriptionSize;

  const ActivityButton({
    super.key,
    required this.icon,
    required this.text,
    required this.textSize,
    required this.data,
    required this.dataSize,
    required this.description,
    required this.descriptionSize,
  });

  @override
  Widget build(BuildContext context) {
    return BounceElement(
      child: GestureDetector(
        onTap: () {
          showCustomModalBottomSheet(
            context,
            ModalBottomSheet(
              onPop: () => Navigator.pop(context),
              title: text,
              titleSize: global.width(context) * .08,
              height: global.height(context) * .6,
              submitButtonText: "Close",
              content: Container(
                alignment: Alignment.center,
                height: global.height(context) * .21,
                width: global.width(context) * .8,
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: descriptionSize, color: Colors.white),
                ),
              ),
            ),
          );
        },
        child: Container(
          height: global.height(context) * .1,
          padding: EdgeInsets.only(
            right: global.width(context) * .03,
            left: global.width(context) * .04,
            top: global.width(context) * .03,
            bottom: global.width(context) * .03,
          ),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 26, 26, 29),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              global.gradient(
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      icon,
                      color: Theme.of(context).colorScheme.primary,
                      size: global.width(context) * .1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: global.width(context) * .05,
              ),
              Container(
                width: global.width(context) * .4,
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: textSize,
                  ),
                ),
              ),
              SizedBox(
                width: global.width(context) * .05,
              ),
              Container(
                alignment: Alignment.center,
                height: global.width(context) * .15,
                width: global.width(context) * .15,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: global.gradient(
                  Text(
                    data,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: dataSize,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SetsTile extends StatelessWidget {
  final DateTime date;
  final int numberOfSets = 0 + Random().nextInt(30 - 0 + 1);

  SetsTile({super.key, required this.date});

  int getNumberOfSets() {
    return numberOfSets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: global.width(context) * 0.09,
      height: global.width(context) * 0.09,
      decoration: BoxDecoration(
        color: numberOfSets == 0
            ? Theme.of(context).colorScheme.surface.withOpacity(0.5)
            : Theme.of(context)
                .colorScheme
                .primary
                .withOpacity(0.4 + numberOfSets * 0.02),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
