import 'package:flutter/material.dart';
import 'package:flexify/widgets/Button.dart';
import 'package:flexify/pages/workout/workoutPage/setPage/SetInput.dart';
import '../../../../../data/exerciseModels.dart';

class EditSet extends StatefulWidget {
  const EditSet({
    super.key,
    required this.set,
  });

  final Set set;

  @override
  State<EditSet> createState() => _EditSetState();
}

class _EditSetState extends State<EditSet> {
  final TextEditingController repsController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  int newReps = 0;
  double newWeight = 0;

  @override
  void initState() {
    newReps = widget.set.reps;
    newWeight = widget.set.weight;
    repsController.text = widget.set.reps.toString();
    weightController.text = widget.set.weight.toString();

    repsController.addListener(() {
      newReps = int.parse(repsController.text);
    });
    weightController.addListener(() {
      newWeight = double.tryParse(weightController.text)!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    Text(
                      'Edit Set',
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SetInput(
            title: 'reps',
            controller: repsController,
            calcInterval: 1,
          ),
          SetInput(
            title: 'weight',
            controller: weightController,
            calcInterval: 2.5,
          ),
          Button(
            text: 'save',
            filled: true,
            onPressed: () async {
              await Save.editSet(
                Set(
                  setId: widget.set.setId,
                  date: widget.set.date,
                  exerciseName: widget.set.exerciseName,
                  reps: newReps,
                  weight: newWeight,
                ),
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
