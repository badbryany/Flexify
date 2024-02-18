import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

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
                    boxShadow: [global.darkShadow(context)],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to Flexify!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.047),
                      ),
                      Text(
                        'Press Start to begin',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.shadow,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.034),
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Container(
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
                                MediaQuery.of(context).size.height * 0.02),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
