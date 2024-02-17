import 'package:flexify/pages/createTrainingPlan/pages/ExperienceLevel.dart';
import 'package:flexify/pages/createTrainingPlan/pages/InitScreen.dart';
import 'package:flexify/pages/createTrainingPlan/pages/PainAreas.dart';
import 'package:flexify/pages/createTrainingPlan/pages/TrainingFrequency.dart';
import 'Button.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class CreateTrainingPlan extends StatefulWidget {
  const CreateTrainingPlan({super.key});

  @override
  State<CreateTrainingPlan> createState() => _CreateTrainingPlanState();
}

class _CreateTrainingPlanState extends State<CreateTrainingPlan> {
  int selectetPage = 0;

  next() {
    selectetPage++;

    if (selectetPage == 4) {
      // done
      selectetPage--;
    }

    setState(() {});
  }

  previos() {
    if (selectetPage == 0) return;
    selectetPage--;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [
      InitScreen(),
      ExperienceLevel(),
      TrainingFrequency(),
      PainAreas(),
    ];
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * pages.length,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: -MediaQuery.of(context).size.width * selectetPage,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...pages.map(
                      (e) => SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Stack(
                          children: [
                            Visibility(
                              visible: selectetPage != 0,
                              child: Positioned(
                                left: 10,
                                right: 0,
                                top: MediaQuery.of(context).size.height * 0.03,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.005),
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.15,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          global.lightShadow(context)
                                        ],
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                      ),
                                      child: IconButton(
                                        splashColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onPressed: previos,
                                        color: Theme.of(context).focusColor,
                                        icon: const Icon(
                                          Icons.arrow_back_rounded,
                                        ),
                                        iconSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                    ),
                                    const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                            Center(child: e),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: MediaQuery.of(context).size.height * 0.03,
                              child: Button(text: 'next', onPressed: next),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
