import 'package:flutter/material.dart';
import 'package:flexify/widgets/Button.dart';
import 'package:flexify/pages/workout/workoutPage/setPage/InputField.dart';
import '../../../../data/exerciseModels.dart';

class AddExercise extends StatelessWidget {
  AddExercise({
    super.key,
    required this.refresh,
  });
  final Function refresh;

  final TextEditingController exerciseNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
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
                      left: 0,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Add exercise',
                        style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
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
                  InputField(
                    controller: exerciseNameController,
                    labelText: 'Name of the exercise',
                  ),
                  Button(
                    text: 'save',
                    filled: true,
                    borderRadius: 40,
                    onPressed: () async {
                      await Save.saveExercise(
                        Exercise(name: exerciseNameController.text),
                      );
                      await refresh();
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
