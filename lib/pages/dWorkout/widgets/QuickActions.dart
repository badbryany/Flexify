import 'package:flexify/pages/dWorkout/hiitTimer/SetupHIITTimer.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  QuickActions({super.key});

  final List<Map<String, dynamic>> actions = [
    {
      'title': 'Workout',
      'icon': CupertinoIcons.play,
      'link': const SizedBox(),
    },
    {
      'title': 'HIIT Timer',
      'icon': CupertinoIcons.timer,
      'link': const SetupHIITTimer(),
    },
    {
      'title': 'Locker',
      'icon': CupertinoIcons.bookmark,
      'link': const SizedBox(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: global.containerWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: actions
            .map(
              (e) => BounceElement(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => e['link'],
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: global.height(context) * .1125,
                    width: global.width(context) * .3,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(global.borderRadius - 5),
                      boxShadow: global.shadow(context),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        global.isDarkMode(context)
                            ? global.gradient(
                                Icon(
                                  e['icon'],
                                  size: global.width(context) * .0775,
                                ),
                              )
                            : Icon(
                                e['icon'],
                                size: global.width(context) * .0775,
                              ),
                        global.smallHeight(context),
                        Text(e['title']),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
