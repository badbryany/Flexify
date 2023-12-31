import 'package:flexify/data/exerciseModels.dart';

import 'package:flexify/data/AnalyseWorkoutData/WorkoutDay.dart';

String zero(int a) {
  if (a < 10) {
    return '0$a';
  }
  return '$a';
}

List<WorkoutDay> analyseWorkout(List<Set> setList) {
  List<WorkoutDay> workoutDays = [];

  List<String> exercises = [];

  if (setList.isEmpty) {
    return [];
  }

  DateTime lastDate = setList[0].date;

  for (int i = 0; i < setList.length; i++) {
    if (setList[i].date.difference(lastDate) <
        const Duration(
          hours: 1,
          minutes: 30,
        )) {
      exercises.add(setList[i].exerciseName);
      if (i != setList.length - 1) continue;
    }
    workoutDays.add(
      WorkoutDay(id: workoutDays.length + 1, exercises: exercises),
    );
    exercises = [];
    exercises.add(setList[i].exerciseName);

    lastDate = setList[i].date;
  }

  List<WorkoutDay> workoutDaysFinal = [];

  for (int i = 0; i < workoutDays.length; i++) {
    bool contains = false;
    for (int j = 0; j < workoutDaysFinal.length; j++) {
      if (workoutDays[i].match(workoutDaysFinal[j])) contains = true;
    }
    if (!contains) workoutDaysFinal.add(workoutDays[i]);
  }

  return workoutDaysFinal;
}

List<dynamic> getAverageWorkoutString(
  WorkoutDay workoutDay,
  List<Set> setList,
) {
  List<dynamic> workoutString = [];

  if (workoutDay.exercises.isEmpty) {
    return [];
  }

  String exerciseName = workoutDay.exercises[0];
  int setCount = 0;

  for (int j = 0; j < workoutDay.exercises.length; j++) {
    if (workoutDay.exercises[j] == exerciseName) {
      setCount++;
    } else {
      workoutString.add({
        'exerciseName': exerciseName,
        'setCount': setCount,
        'reps': null,
      });
      exerciseName = workoutDay.exercises[j];
      setCount = 1;
    }
    if (j == workoutDay.exercises.length - 1) {
      workoutString.add({
        'exerciseName': exerciseName,
        'setCount': setCount,
        'reps': null,
      });
    }
  }
  return workoutString;
}
