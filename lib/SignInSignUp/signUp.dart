import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/widgets/button.dart';
import 'package:flexify/SignInSignUp/widgets/background.dart';
import 'package:flexify/SignInSignUp/SignUp/signUp1.dart';
import 'package:flexify/SignInSignUp/SignUp/signUp2.dart';
import 'package:flexify/data/globalVariables.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

Widget? refresh;
int pageSwitch = 0;
String nextButtonText = 'next';

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    if (pageSwitch == 0) {
      refresh = const SignUp1();
      nextButtonText = 'next';
    }
    if (pageSwitch == 1) {
      refresh = const SignUp2();
      nextButtonText = 'finish';
    }
    return Scaffold(
      body: Stack(
        children: [
// background
          const Background(),
// text
          Container(
            alignment: const Alignment(0, -0.3),
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontSize: 30,
              ),
            ),
          ),
// SignUp page
          Container(
            alignment: const Alignment(1, 0.4),
            child: AnimatedSwitcher(
              duration: standardAnimationDuration,
              child: refresh,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
// back button
          Container(
            alignment: Alignment.topLeft * 0.9,
            child: ButtonWithIcon(
              onTap: () {
                if (pageSwitch == 0) {
                  Navigator.pop(context);
                } else {
                  pageSwitch = 0;
                }
                setState(() {});
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
// next button
          Container(
            alignment: Alignment.bottomCenter * 0.9,
            child: ButtonWithText(
              text: nextButtonText,
              onTap: () {
                pageSwitch++;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}

                // if (usernameInput.toString() != '' &&
                //     passwordInput.toString() != '' &&
                //     passwordInput.toString().length > 5) {
                //   setUsername();
                //   setPassword();
                // }