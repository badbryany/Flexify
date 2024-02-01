import 'package:flutter/material.dart';
import 'package:flexify/pages/dashboard.dart';
import 'package:flexify/SignInSignUp/choose.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Deside extends StatefulWidget {
  const Deside({super.key});

  @override
  State<Deside> createState() => _DesideState();
}

class _DesideState extends State<Deside> {
  @override
  void initState() {
    super.initState();
    signedUp();
  }

  Widget refresh = const Choose();

  void signedUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('signedUp')!) {
      refresh = const Dashboard();
    } else {
      refresh = const Choose();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return refresh;

    // AnimatedSwitcher(
    //   duration: standardAnimationDuration,
    //   child: refresh,
    //   transitionBuilder: (child, animation) => FadeTransition(
    //     opacity: animation,
    //     child: child,
    //   ),
    // );
  }
}
