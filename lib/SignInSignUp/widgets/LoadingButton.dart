import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter/material.dart';
import 'package:flexify/widgets/BounceElement.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.loading,
  });

  final String title;
  final Function() onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return BounceElement(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: global.width(context) * .8,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(global.borderRadius - 15),
          ),
          child: AnimatedSwitcher(
            duration: global.standardAnimationDuration,
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: child,
            ),
            child: loading
                ? SizedBox(
                    height: global.width(context) * 0.05,
                    width: global.width(context) * 0.05,
                    child: const CircularProgressIndicator(strokeWidth: 2.5),
                  )
                : Text(
                    title,
                    style: TextStyle(
                      fontSize: global.width(context) * 0.045,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
