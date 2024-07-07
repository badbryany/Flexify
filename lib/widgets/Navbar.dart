import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  static double actionButtonWidthFactor = 0.15;

  const Navbar({
    super.key,
    required this.title,
    this.titleSize,
    this.onTap,
    this.actionButton,
    this.topRightWidget,
  });

  final String title;
  final double? titleSize;
  final Function? onTap;

  final ActionButton? actionButton;
  final Widget? topRightWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(global.width(context) * .05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BounceElement(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(global.width(context) * 0.005),
                width: global.width(context) * 0.15,
                height: global.width(context) * 0.15,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: global.shadow(context)),
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Theme.of(context).colorScheme.onBackground,
                  size: global.width(context) * 0.05,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).focusColor,
              fontSize: titleSize ?? global.width(context) * .06,
            ),
          ),
          topRightWidget == null
              ? actionButton != null
                  ? actionButton!
                  : SizedBox(width: global.width(context) * .155)
              : topRightWidget!,
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.iconData,
    required this.action,
  });

  final IconData iconData;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    return BounceElement(
      child: GestureDetector(
        onTap: action,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(global.width(context) * 0.005),
          width: global.width(context) * Navbar.actionButtonWidthFactor,
          height: global.width(context) * Navbar.actionButtonWidthFactor,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(100),
              boxShadow: global.shadow(context)),
          child: Icon(
            iconData,
            color: Theme.of(context).colorScheme.onBackground,
            size: global.width(context) * 0.05,
          ),
        ),
      ),
    );
  }
}
