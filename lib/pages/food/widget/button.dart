import 'package:flutter/material.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/pages/food/widget/shadow.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class ButtonWithText extends StatefulWidget {
  const ButtonWithText({
    super.key,
    required this.text,
    required this.onTap,
    required this.borderColor,
  });
  final String text;
  final Function() onTap;
  final Color borderColor;

  @override
  State<ButtonWithText> createState() => _ButtonWithTextState();
}

class _ButtonWithTextState extends State<ButtonWithText> {
  @override
  Widget build(BuildContext context) {
    return BounceElement(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            border: Border.all(color: widget.borderColor),
            borderRadius: BorderRadius.circular(global.borderRadius * 0.4),
            color: Theme.of(context).colorScheme.background,
            boxShadow: [global.darkShadow(context)],
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
