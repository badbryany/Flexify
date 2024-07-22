import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/widgets/ModalBottomSheet.dart';
import 'package:flutter/material.dart';

class SetTime extends StatefulWidget {
  const SetTime({
    super.key,
    required this.title,
    required this.duration,
    required this.add,
    required this.sub,
  });

  final String title;
  final void Function(Duration) add;
  final void Function(Duration) sub;
  final Duration duration;

  @override
  State<SetTime> createState() => _SetTimeState();
}

class _SetTimeState extends State<SetTime> {
  bool continueCount = true;

  String durationString(Duration dur) {
    double microseconds = dur.inMicroseconds.toDouble();

    var minutes = microseconds ~/ Duration.microsecondsPerMinute;
    microseconds = microseconds.remainder(Duration.microsecondsPerMinute);

    var minutesPadding = minutes < 10 ? "0" : "";

    var seconds = microseconds ~/ Duration.microsecondsPerSecond;
    microseconds = microseconds.remainder(Duration.microsecondsPerSecond);

    var secondsPadding = seconds < 10 ? "0" : "";

    return "$minutesPadding$minutes:"
        "$secondsPadding$seconds";
  }

  Widget setButton(BuildContext context, Function() onTap, String text) {
    return BounceElement(
      onTap: () {},
      child: GestureDetector(
        onTapDown: (details) async {
          continueCount = true;
          while (continueCount) {
            onTap();
            await Future.delayed(const Duration(milliseconds: 100));
          }
        },
        onTapUp: (details) {
          continueCount = false;
        },
        child: Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            gradient: global.linearGradient,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Container(
            margin: const EdgeInsets.all(1),
            height: global.width(context) * 0.1 - 10,
            width: global.width(context) * 0.1 - 10,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: global.darkGrey,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              text == '+' ? Icons.add : Icons.remove,
              color: Colors.white,
              size: global.width(context) * .05,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FixedExtentScrollController secondController =
        FixedExtentScrollController(initialItem: 0);
    FixedExtentScrollController minuteController =
        FixedExtentScrollController(initialItem: 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            setButton(
              context,
              () => widget.sub(const Duration(seconds: 5)),
              '-',
            ),
            BounceElement(
              onTap: () {
                showCustomModalBottomSheet(
                  context,
                  ModalBottomSheet(
                    title: widget.title,
                    titleSize: global.width(context) * .1,
                    height: global.height(context) * .5,
                    content: Container(
                      height: global.height(context) * .175,
                      padding: EdgeInsets.only(
                        bottom: global.height(context) * .05,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: global.width(context) * .8,
                            height: global.height(context) * .06,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(
                                global.width(context) * 0.2,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: global.width(context) * 0.1,
                                    child: ListWheelScrollView.useDelegate(
                                      controller: minuteController,
                                      onSelectedItemChanged: (index) {
                                        widget.add(Duration(minutes: minuteController.selectedItem + 1, seconds: secondController.selectedItem) - widget.duration);
                                        setState(() {});
                                      },
                                      itemExtent: 50,
                                      perspective: 0.005,
                                      diameterRatio: 3.5,
                                      physics: const FixedExtentScrollPhysics(),
                                      childDelegate:
                                          ListWheelChildBuilderDelegate(
                                        childCount: 60,
                                        builder: (context, index) {
                                          return MinuteTile(minutes: index);
                                        },
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "m",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            global.height(context) * 0.005 +
                                                global.width(context) * 0.035),
                                  ),
                                  SizedBox(
                                    width: global.width(context) * .12,
                                  ),
                                  SizedBox(
                                    width: global.width(context) * 0.1,
                                    child: ListWheelScrollView.useDelegate(
                                      controller: secondController,
                                      onSelectedItemChanged: (index) {
                                        widget.add(Duration(minutes: minuteController.selectedItem + 1, seconds: secondController.selectedItem) - widget.duration);
                                        setState(() {});
                                      },
                                      itemExtent: 50,
                                      perspective: 0.005,
                                      diameterRatio: 3.5,
                                      physics: const FixedExtentScrollPhysics(),
                                      childDelegate:
                                          ListWheelChildBuilderDelegate(
                                        childCount: 60,
                                        builder: (context, index) {
                                          return SecondTile(seconds: index);
                                        },
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "s",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: global.height(context) * 0.005 +
                                          global.width(context) * 0.035,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    bigTitle: true,
                    submitButtonText: 'Enter',
                  ),
                );
              },
              child: SizedBox(
                width: global.width(context) * .21,
                child: Text(
                  durationString(widget.duration),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: global.width(context) * .06,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
            ),
            setButton(
              context,
              () => widget.add(const Duration(seconds: 5)),
              '+',
            ),
          ],
        ),
      ],
    );
  }
}

class SecondTile extends StatelessWidget {
  final int seconds;

  const SecondTile({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        seconds.toString(),
        style: TextStyle(
            color: Colors.white,
            fontSize:
                global.height(context) * 0.01 + global.width(context) * 0.035),
      ),
    );
  }
}

class MinuteTile extends StatelessWidget {
  final int minutes;

  const MinuteTile({super.key, required this.minutes});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        (minutes + 1).toString(),
        style: TextStyle(
            color: Colors.white,
            fontSize:
                global.height(context) * 0.01 + global.width(context) * 0.035),
      ),
    );
  }
}
