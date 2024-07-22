import 'package:flexify/pages/dShop/pages/widgets/ShopNavbar.dart';
import 'package:flexify/pages/dWorkout/exercisesPage/setsPage/addeditSetPage/widgets/SetInput.dart';
import 'package:flexify/pages/dWorkout/exercisesPage/setsPage/addeditSetPage/widgets/SetTimeBig.dart';
import 'package:flexify/pages/dWorkout/exercisesPage/setsPage/addeditSetPage/widgets/ToggleSetType.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class AddEditSet extends StatefulWidget {
  const AddEditSet({
    super.key,
    required this.exerciseName,
    required this.add,
    required this.set,
  });

  final String exerciseName;
  final bool add;
  final Set? set;

  @override
  State<AddEditSet> createState() => _AddEditSetState();
}

class _AddEditSetState extends State<AddEditSet> {
  final TextEditingController repsController = TextEditingController(
    text: '10',
  );
  final TextEditingController weightController = TextEditingController(
    text: '10',
  );

  Duration durTime = Duration.zero;

  List<Map<String, dynamic>> setTypes = [
    {'title': 'Repetitions', 'icon': Icons.autorenew},
    {'title': 'Time', 'icon': Icons.timer},
  ];
  int activeTypeIndex = 0;
  ScrollController typeInputController = ScrollController();

  bool bodyweight = false;

  int newReps = 0;
  double newWeight = 0;

  getData() async {
    List<Set> sets = await Save.getSetList();

    for (int i = sets.length - 1; i >= 0; i--) {
      if (sets[i].exerciseName == widget.exerciseName) {
        repsController.text = sets[i].reps.toString();
        weightController.text = sets[i].weight.toString();
        bodyweight = sets[i].isBodyweight;

        if (sets[i].isDuration) {
          activeTypeIndex = 1;
          typeInputController.animateTo(
            global.width(context) * activeTypeIndex,
            duration: global.standardAnimationDuration,
            curve: Curves.easeInOutCirc,
          );
          durTime = sets[i].getDuration();
        }

        setState(() {});
        break;
      }
    }
  }

  editSetInit() {
    newReps = widget.set!.reps;
    newWeight = widget.set!.weight;
    repsController.text = widget.set!.reps.toString();
    weightController.text = widget.set!.weight.toString();
    bodyweight = widget.set!.isBodyweight;

    if (widget.set!.isDuration) {
      activeTypeIndex = 1;
      typeInputController.animateTo(
        global.width(context) * activeTypeIndex,
        duration: global.standardAnimationDuration,
        curve: Curves.easeInOutCirc,
      );
      durTime = widget.set!.getDuration();
    }

    setState(() {});

    repsController.addListener(() {
      newReps = int.parse(repsController.text);
    });

    weightController.addListener(() {
      newWeight = double.tryParse(weightController.text)!;
    });
  }

  List<Widget> bodyWeightAndWeigh() => [
        global.smallHeight(context),
        GestureDetector(
          onTap: () {
            bodyweight = !bodyweight;
            setState(
              () {},
            );
          },
          child: AnimatedContainer(
            duration: global.standardAnimationDuration,
            padding: EdgeInsets.symmetric(
              horizontal: global.width(context) * 0.075,
            ),
            height: global.height(context) * 0.1,
            width: global.width(context) * global.containerWidthFactor,
            decoration: BoxDecoration(
              color: global.darkGrey,
              borderRadius: BorderRadius.circular(global.borderRadius - 5),
              boxShadow: global.isDarkMode(context)
                  ? [global.darkShadow(context)]
                  : [global.lightShadow(context)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedSwitcher(
                  duration: global.standardAnimationDuration,
                  child: SizedBox(
                    width: global.width(context) * .7,
                    key: ValueKey(bodyweight),
                    child: bodyweight
                        ? global.gradient(Text(
                            "Bodyweight added",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: global.height(context) * 0.01 +
                                    global.width(context) * 0.02),
                          ))
                        : Text(
                            "Tap to add bodyweight to the set",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: global.height(context) * 0.01 +
                                    global.width(context) * 0.02),
                          ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: global.standardAnimationDuration,
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                  child: SizedBox(
                    key: ValueKey(bodyweight),
                    child: bodyweight
                        ? global.gradient(const Icon(CupertinoIcons.checkmark))
                        : const Icon(
                            CupertinoIcons.add,
                            color: Colors.white,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        global.smallHeight(context),
        SetInput(
          title: 'Weight',
          controller: weightController,
          calcInterval: 2.5,
          canBeNegative: true,
        ),
      ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, widget.add ? getData : editSetInit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: global.height(context),
          width: global.width(context),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ShopNavbar(
                title: widget.add ? 'Add Set' : 'Edit Set',
                titleSize: global.width(context) * .075,
                actionButton: ActionButton(
                  iconData: Icons.check_rounded,
                  action: () async {
                    if (widget.add) {
                      await Save.saveSet(
                        Set(
                          isBodyweight: bodyweight,
                          durationInSeconds: durTime.inSeconds,
                          date: DateTime.now(),
                          exerciseName: widget.exerciseName,
                          reps: int.parse(
                              repsController.text.replaceAll(',', '.')),
                          weight: double.tryParse(
                            weightController.text.replaceAll(',', '.'),
                          )!,
                          isDuration: activeTypeIndex == 1,
                        ),
                        null,
                      );
                    } else {
                      await Save.editSet(
                        Set(
                          isBodyweight: bodyweight,
                          setID: widget.set!.setID,
                          date: widget.set!.date,
                          exerciseName: widget.set!.exerciseName,
                          reps: newReps,
                          weight: newWeight,
                          durationInSeconds: durTime.inSeconds,
                          isDuration: activeTypeIndex == 1,
                        ),
                      );
                    }
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    setState(() {});
                  },
                ),
              ),
              global.mediumHeight(context),
              Column(
                children: [
                  ToggleSetType(
                    types: setTypes,
                    activeIndex: activeTypeIndex,
                    onChange: (int newIndex) {
                      activeTypeIndex = newIndex;
                      setState(() {});

                      typeInputController.animateTo(
                        global.width(context) * activeTypeIndex,
                        duration: global.standardAnimationDuration,
                        curve: Curves.easeInOutCirc,
                      );
                    },
                  ),
                  global.mediumHeight(context),
                  SizedBox(
                    width: global.width(context),
                    height: global.height(context),
                    child: ListView(
                      controller: typeInputController,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          width: global.width(context),
                          child: Column(
                            children: [
                              SetInput(
                                title: 'Repetitions',
                                controller: repsController,
                                calcInterval: 1,
                              ),
                              ...bodyWeightAndWeigh(),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: global.width(context),
                          child: Column(
                            children: [
                              SetTimeBig(
                                title: 'Duration',
                                duration: durTime,
                                add: (dur) => setState(() => durTime += dur),
                                sub: (dur) => durTime != Duration.zero
                                    ? setState(() => durTime -= dur)
                                    : null,
                              ),
                              ...bodyWeightAndWeigh(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
