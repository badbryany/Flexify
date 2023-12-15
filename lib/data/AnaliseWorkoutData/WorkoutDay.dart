class WorkoutDay {
  WorkoutDay({
    required this.id,
    required this.exercises,
  });

  final int id;
  final List<String> exercises;

  List<String> _cleanExercises(List<String> exerciseList) {
    List<String> tmp = [];
    for (int i = 0; i < exerciseList.length; i++) {
      if (!tmp.contains(exerciseList[i])) {
        tmp.add(exerciseList[i]);
      }
    }
    return tmp;
  }

  bool match(WorkoutDay workoutDay) {
    List<String> thisCleanExercises = _cleanExercises(exercises);
    List<String> cleanExercises = _cleanExercises(workoutDay.exercises);

    if (cleanExercises.length != thisCleanExercises.length) return false;

    int commonExercises = 0;
    for (int i = 0; i < cleanExercises.length; i++) {
      for (int j = 0; j < thisCleanExercises.length; j++) {
        if (cleanExercises[i] == thisCleanExercises[j]) commonExercises++;
      }
    }

    // commonExercises and thisCleanExercises have the same length otherwise it would have returned false
    if ((commonExercises - thisCleanExercises.length).abs() >= 2) return false;

    return true;
  }

  bool hasMatchingExercise(String exerciseName) {
    for (int i = 0; i < exercises.length; i++) {
      if (exercises[i] == exerciseName) return true;
    }
    return false;
  }
}
