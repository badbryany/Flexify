import 'package:flexify/SignInSignUp/deside.dart';
import 'package:flexify/SignInSignUp/mainSignIn.dart';
import 'package:flexify/pages/createTrainingPlan/createTrainingPage.dart';
import 'package:flexify/profilPage/mainProfilPage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class DashboardProfile extends StatefulWidget {
  const DashboardProfile({super.key});

  @override
  State<DashboardProfile> createState() => DashboardProfileState();
}

class DashboardProfileState extends State<DashboardProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Profile',
          style: TextStyle(fontSize: 50),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            PageTransition(
              child: const CreateTrainingPlan(),
              type: PageTransitionType.fade,
            ),
          ),
          child: const Text(
            'create training plan(ist nen link)',
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            PageTransition(
              child: const MainProfilPage(),
              type: PageTransitionType.fade,
            ),
          ),
          child: const Text(
            'profil page',
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            PageTransition(
              child: const MainSignIn(),
              type: PageTransitionType.fade,
            ),
          ),
          child: const Text(
            'link to sign in',
          ),
        ),
      ],
    );
  }
}
