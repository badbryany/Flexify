import 'package:flexify/pages/intro/2_gender.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter_animate/flutter_animate.dart';

class OneWelcome extends StatefulWidget {
  const OneWelcome({super.key});

  @override
  State<OneWelcome> createState() => _OneWelcomeState();
}

class _OneWelcomeState extends State<OneWelcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.43,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.0375,
                    ),
                    boxShadow: [
                      global.darkShadow(context),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to Flexify!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.07),
                      )
                          .animate()
                          .fadeIn(
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.bounceIn)
                          .then(),
                      Text(
                        'Press Start to begin',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.shadow,
                            fontSize: MediaQuery.of(context).size.width * 0.05),
                      ).animate().fadeIn(
                            delay: const Duration(milliseconds: 1500),
                            curve: Curves.decelerate,
                            duration: const Duration(milliseconds: 1000),
                          )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TwoGender(
                          isSettings: false,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      boxShadow: [global.darkShadow(context)],
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Start',
                          style: TextStyle(
                              color: Theme.of(context).focusColor,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(
                      delay: const Duration(milliseconds: 1500),
                      curve: Curves.decelerate,
                      duration: const Duration(milliseconds: 1000),
                    )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
