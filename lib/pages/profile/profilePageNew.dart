import 'package:flexify/pages/profile/widgets/Calories.dart';
import 'package:flexify/pages/profile/widgets/Sets.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.025,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SetsWidget(),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.025,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CaloriesWidget(),
          ],
        )
      ],
    );
  }
}
