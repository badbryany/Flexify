import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/widgets/shadow.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class ButtonWithText extends StatefulWidget {
  const ButtonWithText({
    super.key,
    required this.text,
    required this.onTap,
    required this.loading,
  });
  final String text;
  final bool loading;
  final Function() onTap;

  @override
  State<ButtonWithText> createState() => _ButtonWithTextState();
}

class _ButtonWithTextState extends State<ButtonWithText> {
  @override
  Widget build(BuildContext context) {
    return BounceElement(
      onTap: widget.onTap,
      child: Container(
        height: global.height(context) * 0.08,
        width: global.width(context) * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(global.borderRadius * 0.4),
          color: Theme.of(context).colorScheme.background,
          boxShadow: [global.darkShadow(context)],
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: global.standardAnimationDuration,
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: child,
            ),
            child: widget.loading
                ? SizedBox(
                    height: global.width(context) * 0.05,
                    width: global.width(context) * 0.05,
                    child: const CircularProgressIndicator(strokeWidth: 2.5),
                  )
                : Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: global.width(context) * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.surface,
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
      borderRadius: global.borderRadius * 0.2,
      child: BounceElement(
        onTap: onTap,
        child: SizedBox(
          width: global.width(context) * 0.1,
          height: global.width(context) * 0.1,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(global.borderRadius * 0.2),
            ),
            child: Center(
              child: image,
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
      onTap: widget.onTap,
      child: Shadow(
        borderRadius: global.borderRadius,
        child: Container(
          color: Colors.black,
          child: widget.icon,
        ),
      ),
    );
  }
}
