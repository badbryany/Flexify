import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Exercise {
  Exercise({
    required this.name,
  });

  final String name;

  String toJsonString() {
    return jsonEncode({'name': name});
  }

  static Exercise fromStringtoObject(String string) {
    dynamic values = jsonDecode(string);
    return Exercise(
      name: values['name'],
    );
  }
}

class Set {
  Set({
    required this.setId,
    required this.exerciseName,
    required this.reps,
    required this.weight,
    required this.date,
  });

  final int setId;
  final String exerciseName;
  final int reps;
  final double weight;
  final DateTime date;

  String toJsonString() {
    return jsonEncode({
      'setId': setId,
      'exerciseName': exerciseName,
      'reps': reps,
      'weight': weight,
      'date': date.toString(),
    });
  }

  static Set fromStringToObject(String string) {
    dynamic values = jsonDecode(string);
    return Set(
      setId: values['setId'],
      exerciseName: values['exerciseName'],
      reps: values['reps'],
      weight: values['weight'],
      date: DateTime.parse(values['date']),
    );
  }

  static Future<int> getNewSetId() async {
    List<Set> sets = (await Save.setSetIfNull())
        .map((e) => Set.fromStringToObject(e))
        .toList();

    if (sets.isEmpty) {
      return 0;
    }
    return sets.last.setId + 1;
  }
}

class Save {
  static Future<List<String>> setExerciseIfNull() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('exercises') == null) {
      prefs.setStringList('exercises', []);
    }

    return prefs.getStringList('exercises')!;
  }

  static Future<List<String>> setSetIfNull() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('sets') == null) {
      prefs.setStringList('sets', []);
    }
    return prefs.getStringList('sets')!;
  }

  static Future<bool> safeExercise(Exercise exercise) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> exercises = await setExerciseIfNull();

    exercises.add(exercise.toJsonString());

    prefs.setStringList('exercises', exercises);
    return true;
  }

  static Future<bool> deleteExercise(Exercise exercise) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Set> sets = (await Save.setSetIfNull())
        .map((e) => Set.fromStringToObject(e))
        .toList();

    sets.removeWhere((element) => element.exerciseName == exercise.name);

    List<String> exercises = await setExerciseIfNull();

    exercises.remove(exercise.toJsonString());

    prefs.setStringList('exercises', exercises);
    prefs.setStringList('sets', sets.map((e) => e.toJsonString()).toList());
    return true;
  }

  static Future<bool> safeSet(Set set) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> sets = await setSetIfNull();

    sets.add(set.toJsonString());

    prefs.setStringList('sets', sets);
    return true;
  }

  static Future<bool> deleteSet(Set set) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> sets = await setSetIfNull();

    sets.remove(set.toJsonString());

    prefs.setStringList('sets', sets);
    return true;
  }

  static editSet(Set set) async {
    List<Set> sets = (await Save.setSetIfNull())
        .map((e) => Set.fromStringToObject(e))
        .toList();

    for (int i = 0; i < sets.length; i++) {
      if (sets[i].setId == set.setId) {
        sets[i] = set;
      }
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList('sets', sets.map((e) => e.toJsonString()).toList());
  }
}
