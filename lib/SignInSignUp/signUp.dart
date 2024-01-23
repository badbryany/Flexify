import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/signIn.dart';
import 'package:flexify/SignInSignUp/widgets/bubbles.dart';
import 'package:flexify/SignInSignUp/widgets/button.dart';
import 'package:flexify/SignInSignUp/widgets/heading.dart';
import 'package:flexify/SignInSignUp/widgets/fastSignIn.dart';
import 'package:flexify/SignInSignUp/widgets/SignUpPages/signUpPage1.dart';
import 'package:flexify/SignInSignUp/widgets/SignUpPages/signUpPage2.dart';
import 'package:page_transition/page_transition.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

Widget? refresh;
int pageSwitch = 0;

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    if (pageSwitch == 0) {
      refresh = const SignUpPage1();
    }
    if (pageSwitch == 1) {
      refresh = const SignUpPage2();
    }

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
                text: 'Up',
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
// SignIn page
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: refresh,
                        transitionBuilder: (child, animation) => FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      ),
// next button
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: ButtonWithText(
                          onTap: () {
                            pageSwitch++;
                            setState(() {});
                          },
                          text: 'next',
                        ),
                      ),
// FastSignIn
                      const FastSignin(),
// SignIn button
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              PageTransition(
                                child: const SignIn(),
                                type: PageTransitionType.fade,
                              ),
                            );
                            pageSwitch = 0;
                          },
                          child: const Text(
                            'SignIn',
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
