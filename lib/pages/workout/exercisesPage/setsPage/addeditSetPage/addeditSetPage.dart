import 'package:flexify/widgets/SetInput.dart';
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
                        boxShadow: ([
                          global.lightShadow(context),
                        ]),
                        color: Theme.of(context).focusColor,
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
                        boxShadow: ([
                          global.lightShadow(context),
                        ]),
                        color: Theme.of(context).focusColor,
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
                                reps: int.parse(repsController.text),
                                weight: double.tryParse(weightController.text)!,
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
                        color: Theme.of(context).focusColor,
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
                  SetInput(
                    title: 'reps',
                    controller: repsController,
                    calcInterval: 1,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  SetInput(
                    title: 'weight',
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
