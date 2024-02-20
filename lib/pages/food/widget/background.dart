import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart';

class Background extends StatelessWidget {
  const Background({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
