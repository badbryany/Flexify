import 'package:flexify/pages/profile/widgets/AddFriends.dart';
import 'package:flexify/pages/profile/widgets/PersonalElement.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class DashboardProfile extends StatefulWidget {
  const DashboardProfile({super.key});

  @override
  State<DashboardProfile> createState() => _DashboardProfileState();
}

class _DashboardProfileState extends State<DashboardProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PersonalElement(),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            PageTransition(
              child: const AddFriends(),
              type: PageTransitionType.rightToLeft,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(30),
            color: Theme.of(context).colorScheme.background,
            child: Text(
              'friends ->',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
