import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onTap,
    required this.title,
    this.icon,
    required this.loading,
  });

  final Function() onTap;
  final String title;
  final bool loading;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return BounceElement(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(19),
        margin: EdgeInsets.all(global.width(context) * .025),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(icon == null ? 20 : 30),
          color: Theme.of(context).colorScheme.background,
          boxShadow: global.shadow(context),
        ),
        child: AnimatedSwitcher(
          duration: global.standardAnimationDuration,
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: Center(
            key: ValueKey(loading),
            child: loading
                ? SizedBox(
                    width: global.width(context) * 0.05,
                    height: global.width(context) * 0.05,
                    child: global.loadingWidget(context, 1),
                  )
                : icon ??
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: global.width(context) * .05,
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
