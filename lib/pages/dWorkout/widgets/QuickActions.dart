import 'package:flexify/pages/dWorkout/hiitTimer/SetupHIITTimer.dart';
import 'package:flexify/pages/dWorkout/lockernumber/Lockernumber.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter/material.dart';

class QuickActions extends StatefulWidget {
  const QuickActions({super.key});

  @override
  State<QuickActions> createState() => _QuickActionsState();
}

class _QuickActionsState extends State<QuickActions> {
  bool isLockerNumberSet = false;
  int lockerNumber = 0;

  @override
  void initState() {
    super.initState();
  }

  setLockerNumber(int number) {
    isLockerNumberSet = true;
    lockerNumber = number;
    setState(() {});
  }

  getQuickActionButton(String title, IconData icon, Widget page) =>
      BounceElement(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        },
        child: Container(
          alignment: Alignment.center,
          height: global.height(context) * .1125,
          width: global.width(context) * .3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(global.borderRadius - 5),
            boxShadow: global.shadow(context),
            color: global.darkGrey,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLockerNumberSet && icon == CupertinoIcons.lock
                  ? global.gradient(
                      Text(
                        lockerNumber.toString(),
                        style: TextStyle(fontSize: global.width(context) * .1 - (lockerNumber.toString().length * global.width(context) * .01) ),
                      ),
                    )
                  : global.gradient(
                      Icon(
                        icon,
                        size: global.width(context) * .0775,
                      ),
                    ),
              global.smallHeight(context),
              Text(title),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: global.containerWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: getQuickActionButton(
              'Workout',
              CupertinoIcons.play,
              const SizedBox(),
            ),
          ),
          Flexible(
            flex: 1,
            child: getQuickActionButton(
              'HIIT Timer',
              CupertinoIcons.timer,
              const SetupHIITTimer(),
            ),
          ),
          Flexible(
            flex: 1,
            child: getQuickActionButton(
              'Locker',
              CupertinoIcons.lock,
              LockerNumberPage(
                setLockerNumber: setLockerNumber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
