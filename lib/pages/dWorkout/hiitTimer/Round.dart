import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/widgets/ModalBottomSheet.dart';
import 'widgets/SetTime.dart';

class Round {
  Round({
    required this.title,
    required this.roundDuration,
    required this.restDuration,
  });

  String title;
  Duration roundDuration;
  Duration restDuration;

  editTitle(String newTitle) => title = newTitle;

  editRestDuration(Duration newDur) => restDuration = newDur;

  editRoundDuration(Duration newDur) => roundDuration = newDur;

  Widget getWidget(
    BuildContext context,
    void Function(void Function()) setState,
    dynamic Function(Round, Widget) remove,
    int index,
    int totalLength,
  ) =>
      Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: global.width(context) * .03,
            ),
            padding: const EdgeInsets.all(15),
            width: global.containerWidth(context),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(global.borderRadius - 5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: global.width(context) * .05,
                  ),
                ),
                SetTime(
                  title: 'Rundenzeit',
                  duration: roundDuration,
                  add: (foo) {
                    roundDuration += const Duration(seconds: 1);
                    setState(() {});
                  },
                  sub: (foo) {
                    if (roundDuration == const Duration(seconds: 1)) return;

                    roundDuration -= const Duration(seconds: 1);
                    setState(() {});
                  },
                ),
                IconButton(
                  onPressed: () => remove(
                    this,
                    getWidget(context, setState, remove, index, totalLength),
                  ),
                  icon: Icon(
                    CupertinoIcons.trash,
                    size: global.width(context) * .05,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.5),
                  ),
                ),
              ],
            ),
          ),
          //

          AnimatedOpacity(
            duration: global.standardAnimationDuration,
            opacity: index == totalLength - 1 ? 0 : 1,
            child: GestureDetector(
              onTap: () => showCustomModalBottomSheet(
                context,
                ModalBottomSheet(
                  title: 'Resttime after "$title"',
                  titleSize: global.width(context) * .06,
                  onPop: () => Navigator.pop(context),
                  height: global.height(context) * .4,
                  submitButtonText: 'done',
                  content: StatefulBuilder(builder: (context, innerSetState) {
                    return Padding(
                      padding: EdgeInsets.all(global.height(context) * .05),
                      child: Transform.scale(
                        scale: 2,
                        child: SetTime(
                          title: '',
                          duration: restDuration,
                          add: (foo) {
                            restDuration += const Duration(seconds: 1);
                            innerSetState(() {});
                            setState(() {});
                          },
                          sub: (foo) {
                            if (restDuration == const Duration(seconds: 1)) {
                              return;
                            }

                            restDuration -= const Duration(seconds: 1);
                            innerSetState(() {});
                            setState(() {});
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                height: global.height(context) * .05,
                width: global.containerWidth(context),
                color: Colors.transparent,
                child: Text(
                  '${global.durationString(restDuration)} rest',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).focusColor.withOpacity(.75),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
