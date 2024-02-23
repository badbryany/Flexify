import 'package:flutter/material.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/pages/food/widget/shadow.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class ButtonWithIcon extends StatefulWidget {
  const ButtonWithIcon({
    super.key,
    required this.icon,
    required this.onTap,
  });
  final Widget icon;
  final Function() onTap;

  @override
  State<ButtonWithIcon> createState() => _ButtonWithIconState();
}

class _ButtonWithIconState extends State<ButtonWithIcon> {
  @override
  Widget build(BuildContext context) {
    return BounceElement(
      child: Shadow(
        borderRadius: global.borderRadius,
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: GestureDetector(
            onTap: widget.onTap,
            child: widget.icon,
          ),
        ),
      ),
    );
  }
}
