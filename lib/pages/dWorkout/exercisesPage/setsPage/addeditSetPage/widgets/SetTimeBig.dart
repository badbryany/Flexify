import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/data/globalVariables.dart' as global;
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
          margin: const EdgeInsets.all(20),
          height: global.height(context) * 0.09,
          width: global.height(context) * 0.09,
          alignment: Alignment.center,
          decoration: BoxDecoration(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(global.width(context) * 0.02),
      padding: EdgeInsets.all(global.width(context) * 0.005),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(global.borderRadius),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [global.darkShadow(context)],
      ),
      height: global.height(context) * .18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: global.width(context) * 0.1,
              top: global.width(context) * 0.025,
            ),
            child: Text(
              widget.title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
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
                width: global.width(context) * .375,
                child: Text(
                  durationString(widget.duration),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: global.width(context) * .125,
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
