import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class DashboardXOptionButton extends StatelessWidget {
  const DashboardXOptionButton({
    super.key,
    required this.targetPage,
  });

  final Widget targetPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          PageTransition(
            child: targetPage,
            type: PageTransitionType.fade,
          )),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          color: const Theme.of(context).colorScheme.background,
          height: 200,
        ),
      ),
    );
  }
}
