import 'dart:ffi';

import 'package:flexify/data/dummyExercises%20copy.dart';
import 'package:flexify/widgets/SetInput.dart';
import 'package:flutter/material.dart';
import 'package:flexify/widgets/Button.dart';
import '../../../../../data/exerciseModels.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class AddEditSet extends StatefulWidget {
  const AddEditSet({
    super.key,
    required this.exerciseName,
    required this.exerciseExists,
    required this.add,
    required this.set,
  });

  final String exerciseName;
  final bool add;
  final bool exerciseExists;
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.14,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.005),
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.width * 0.15,
                        decoration: BoxDecoration(
                          boxShadow: ([
                            global.lightShadow,
                          ]),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        child: IconButton(
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Theme.of(context).focusColor,
                          icon: const Icon(Icons.arrow_back_rounded),
                          iconSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.075,
                          right: MediaQuery.of(context).size.width * 0.075,
                          top: 10,
                        ),
                        child: Text(
                          widget.add ? 'Add Set' : 'Edit Set',
                          style: TextStyle(
                            color: Theme.of(context).focusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.053,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.005),
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.width * 0.15,
                        decoration: BoxDecoration(
                          boxShadow: ([
                            global.lightShadow,
                          ]),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        child: IconButton(
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: widget.add
                              ? () async {
                                  await Save.saveSet(
                                    Set(
                                      date: DateTime.now(),
                                      exerciseName: widget.exerciseName,
                                      reps: int.parse(repsController.text),
                                      weight: double.tryParse(
                                          weightController.text)!,
                                    ),
                                  );
                                  if (!widget.exerciseExists) {
                                    await Save.saveExercise(
                                      Exercise(
                                          name: widget.exerciseName,
                                          type: 'TEST',
                                          affectedMuscle: 'TEST',
                                          equipment: 'TEST'),
                                    );
                                  }
                                  Navigator.pop(context);
                                  setState(() {});
                                }
                              : () async {
                                  await Save.editSet(
                                    Set(
                                      s_id: widget.set!.s_id,
                                      date: widget.set!.date,
                                      exerciseName: widget.set!.exerciseName,
                                      reps: newReps,
                                      weight: newWeight,
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                          color: Theme.of(context).focusColor,
                          icon: const Icon(Icons.check),
                          iconSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.14,
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SetInput(
                    title: 'reps',
                    controller: repsController,
                    calcInterval: 1,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Container(
                    child: SetInput(
                      title: 'weight',
                      controller: weightController,
                      calcInterval: 2.5,
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
