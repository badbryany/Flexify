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
    );
  }
}
