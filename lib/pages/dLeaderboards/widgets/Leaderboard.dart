import 'dart:ui';

import 'package:flexify/widgets/LoadingImage.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class Leaderboard extends StatelessWidget {
  const Leaderboard({
    super.key,
    required this.title,
    required this.data,
    required this.suffix,
  });

  final String title;
  final String suffix;
  final List<Person> data;

  List<Widget> leaderWidgets(BuildContext context) {
    if (data.isEmpty) return [];

    List<Widget> returnWidgets = [];

    List<Person> people = data;
    people.sort((a, b) => (b.value - a.value).round());

    List<Widget> leaderRow = [
      [
        1,
        people.isNotEmpty ? people[0].profilePictureUrl : '',
        people.isNotEmpty ? people[0].value : 0,
        people.isNotEmpty ? people[0].username : '-'
      ],
      [
        2,
        people.length >= 2 ? people[1].profilePictureUrl : '',
        people.length >= 2 ? people[1].value : 0,
        people.length >= 2 ? people[1].username : '-'
      ],
      [
        3,
        people.length >= 3 ? people[2].profilePictureUrl : '',
        people.length >= 3 ? people[2].value : 0,
        people.length >= 3 ? people[2].username : '-'
      ],
    ]
        .map((e) => Column(
              children: [
                // image
                SizedBox(
                  width: global.width(context) * .16,
                  height: global.width(context) * .16,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(1000),
                          ),
                        ),
                      ),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: AnimatedScale(
                            duration: global.standardAnimationDuration,
                            scale: 2,
                            child: ImageFiltered(
                              imageFilter:
                                  ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                              child: LoadingImage(
                                url: e[1] as String,
                                width: global.width(context) * .2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Stack(
                            children: [
                              LoadingImage(
                                url: e[1] as String,
                                width: global.width(context) * .16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: global.height(context) * .0125),
                Container(
                  width: global.width(context) * .065,
                  height: global.width(context) * .065,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: [
                      global.gold,
                      global.silver,
                      global.bronze
                    ][(e[0] as int) - 1]
                        .withOpacity(.1),
                    border: Border.all(
                        color: [
                          global.gold,
                          global.silver,
                          global.bronze
                        ][(e[0] as int) - 1]
                            .withOpacity(.3),
                        width: 1.5),
                  ),
                  child: Text(
                    ' ${e[0]}.',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                SizedBox(height: global.height(context) * .008),
                Text(
                  (e[3] as String).length > 13
                      ? '${(e[3] as String).substring(0, 10)}…'
                      : '${e[3]}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: global.width(context) * .0475,
                  ),
                ),
                SizedBox(height: global.height(context) * .005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${(e[2] as double).round()}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const Text(' '),
                    Text(
                      suffix,
                      style: TextStyle(
                        fontSize: global.width(context) * .025,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ],
            ))
        .toList();

    returnWidgets.add(SizedBox(height: global.height(context) * .025));
    returnWidgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: leaderRow,
    ));
    returnWidgets.add(SizedBox(height: global.height(context) * .03));

    for (int i = 3; i < people.length; i++) {
      returnWidgets.add(Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        decoration: BoxDecoration(
          color: global.isDarkMode(context)
              ? Theme.of(context).colorScheme.background.withOpacity(.3)
              : Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(global.borderRadius - 15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: global.width(context) * 0.12,
              height: global.width(context) * 0.12,
              child: Stack(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                        child: LoadingImage(
                          url: people[i].profilePictureUrl,
                          width: global.width(context) * 0.12,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: LoadingImage(
                        url: people[i].profilePictureUrl,
                        width: global.width(context) * 0.12,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: global.width(context) * .065,
                      height: global.width(context) * .065,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(.75),
                      ),
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: global.width(context) * .38,
              child: Text(
                people[i].username.length > 13
                    ? '${people[i].username.substring(0, 10)}…'
                    : people[i].username,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: global.width(context) * 0.045,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
            SizedBox(
              width: global.width(context) * .23,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${people[i].value.round()}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: global.width(context) * .06,
                    ),
                  ),
                  const Text(' '),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      suffix,
                      style: TextStyle(
                        fontSize: global.width(context) * .04,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
    }

    return returnWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: global.width(context) * global.containerWidthFactor,
      padding: EdgeInsets.all(global.containerPadding - 10),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: global.isDarkMode(context)
            ? Theme.of(context).colorScheme.background.withOpacity(.3)
            : Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(global.borderRadius),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(7),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: global.width(context) * 0.06,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.75),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share_rounded,
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.65),
                  size: global.width(context) * .05,
                ),
              )
            ],
          ),
          ...leaderWidgets(context),
        ],
      ),
    );
  }
}

class Person {
  Person({
    required this.username,
    required this.firstname,
    required this.value,
    required this.profilePictureUrl,
  });

  final String username;
  final String firstname;
  final double value;
  final String profilePictureUrl;
}
