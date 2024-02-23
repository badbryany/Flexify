import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class Shadow extends StatelessWidget {
  const Shadow({
    super.key,
    required this.child,
    required this.borderRadius,
  });
  final Widget child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [global.lightShadow(context)],
      ),
      child: child,
    );
  }
}
