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
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(30),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
            content,
          ],
        ),
      ),
    );
  }
}
