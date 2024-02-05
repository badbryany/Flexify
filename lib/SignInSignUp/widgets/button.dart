import 'package:flexify/data/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/widgets/shadow.dart';
import 'package:flexify/widgets/BounceElement.dart';

class ButtonWithText extends StatefulWidget {
  const ButtonWithText({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final Function() onTap;

  @override
  State<ButtonWithText> createState() => _ButtonWithTextState();
}

class _ButtonWithTextState extends State<ButtonWithText> {
  @override
  Widget build(BuildContext context) {
    return BounceElement(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.09,
        child: Shadow(
          borderRadius: borderRadius,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius * 0.4),
              color: Theme.of(context).colorScheme.background,
            ),
            child: GestureDetector(
              onTap: widget.onTap,
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageButton extends StatelessWidget {
  const ImageButton({
    super.key,
    required this.onTap,
    required this.image,
  });
  final Function() onTap;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Shadow(
      borderRadius: borderRadius * 0.2,
      child: BounceElement(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.width * 0.1,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(borderRadius * 0.2),
            ),
            child: GestureDetector(
              onTap: onTap,
              child: Center(
                child: image,
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
        borderRadius: borderRadius,
        child: Container(
          color: Colors.black,
          child: GestureDetector(
            onTap: widget.onTap,
            child: widget.icon,
          ),
        ),
      ),
    );
  }
}
