import 'package:flexify/widgets/SetInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../data/exerciseModels.dart';
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
  final FixedExtentScrollController _minuteController =
      FixedExtentScrollController(initialItem: 1);
  final FixedExtentScrollController _secondController =
      FixedExtentScrollController(initialItem: 0);

  bool amountMetric = false;
  bool bodyweight = false;

  int newReps = 0;
  double newWeight = 0;
  getData() async {
    List<Set> sets = await Save.getSetList();

    for (int i = 0; i < sets.length; i++) {
      if (sets[i].exerciseName == widget.exerciseName) {
        repsController.text = sets[i].reps.toString();
        weightController.text = sets[i].weight.toString();
      }
    }
  }

  editSetInit() {
    newReps = widget.set!.reps;
    newWeight = widget.set!.weight;
    repsController.text = widget.set!.reps.toString();
    weightController.text = widget.set!.weight.toString();

    repsController.addListener(() {
      newReps = int.parse(repsController.text);
    });

    weightController.addListener(() {
      newWeight = double.tryParse(weightController.text)!;
    });
  }

  @override
  void initState() {
    widget.add ? getData() : editSetInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * (1 - 0.88),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.005),
                      width: MediaQuery.of(context).size.width * 0.14,
                      height: MediaQuery.of(context).size.width * 0.14,
                      decoration: BoxDecoration(
                        boxShadow: ([global.darkShadow(context)]),
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Theme.of(context).colorScheme.onBackground,
                        icon: const Icon(Icons.arrow_back_rounded),
                        iconSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.13,
                        right: MediaQuery.of(context).size.width * 0.13,
                        top: 10,
                      ),
                      child: Text(
                        widget.add ? 'Add Set' : 'Edit Set',
                        style: TextStyle(
                          color: Theme.of(context).focusColor,
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.005),
                      width: MediaQuery.of(context).size.width * 0.14,
                      height: MediaQuery.of(context).size.width * 0.14,
                      decoration: BoxDecoration(
                        boxShadow: ([global.darkShadow(context)]),
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () async {
                          if (widget.add) {
                            await Save.saveSet(
                              Set(
                                date: DateTime.now(),
                                exerciseName: widget.exerciseName,
                                reps: int.parse(
                                    repsController.text.replaceAll(',', '.')),
                                weight: double.tryParse(
                                  weightController.text.replaceAll(',', '.'),
                                )!,
                              ),
                              null,
                            );
                          } else {
                            await Save.editSet(
                              Set(
                                setID: widget.set!.setID,
                                date: widget.set!.date,
                                exerciseName: widget.set!.exerciseName,
                                reps: newReps,
                                weight: newWeight,
                              ),
                            );
                          }
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          setState(() {});
                        },
                        color: Theme.of(context).colorScheme.onBackground,
                        icon: const Icon(Icons.check_rounded),
                        iconSize: MediaQuery.of(context).size.width * 0.065,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          amountMetric = !amountMetric;
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: amountMetric
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width *
                                  global.containerWidthFactor,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.circular(1000),
                                boxShadow: [global.darkShadow(context)],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                padding: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width,
                                  ),
                                ),
                                child: Center(
                                  child: amountMetric
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.timer,
                                              color: Colors.black,
                                              size: global.width(context) * .05,
                                            ),
                                            SizedBox(
                                              width:
                                                  global.width(context) * .02,
                                            ),
                                            Text(
                                              "Time",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.autorenew,
                                              color: Colors.black,
                                              size: global.width(context) * .05,
                                            ),
                                            SizedBox(
                                              width:
                                                  global.width(context) * .05,
                                            ),
                                            Text(
                                              "Repetitions",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  amountMetric
                      ? Container(
                          margin: EdgeInsets.symmetric(
                              vertical: global.height(context) * .01),
                          width: global.width(context) *
                              global.containerWidthFactor,
                          height: global.height(context) * .15,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [global.darkShadow(context)],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .04,
                                width: global.width(context) * .7,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.5
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.2,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: ListWheelScrollView.useDelegate(
                                      controller: _minuteController,
                                      onSelectedItemChanged: (index) {
                                        setState(() {});
                                      },
                                      itemExtent: 50,
                                      perspective: 0.005,
                                      diameterRatio: 3.5,
                                      physics: const FixedExtentScrollPhysics(),
                                      childDelegate:
                                          ListWheelChildBuilderDelegate(
                                        childCount: 30,
                                        builder: (context, index) {
                                          return MinuteTile(minutes: index);
                                        },
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "m",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: global.width(context) * .04),
                                  ),
                                  SizedBox(
                                    width: global.width(context) * .05,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: ListWheelScrollView.useDelegate(
                                      controller: _secondController,
                                      onSelectedItemChanged: (index) {
                                        setState(() {});
                                      },
                                      itemExtent: 50,
                                      perspective: 0.005,
                                      diameterRatio: 3.5,
                                      physics: const FixedExtentScrollPhysics(),
                                      childDelegate:
                                          ListWheelChildBuilderDelegate(
                                        childCount: 60,
                                        builder: (context, index) {
                                          return SecondTile(seconds: index);
                                        },
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "s",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: global.width(context) * .04),
                                  ),
                                  SizedBox(
                                    width: global.width(context) * .05,
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      : SetInput(
                          title: 'Repetitions',
                          controller: repsController,
                          calcInterval: 1,
                        ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                        horizontal: MediaQuery.of(context).size.width * 0.075,
                      ),
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width *
                          global.containerWidthFactor,
                      decoration: BoxDecoration(
                        color: bodyweight
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.0375),
                        boxShadow: global.isDarkMode(context)
                            ? [global.darkShadow(context)]
                            : [global.lightShadow(context)],
                      ),
                      child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                bodyweight
                                    ? "Bodyweight added :)"
                                    : "Tap to add bodyweight to the set",
                                style: TextStyle(
                                    color: bodyweight
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                                0.01 +
                                            MediaQuery.of(context).size.width *
                                                0.02),
                              ),
                              bodyweight
                                  ? Icon(
                                      CupertinoIcons.checkmark_alt,
                                      color: Colors.black,
                                      size: MediaQuery.of(context).size.width *
                                          0.08,
                                    )
                                  : Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width *
                                          0.07,
                                    )
                            ]),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SetInput(
                    title: 'Weight',
                    controller: weightController,
                    calcInterval: 2.5,
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

class MinuteTile extends StatelessWidget {
  final int minutes;

  const MinuteTile({super.key, required this.minutes});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        minutes.toString(),
        style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.height * 0.01 +
                MediaQuery.of(context).size.width * 0.035),
      ),
    );
  }
}

class SecondTile extends StatelessWidget {
  final int seconds;

  const SecondTile({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        seconds.toString(),
        style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.height * 0.01 +
                MediaQuery.of(context).size.width * 0.035),
      ),
    );
  }
}
