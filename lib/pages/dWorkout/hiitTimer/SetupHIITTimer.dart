import 'package:flexify/pages/dShop/pages/widgets/ShopNavbar.dart';
import 'package:flexify/pages/dWorkout/hiitTimer/HIITTimer.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'Round.dart';

class SetupHIITTimer extends StatefulWidget {
  const SetupHIITTimer({super.key});

  @override
  State<SetupHIITTimer> createState() => _SetupHIITTimerrState();
}

class _SetupHIITTimerrState extends State<SetupHIITTimer> {
  final GlobalKey<AnimatedListState> animatedListKey =
      GlobalKey<AnimatedListState>();
  List<Round> rounds = [];

  startTimer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HiitTimer(rounds: rounds),
      ),
    );
  }

  addRound() {
    rounds.add(Round(
      title: 'Round ${rounds.length + 1}',
      roundDuration: rounds.isEmpty
          ? const Duration(seconds: 60)
          : rounds.last.roundDuration,
      restDuration: const Duration(seconds: 15),
    ));
    setState(() {});

    animatedListKey.currentState!.insertItem(rounds.length - 1);
  }

  removeRound(Round delRound, Widget child) {
    for (int i = 0; i < rounds.length; i++) {
      if (rounds[i].title == delRound.title) {
        animatedListKey.currentState!.removeItem(
          i,
          (context, animation) => SizeTransition(
            axisAlignment: 0,
            sizeFactor: animation,
            child: SlideTransition(
              position: animation.drive(
                Tween(begin: const Offset(1, .5), end: const Offset(0, 0)),
              ),
              child: child,
            ),
          ),
        );
        rounds.removeAt(i);
        break;
      }
    }

    for (int i = 0; i < rounds.length; i++) {
      if (rounds[i].title.contains('Round ')) {
        rounds[i].title = 'Round ${i + 1}';
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ShopNavbar(
              title: 'HIIT Timer',
              titleSize: global.width(context) * .075,
            ),
            SizedBox(
              height: global.height(context) * .7,
              width: global.containerWidth(context),
              child: Stack(
                children: [
                  Center(
                    child: AnimatedOpacity(
                      opacity: rounds.isEmpty ? 1 : 0,
                      duration: global.standardAnimationDuration,
                      child: SizedBox(
                        height: global.height(context) * .85 -
                            global.width(context) * .175,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Click  \'+\'  to add a round!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: global.width(context) * 0.04,
                                color: Theme.of(context).focusColor,
                              ),
                            ),
                            Transform.rotate(
                              angle: -1.8,
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: SvgPicture.asset(
                                  'assets/Squiggly Arrow.svg',
                                  width: global.width(context) * 0.8,
                                  height: global.width(context) * 0.6,
                                  color: Theme.of(context).focusColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: global.standardAnimationDuration,
                    opacity: rounds.isEmpty ? 0 : 1,
                    child: Center(
                      child: SizedBox(
                        width: global.width(context),
                        height: global.height(context) * .75,
                        child: AnimatedList(
                          key: animatedListKey,
                          initialItemCount: rounds.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index, animation) =>
                              SlideTransition(
                            position: animation.drive(
                              Tween(
                                begin: const Offset(1, 0),
                                end: const Offset(0, 0),
                              ),
                            ),
                            child: rounds[index].getWidget(
                              context,
                              setState,
                              removeRound,
                              index,
                              rounds.length,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: global.containerWidth(context),
              child: Row(
                children: [
                  BounceElement(
                    onTap: addRound,
                    child: Container(
                      width: global.height(context) * .08,
                      height: global.height(context) * .08,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: global.darkGrey,
                        borderRadius: BorderRadius.circular(
                          global.borderRadius,
                        ),
                      ),
                      child: Icon(
                        CupertinoIcons.add,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(width: global.width(context) * .05),
                  Flexible(
                    flex: 4,
                    child: AnimatedOpacity(
                      duration: global.standardAnimationDuration,
                      opacity: rounds.isEmpty ? .5 : 1,
                      child: BounceElement(
                        onTap: () => rounds.isEmpty ? null : startTimer(),
                        child: Container(
                          alignment: Alignment.center,
                          height: global.height(context) * .08,
                          padding: EdgeInsets.symmetric(
                            horizontal: global.width(context) * .025,
                          ),
                          decoration: BoxDecoration(
                            color: global.darkGrey,
                            borderRadius: BorderRadius.circular(
                              global.borderRadius,
                            ),
                          ),
                          child: global.gradient(
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Icon(
                                    CupertinoIcons.play,
                                    size: global.width(context) * .05,
                                  ),
                                ),
                                SizedBox(width: global.width(context) * .025),
                                Text(
                                  'Start HIIT Timer',
                                  style: TextStyle(
                                    fontSize: global.width(context) * .05,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: global.width(context) * .02,
            )
          ],
        ),
      ),
    );
  }
}
