import 'package:flexify/widgets/SetInput.dart';
import 'package:flutter/material.dart';
import 'package:flexify/widgets/Button.dart';
import '../../../../../data/exerciseModels.dart';

class AddSet extends StatefulWidget {
  const AddSet({
    super.key,
    required this.exerciseName,
  });

  final String exerciseName;

  @override
  State<AddSet> createState() => _AddSetState();
}

class _AddSetState extends State<AddSet> {
  final TextEditingController repsController = TextEditingController(
    text: '10',
  );
  final TextEditingController weightController = TextEditingController(
    text: '10',
  );

  getData() async {
    List<String> stringSets = await Save.setSetIfNull();
    List<Set> sets = stringSets.map((e) => Set.fromStringToObject(e)).toList();

    for (int i = 0; i < sets.length; i++) {
      if (sets[i].exerciseName == widget.exerciseName) {
        repsController.text = sets[i].reps.toString();
        weightController.text = sets[i].weight.toString();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
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
                height: MediaQuery.of(context).size.height * (1 - 0.82),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 15,
                      left: -30,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Theme.of(context).focusColor,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Add set',
                        style: TextStyle(
                          color: Theme.of(context).focusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ],
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
                  SetInput(
                    title: 'weight',
                    controller: weightController,
                    calcInterval: 2.5,
                  ),
                  Button(
                    text: 'save',
                    filled: true,
                    borderRadius: 40,
                    onPressed: () async {
                      await Save.safeSet(
                        Set(
                          setId: await Set.getNewSetId(),
                          date: DateTime.now(),
                          exerciseName: widget.exerciseName,
                          reps: int.parse(repsController.text),
                          weight: double.tryParse(weightController.text)!,
                        ),
                      );

                      Navigator.pop(context);
                    },
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
