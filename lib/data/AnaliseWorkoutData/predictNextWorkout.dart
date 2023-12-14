import 'package:flexify/data/AnaliseWorkoutData/WorkoutDay.dart';
import 'package:flexify/data/AnaliseWorkoutData/analyseWorkoutData.dart';
import 'package:flexify/data/exerciseModels.dart';

WorkoutDay predictNextWorkout(List<WorkoutDay> workoutDays, List<Set> sets) {
  // parameter workoutDays should be in correct order

  // get last WorkoutDay
  int lastWorkoutDayIndex = workoutDays.length - 1;

  for (int i = 0; i < workoutDays.length; i++) {
    if (workoutDays[i].hasMatchingExercise(sets.last.exerciseName)) {
      lastWorkoutDayIndex = i;
    }
  }

  return workoutDays[(lastWorkoutDayIndex + 1) % workoutDays.length];
}
