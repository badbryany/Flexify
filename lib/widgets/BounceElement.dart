import 'package:flutter/material.dart';

class BounceElement extends StatefulWidget {
  const BounceElement({
    super.key,
    required this.child,
    this.onTap,
  });

  final Widget child;
  final void Function()? onTap;

  @override
  State<BounceElement> createState() => _BounceElementState();
}

class _BounceElementState extends State<BounceElement> {
  double scale = 1;
  int duration = 100;

  bool isDisposed = false;

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  setStateCustom(void Function() fn) {
    if (!isDisposed) setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: Duration(milliseconds: duration),
      scale: scale,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (value) => setStateCustom(() {
          scale = 0.98;
        }),
        onTapUp: (value) => setStateCustom(() {
          scale = 1.02;
          Future.delayed(
            Duration(milliseconds: duration),
            () {
              setStateCustom(() => scale = 1);
            },
          );
        }),
        onTapCancel: () => setStateCustom(() {
          scale = 1.02;
          Future.delayed(
            Duration(milliseconds: duration),
            () => setStateCustom(() => scale = 1),
          );
        }),
        child: widget.child,
      ),
    );
  }
}
