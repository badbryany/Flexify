import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Exercise {
  Exercise({
    required this.name,
    required this.type,
    required this.affectedMuscle,
    required this.equipment,
  });

  final String name;
  final String type;
  final String affectedMuscle;
  final String equipment;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'affectedMuscle': affectedMuscle,
      'equipment': equipment,
      'synced': 0,
    };
  }

  static Exercise fromJSONtoObject(Map<String, dynamic> values) {
    return Exercise(
      name: values['name'],
      type: values['type'],
      affectedMuscle: values['affectedMuscle'],
      equipment: values['equipment'],
    );
  }
}

class Set {
  Set({
    this.setID,
    required this.exerciseName,
    required this.reps,
    required this.weight,
    required this.date,
  });

  final int? setID;
  final String exerciseName;
  final int reps;
  final double weight;
  final DateTime date;

  Map<String, dynamic> toJson() {
    return {
      'exerciseName': exerciseName,
      'reps': reps,
      'weight': weight,
      'date': date.toString(),
      'synced': 0,
    };
  }

  static Set fromJSONtoObject(Map<String, dynamic> values) {
    return Set(
      setID: values['s_id'],
      exerciseName: values['exerciseName'],
      reps: values['reps'],
      weight: values['weight'].toDouble(),
      date: DateTime.parse(values['date']),
    );
  }
}

class Save {
  static Future<Database> getDatabase() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();

    final String path = join(documentsDirectory.path, 'flexify.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS "exercises" ("name"	TEXT NOT NULL, "type" TEXT, "affectedMuscle" TEXT, "equipment" TEXT, "synced" INTEGER NOT NULL, PRIMARY KEY("name"));',
        );
        await db.execute(
          'CREATE TABLE IF NOT EXISTS "sets" ("s_id"	INTEGER NOT NULL, "exerciseName" TEXT NOT NULL, "reps" INTEGER NOT NULL, "weight" NUMERIC NOT NULL, "date" DATE NOT NULL, "synced" INTEGER NOT NULL, PRIMARY KEY("s_id" AUTOINCREMENT));',
        );
      },
    );
  }

  static Future<List<Exercise>> getExerciseList() async {
    Database db = await getDatabase();
    List<Map<String, Object?>> exercises =
        await db.rawQuery('SELECT * FROM exercises;');

    return exercises.map((e) => Exercise.fromJSONtoObject(e)).toList();
  }

  static Future<List<Set>> getSetList() async {
    Database db = await getDatabase();
    List<Map<String, Object?>> sets =
        await db.rawQuery('SELECT * FROM sets;'); // TODO

    return sets.map((e) => Set.fromJSONtoObject(e)).toList();
  }

  static Future<void> saveExercise(Exercise exercise) async {
    Database db = await getDatabase();
    await db.insert('exercises', exercise.toJson(),
        conflictAlgorithm: ConflictAlgorithm.rollback);
  }

  static Future<void> deleteExercise(Exercise exercise) async {
    Database db = await getDatabase();

    await db.rawDelete(
      'DELETE FROM sets WHERE sets.exerciseName="${exercise.name}"',
    );
    await db.rawDelete(
      'DELETE FROM exercises WHERE exercises.name="${exercise.name}"',
    );
  }

  static Future<void> saveSet(Set set) async {
    Database db = await getDatabase();

    await db.insert('sets', set.toJson());
  }

  static Future<void> deleteSet(Set set) async {
    Database db = await getDatabase();
    await db.rawDelete(
      'DELETE FROM sets WHERE sets.setID=${set.setID}',
    );
  }

  static Future<void> editSet(Set set) async {
    Database db = await getDatabase();

    await db.rawUpdate(
      'UPDATE sets SET reps=${set.reps}, weight=${set.weight} WHERE sets.setID=${set.setID}',
    );
  }
}
