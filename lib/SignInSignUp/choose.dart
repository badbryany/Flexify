import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/signIn.dart';
import 'package:flexify/SignInSignUp/signUp.dart';
import 'package:flexify/SignInSignUp/widgets/background.dart';
import 'package:page_transition/page_transition.dart';

class Choose extends StatefulWidget {
  const Choose({super.key});

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  List<Map<String, dynamic>> buttons = [
    {
      'icon': const SizedBox(),
      'title': 'SIGN UP FREE',
      'highlight': true,
      'link': const SignUp(),
    },
    {
      'icon': Image.asset('assets/icon/facebook.png', scale: 5),
      'title': 'Continue with Facebook',
      'highlight': false,
      'link': const SizedBox(),
    },
    {
      'icon': Image.asset('assets/icon/google.png', scale: 10),
      'title': 'Continue with Google',
      'highlight': false,
      'link': const SizedBox(),
    },
    {
      'icon': Image.asset('assets/icon/apple2.png', scale: 10),
      'title': 'Continue with Apple',
      'highlight': false,
      'link': const SizedBox(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // background
          const Background(),
          // text
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/logo.png',
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.25,
                ),
                Text(
                  'Optimize your',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.095,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...['Workout with ', 'Flexify', '!'].map(
                      (e) => Text(
                        e,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.095,
                          color: e == 'Flexify'
                              ? Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.75)
                              : Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.06),

                // buttons
                ...buttons.map(
                  (e) => GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      PageTransition(
                        child: e['link'],
                        type: PageTransitionType.fade,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        border: e['highlight']
                            ? null
                            : Border.all(
                                color: Colors.grey.shade900,
                                width: 2,
                              ),
                        color: e['highlight']
                            ? Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7)
                            : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          e['icon'],
                          !e['highlight']
                              ? SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1)
                              : const SizedBox(),
                          Text(
                            e['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    PageTransition(
                      child: const SignIn(),
                      type: PageTransitionType.fade,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ANMELDEN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.038,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
