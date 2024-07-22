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
            // height: global.height(context) * .15,
            margin: EdgeInsets.symmetric(
              vertical: global.height(context) * .005,
            ),
            padding: EdgeInsets.symmetric(
              vertical: global.height(context) * .025,
            ),
            decoration: BoxDecoration(
              color: global.darkGrey,
              borderRadius: BorderRadius.circular(global.borderRadius),
              boxShadow: global.shadow(context),
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 4,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: global.width(context) * .055,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: SetTime(
                      title: 'Rundenzeit',
                      duration: roundDuration,
                      add: (addDuration) {
                        roundDuration += addDuration;
                        setState(() {});
                      },
                      sub: (subDuration) {
                        if (roundDuration == const Duration(seconds: 1)) return;

                        roundDuration -= subDuration;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: IconButton(
                        onPressed: () => remove(
                          this,
                          getWidget(
                              context, setState, remove, index, totalLength),
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
                    ),
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
                  submitButtonText: 'Done',
                  content: StatefulBuilder(builder: (context, innerSetState) {
                    return Padding(
                      padding: EdgeInsets.all(global.height(context) * .05),
                      child: Transform.scale(
                        scale: 2,
                        child: SetTime(
                          title: '',
                          duration: restDuration,
                          add: (addDuration) {
                            restDuration += addDuration;
                            innerSetState(() {});
                            setState(() {});
                          },
                          sub: (subDuration) {
                            if (restDuration == const Duration(seconds: 5)) {
                              return;
                            }
                            restDuration -= subDuration;
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
                  '${global.durationString(restDuration)} Rest',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).focusColor,
                      fontSize: global.height(context) * .025),
                ),
              ),
            ),
          ),
        ],
      );
}
