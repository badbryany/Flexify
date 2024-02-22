import 'package:flutter/material.dart';
import 'package:flexify/pages/food/widget/background.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onTap,
    required this.child,
  });
  final Function() onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Background(child: child),
    );
  }
}
