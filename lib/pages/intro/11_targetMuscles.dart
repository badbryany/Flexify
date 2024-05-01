import 'package:flexify/pages/intro/12_location.dart';
import 'package:flexify/pages/intro/widgets/IntroNavbarIcon.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class ElevenTargetMuscles extends StatefulWidget {
  final bool isSettings;
  const ElevenTargetMuscles({super.key, required this.isSettings});

  @override
  State<ElevenTargetMuscles> createState() => _ElevenTargetMusclesState();
}

class _ElevenTargetMusclesState extends State<ElevenTargetMuscles> {
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  int selected = 1;

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
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  children: [
                    const IntroNavBarIcon(),
                    widget.isSettings
                        ? Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.11, right:  MediaQuery.of(context).size.width * 0.13),
                          child: Text(
                              "Target Muscles",
                              style:
                                  TextStyle(color: Theme.of(context).focusColor, fontSize: MediaQuery.of(context).size.width * 0.06),
                            ),
                        )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                    widget.isSettings
                        ? const SizedBox()
                        : 
                    GestureDetector(
                      onTap: () {
                        if (widget.isSettings == false) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TwelveLocation(isSettings: false,),
                            ),
                          );
                        }
                        else {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(color: Theme.of(context).focusColor, fontSize: MediaQuery.of(context).size.width * 0.035),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02)
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                widget.isSettings
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      )
                    : Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width * 0.045,
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
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.005),
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.035,
                              width: MediaQuery.of(context).size.width * 0.035,
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
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.0375),
                    border: Border.all(
                      color: Theme.of(context).focusColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Which muscles do you',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.01 +
                              MediaQuery.of(context).size.width * 0.02,
                        ),
                      ),
                      Text(
                        'want to grow?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.01 +
                              MediaQuery.of(context).size.width * 0.02,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: const Center(
                      child: Text("TODO: Clickable (Hightlights), 3d Model")),
                ),
                GestureDetector(
                  onTap: () {
                    if (selected != 0 && widget.isSettings == false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TwelveLocation(isSettings: false,),
                        ),
                      );
                    }
                    else {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      boxShadow: [global.darkShadow(context)],
                      color: selected != 0
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.isSettings ? "Enter" : "Next",
                          style: TextStyle(
                              color: Theme.of(context).focusColor,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025),
                        ),
                      ],
                    ),
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
