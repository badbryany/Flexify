import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/widgets/ModalBottomSheet.dart';
import 'package:flutter/material.dart';

class SetTimeBig extends StatefulWidget {
  const SetTimeBig({
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
  State<SetTimeBig> createState() => _SetTimeBigState();
}

class _SetTimeBigState extends State<SetTimeBig> {
  bool continueCount = true;
  TextEditingController controller = TextEditingController();

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
      child: GestureDetector(
        onTapDown: (details) async {
          continueCount = true;
          while (continueCount) {
            onTap();
            await Future.delayed(const Duration(milliseconds: 100));
          }
        },
        onTapUp: (details) => continueCount = false,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            gradient: global.linearGradient,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Container(
            height: global.height(context) * 0.09,
            width: global.height(context) * 0.09,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: global.darkGrey,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                width: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
        ),
      ),
    );
  }

  FixedExtentScrollController secondController =
      FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController minuteController =
      FixedExtentScrollController(initialItem: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(global.width(context) * 0.02),
      padding: EdgeInsets.symmetric(
          horizontal: global.width(context) * 0.025,
          vertical: global.height(context) * .02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(global.borderRadius),
        color: global.darkGrey,
        boxShadow: [global.darkShadow(context)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding:
                EdgeInsets.symmetric(vertical: global.height(context) * .01),
            decoration: BoxDecoration(
              color: global.lightGrey,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: global.width(context) * .05,
              ),
            ),
          ),
          SizedBox(
            height: global.height(context) * .02,
          ),
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
                                          widget.add(Duration(
                                                  minutes: minuteController
                                                          .selectedItem +
                                                      1,
                                                  seconds: secondController
                                                      .selectedItem) -
                                              widget.duration);
                                          setState(() {});
                                        },
                                        itemExtent: 50,
                                        perspective: 0.005,
                                        diameterRatio: 3.5,
                                        physics:
                                            const FixedExtentScrollPhysics(),
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
                                          fontSize: global.height(context) *
                                                  0.005 +
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
                                          widget.add(Duration(
                                                  minutes: minuteController
                                                          .selectedItem +
                                                      1,
                                                  seconds: secondController
                                                      .selectedItem) -
                                              widget.duration);
                                          setState(() {});
                                        },
                                        itemExtent: 50,
                                        perspective: 0.005,
                                        diameterRatio: 3.5,
                                        physics:
                                            const FixedExtentScrollPhysics(),
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
                                        fontSize:
                                            global.height(context) * 0.005 +
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
                  width: global.width(context) * .35,
                  child: Text(
                    durationString(widget.duration),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: global.width(context) * .075,
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
      ),
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
