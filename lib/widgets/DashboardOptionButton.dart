import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class DashboardXOptionButton extends StatelessWidget {
  const DashboardXOptionButton({
    super.key,
    required this.targetPage,
    required this.content,
    required this.title,
  });

  final Widget targetPage;
  final Widget content;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageTransition(
          child: targetPage,
          type: PageTransitionType.fade,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
          left: 25,
          right: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
                BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.4),
                  spreadRadius: -10.0,
                  blurRadius: 10.0,
                  offset: const Offset(0, 10.0),
                )
              ],
        ),
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).focusColor,
              ),
            ),
            content,
          ],
        ),
      ),
    );
  }
}
