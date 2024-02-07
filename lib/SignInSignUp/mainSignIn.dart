import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/choose.dart';
import 'package:flexify/SignInSignUp/widgets/background.dart';

class MainSignIn extends StatefulWidget {
  const MainSignIn({super.key});

  @override
  State<MainSignIn> createState() => MainSignInState();
}

class MainSignInState extends State<MainSignIn> {
  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
// background
        Background(),
// buttons
        Choose(),
      ],
    );
  }
}
