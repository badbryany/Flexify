import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class SignInNew extends StatefulWidget {
  const SignInNew({super.key});

  @override
  State<SignInNew> createState() => _SignInNewState();
}

class _SignInNewState extends State<SignInNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(color: Theme.of(context).scaffoldBackgroundColor),
            Stack(
              children: [
                ClipPath(
                  clipper: BezierClipper(),
                  child: Container(
                    color: Theme.of(context).focusColor,
                    height: 700,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1,
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: Text(
                    "Log in",
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: MediaQuery.of(context).size.width * 0.1,
                        letterSpacing: -0.1,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2,
                left: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.0375),
                  border:
                      Border.all(color: Theme.of(context).focusColor, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.onSurface,
                      spreadRadius: -5.0,
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.037),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(
                              color: Theme.of(context).focusColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.033),
                              Icon(
                                Icons.email_outlined,
                                color: Theme.of(context).focusColor,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              Text(
                                "Email",
                                style: TextStyle(
                                  color: Theme.of(context).focusColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(
                              color: Theme.of(context).focusColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.035),
                              const Icon(Icons.key),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              Text(
                                "Password",
                                style: TextStyle(
                                  color: Theme.of(context).focusColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(1000),
                            border: Border.all(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Log in",
                                style: TextStyle(
                                  letterSpacing: -0.2,
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: 1,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.025,
                            ),
                            Text(
                              "or continue with",
                              style: TextStyle(
                                color: Theme.of(context).focusColor,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.025,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: 1,
                              color: Theme.of(context).focusColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              color:
                                  Theme.of(context).focusColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(1000),
                              boxShadow: [global.lightShadow(context)]),
                          child: Row(
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.04),
                              Icon(
                                Icons.apple,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.12),
                              Text(
                                "Continue with Apple",
                                style: TextStyle(
                                    letterSpacing: -0.5,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.023),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              color: Theme.of(context).focusColor,
                              borderRadius: BorderRadius.circular(1000),
                              boxShadow: [global.lightShadow(context)]),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.045),
                              Image.asset(
                                'assets/icon/google.png',
                                scale: 27,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.12),
                              Text(
                                "Continue with Google",
                                style: TextStyle(
                                  letterSpacing: -0.5,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.023,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.3,
                                color: Theme.of(context).focusColor),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -1,
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.7)),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.5,
                                    color: Theme.of(context).focusColor),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.75);

    path.quadraticBezierTo(size.width * 0.25, size.height * 0.5,
        size.width * 0.5, size.height * 0.75);
    //
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 1, size.width, size.height * 0.75);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
