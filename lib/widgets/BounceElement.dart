import 'package:flutter/material.dart';

class BounceElement extends StatefulWidget {
  BounceElement({
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
        onTapUp: (value) => setState(() {
          // arthur hat das async rausgenommen, weil es eine ewige fehlermeldung gab
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
