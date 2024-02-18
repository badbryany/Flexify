import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class TwoGender extends StatefulWidget {
  const TwoGender({super.key});

  @override
  State<TwoGender> createState() => _TwoGenderState();
}

class _TwoGenderState extends State<TwoGender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.087,
                ),
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        border: Border.all(
                            color: Theme.of(context).focusColor,
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(1000),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.0225,
                        width: MediaQuery.of(context).size.height * 0.0225,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.055,
                ),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.0375),
                    boxShadow: [global.lightShadow(context)],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Are you male or',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.01 +
                                    MediaQuery.of(context).size.width * 0.01),
                      ),
                      Text(
                        'female?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.01 +
                                    MediaQuery.of(context).size.width * 0.01),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.1),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.width * 0.35,
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.02),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.0375,
                              ),
                              boxShadow: [global.darkShadow(context)],
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.05),
                                Text(
                                  "Female",
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03),
                                ),
                                Icon(
                                  Icons.female_outlined,
                                  color: Theme.of(context).colorScheme.surface,
                                  size: MediaQuery.of(context).size.width * 0.17,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.width * 0.35,
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.02),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.0375,
                              ),
                              boxShadow: [global.darkShadow(context)],
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.05),
                                Text(
                                  "Male",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.width * 0.007,),
                                Icon(
                                  Icons.male_outlined,
                                  color: Theme.of(context).colorScheme.surface,
                                  size: MediaQuery.of(context).size.width * 0.17,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
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
                        'Next',
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
