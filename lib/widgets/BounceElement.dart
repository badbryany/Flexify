import 'package:flutter/material.dart';

class BounceElement extends StatefulWidget {
  const BounceElement({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<BounceElement> createState() => _BounceElementState();
}

class _BounceElementState extends State<BounceElement> {
  double scale = 1;
  int duration = 100;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: Duration(milliseconds: duration),
      scale: scale,
      child: GestureDetector(
        onTapDown: (value) => setState(() {
          scale = 0.98;
        }),
        onTapUp: (value) async => setState(() async {
          if (scale == 0.98) {
            await Future.delayed(Duration(milliseconds: duration - 20));
          }
          scale = 1.02;
          Future.delayed(
            Duration(milliseconds: duration),
            () {
              setState(() => scale = 1);
            },
          );
        }),
        onTapCancel: () => setState(() {
          scale = 1.02;
          Future.delayed(
            Duration(milliseconds: duration),
            () => setState(() => scale = 1),
          );
        }),
        child: widget.child,
      ),
    );
  }
}
