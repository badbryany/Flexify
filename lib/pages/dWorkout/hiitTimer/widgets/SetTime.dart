import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/data/globalVariables.dart' as global;
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
          margin: const EdgeInsets.all(2.5),
          height: global.height(context) * 0.035,
          width: global.height(context) * 0.035,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: global.width(context) * .07,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(global.width(context) * 0.02),
      // padding: EdgeInsets.all(global.width(context) * 0.005),
      // height: global.height(context) * .18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   widget.title,
          //   style: TextStyle(
          //     color: Theme.of(context).colorScheme.onBackground,
          //     fontSize: global.width(context) * .025,
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              setButton(
                context,
                () => widget.sub(const Duration(seconds: 1)),
                '-',
              ),
              SizedBox(
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
              setButton(
                context,
                () => widget.add(const Duration(seconds: 1)),
                '+',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
