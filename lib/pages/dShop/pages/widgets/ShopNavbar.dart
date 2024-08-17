import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/material.dart';

class ShopNavbar extends StatelessWidget {
  final String title;
  final double? titleSize;
  final Function? onTap;
  final double? alignmentWidth;

  final ActionButton? actionButton;

  const ShopNavbar({
    super.key,
    required this.title,
    this.titleSize,
    this.onTap,
    this.actionButton,
    this.alignmentWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(global.height(context) * .025),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BounceElement(
            onTap: () => Navigator.pop(context),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(global.height(context) * 0.0025),
              width: global.width(context) * 0.15,
              height: global.width(context) * 0.15,
              decoration: BoxDecoration(
                color: global.darkGrey,
                borderRadius: BorderRadius.circular(100),
                boxShadow: global.shadow(context),
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                size: global.width(context) * 0.05,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            width: global.width(context) * .5,
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                  color: Theme.of(context).focusColor,
                  fontSize: global.width(context) * .08 - title.length),
            ),
          ),
          actionButton != null
              ? actionButton!
              : SizedBox(width: alignmentWidth ?? global.width(context) * .15),
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
      onTap: action,
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
          iconData,
          color: Theme.of(context).colorScheme.onBackground,
          size: global.width(context) * 0.05,
        ),
      ),
    );
  }
}
