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
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(19),
          margin: EdgeInsets.all(global.width(context) * .05),
          width: global.width(context) * .6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(icon == null ? 100 : 30),
            color: Theme.of(context).colorScheme.background,
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
                      width: MediaQuery.of(context).size.width * 0.05,
                      height: MediaQuery.of(context).size.width * 0.05,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onBackground,
                        strokeWidth: 2,
                      ),
                    )
                  : icon == null
                      ? Text(
                          title,
                          style: TextStyle(
                            fontSize: global.width(context) * .05,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        )
                      : icon,
            ),
          ),
        ),
      ),
    );
  }
}
