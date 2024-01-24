import 'package:flexify/SignInSignUp/widgets/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flexify/SignInSignUp/widgets/button.dart';
import 'package:flexify/SignInSignUp/widgets/heading.dart';
import 'package:flexify/SignInSignUp/widgets/signInInput.dart';
import 'package:flexify/SignInSignUp/widgets/fastSignIn.dart';
import 'package:flexify/SignInSignUp/signUp.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              const Bubbles(),
              const LogInHeading(
                text: 'In',
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SignInInput(),
// finish button
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: ButtonWithText(
                          onTap: () {},
                          text: 'finish',
                        ),
                      ),
                      const FastSignin(),
// SignUp butten
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              PageTransition(
                              child: const SignUp(),
                              type: PageTransitionType.fade,
                            ),
                            );
                          },
                          child: const Text(
                            'SignUp',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}