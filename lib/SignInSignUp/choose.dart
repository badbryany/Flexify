import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/signIn.dart';
import 'package:flexify/SignInSignUp/signUp.dart';
import 'package:flexify/SignInSignUp/widgets/button.dart';
import 'package:flexify/SignInSignUp/widgets/fastSignIn.dart';
import 'package:flexify/SignInSignUp/widgets/background.dart';
import 'package:page_transition/page_transition.dart';

class Choose extends StatefulWidget {
  const Choose({super.key});

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> button = [
      {
        'labelText': 'Sign In',
        'onTap': () {
          Navigator.of(context).push(
            PageTransition(
              child: const SignIn(),
              type: PageTransitionType.fade,
            ),
          );
        },
      },
      {
        'labelText': 'Sign Up',
        'onTap': () {
          Navigator.of(context).push(
            PageTransition(
              child: const SignUp(),
              type: PageTransitionType.fade,
            ),
          );
        },
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
// background
          const Background(),
// text
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'hundreds of',
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                Text(
                  'exercises',
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ],
            ),
          ),
// button
          Container(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...button.map(
                    (e) => ButtonWithText(
                      text: e['labelText'],
                      onTap: e['onTap'],
                    ),
                  ),
                  const FastSignin(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
