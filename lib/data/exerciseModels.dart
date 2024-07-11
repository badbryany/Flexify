import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Exercise {
  Exercise({
    required this.name,
    required this.type,
    required this.affectedMuscle,
    required this.equipment,
    this.synced,
  });

  String name;
  String type;
  String affectedMuscle;
  String equipment;
  int? synced;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'affectedMuscle': affectedMuscle,
      'equipment': equipment,
      'synced': synced == null ? 0 : synced!,
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

  @override
  String toString() {
    return '''
      \n\tname: "$name"
      \ttype: "$type"
      \taffectedMuscle: "$affectedMuscle"
      \tequipment: "$equipment"
    ''';
  }
}

class Set {
  Set({
    this.setID,
    required this.exerciseName,
    required this.reps,
    required this.weight,
    required this.date,
    required this.isBodyweight,
    this.durationInSeconds,
    this.synced,
  });

  final int? setID;
  final String exerciseName;
  final int reps;
  final double weight;
  final DateTime date;
  final bool isBodyweight;
  final int? durationInSeconds;
  int? synced;

  Map<String, dynamic> toJson() {
    return {
      's_id': setID,
      'exerciseName': exerciseName,
      'reps': reps,
      'weight': weight,
      'date': date.toString(),
      'duration': durationInSeconds ?? 0,
      'isBodyweight': isBodyweight ? 1 : 0,
      'synced': synced == null ? 0 : synced!,
    };
  }

  static Set fromJSONtoObject(Map<String, dynamic> values) {
    return Set(
      setID: values['s_id'],
      exerciseName: values['exerciseName'],
      reps: values['reps'],
      weight: values['weight'].toDouble(),
      isBodyweight: values['isBodyWeight'] == 1 ? true : false,
      durationInSeconds: values['duration'],
      date: DateTime.parse(values['date']),
    );
  }

  @override
  String toString() {
    return '''
      \n\ts_id: "$setID"
      \texerciseName: "$exerciseName"
      \treps: "$reps"
      \tweight: "$weight"
      \tduration: "$durationInSeconds"
      \tisBodyweight: "$isBodyweight"
      \tdate: "$date"
    ''';
  }

  getDuration() {
    return Duration(seconds: durationInSeconds ?? 0);
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
          'CREATE TABLE IF NOT EXISTS "sets" ("s_id"	INTEGER NOT NULL, "exerciseName" TEXT NOT NULL, "reps" INTEGER NOT NULL, "weight" NUMERIC NOT NULL, "date" DATE NOT NULL, "duration" INTEGER, "isBodyWeight" INTEGER NOT NULL, "synced" INTEGER NOT NULL, PRIMARY KEY("s_id"));',
        );
      },
    );
  }

  static Future<List<Exercise>> getExerciseList() async {
    Database db = await getDatabase();
    List<Map<String, Object?>> exercises =
        await db.rawQuery('SELECT * FROM exercises WHERE synced!=-1;');

    return exercises.map((e) => Exercise.fromJSONtoObject(e)).toList();
  }

  static Future<List<Set>> getSetList() async {
    Database db = await getDatabase();
    List<Map<String, Object?>> sets =
        await db.rawQuery('SELECT * FROM sets WHERE synced!=-1;'); // TODO

    return sets.map((e) => Set.fromJSONtoObject(e)).toList();
  }

  static Future<void> saveExercise(Exercise exercise) async {
    Database db = await getDatabase();
    await db.insert('exercises', exercise.toJson(),
        conflictAlgorithm: ConflictAlgorithm.rollback);
    Save.syncData();
  }

  static Future<void> deleteExercise(Exercise exercise) async {
    Database db = await getDatabase();

    await db.rawQuery(
      'UPDATE exercises SET synced=-1 WHERE name="${exercise.name}";',
    );
    await db.rawUpdate(
      'UPDATE sets SET synced=-1 WHERE sets.exerciseName="${exercise.name}";',
    );

    http.post(
      Uri.parse('${global.host}/deleteExercise'),
      body: {
        'jwt': (await SharedPreferences.getInstance()).getString('jwt'),
        'title': exercise.name,
      },
    ).then((res) async {
      if (res.body == 'done') {
        await db.rawDelete(
          'DELETE FROM sets WHERE sets.exerciseName="${exercise.name}";',
        );
        await db.rawDelete(
          'DELETE FROM exercises WHERE exercises.name="${exercise.name}";',
        );
      }
    });
  }

  static Future<void> editExerciseName(String oldName, String newName) async {
    Database db = await getDatabase();

    await db.rawUpdate(
      'UPDATE exercises SET name="$newName", synced=0 WHERE name="$oldName"',
    );

    await db.rawUpdate(
      'UPDATE sets SET exerciseName="$newName" WHERE sets.exerciseName="$oldName"',
    );
    Save.syncData();
  }

  static Future<int> newSetId() async {
    Database db = await getDatabase();
    List<Map<String, Object?>> sets = await db.rawQuery('SELECT * FROM sets;');
    if (sets.isEmpty) {
      return 0;
    }
    return (sets.last['s_id'] as int) + 1;
  }

  static Future<void> saveSet(Set set, int? sId) async {
    Database db = await getDatabase();
    Set newSet = Set(
      setID: sId ?? await Save.newSetId(),
      exerciseName: set.exerciseName,
      reps: set.reps,
      weight: set.weight,
      date: set.date,
      isBodyweight: set.isBodyweight,
      durationInSeconds: set.durationInSeconds,
      synced: set.synced,
    );

    await db.insert('sets', newSet.toJson());
    Save.syncData();
  }

  static Future<void> deleteSet(Set set) async {
    Database db = await getDatabase();
    await db.rawUpdate(
      'UPDATE sets SET synced=-1 WHERE sets.s_id="${set.setID}";',
    );

    http.post(
      Uri.parse('${global.host}/deleteSet'),
      body: {
        'jwt': (await SharedPreferences.getInstance()).getString('jwt'),
        's_id': set.setID.toString(),
      },
    ).then((res) async {
      if (res.body == 'done') {
        await db.rawDelete(
          'DELETE FROM sets WHERE sets.s_id=${set.setID}',
        );
      }
    });
  }

  static Future<void> editSet(Set set) async {
    Database db = await getDatabase();

    await db.rawUpdate(
      'UPDATE sets SET reps=${set.reps}, weight=${set.weight}, duration=${set.durationInSeconds}, isBodyWeight=${set.isBodyweight ? 1 : 0}, synced=0 WHERE sets.s_id=${set.setID}',
    );
    Save.syncData();
  }

  static Future<bool> syncData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Database db = await getDatabase();

    String url = '${global.host}/submitExercise';

    List<Map<String, Object?>> exercises =
        await db.rawQuery('SELECT * FROM exercises WHERE synced=0;');

    for (int i = 0; i < exercises.length; i++) {
      final http.Response res = await http.post(
        Uri.parse(url),
        body: {
          'jwt': prefs.getString('jwt'),
          'title': exercises[i]['name'],
          'type': exercises[i]['type'],
          'affectedMuscle': exercises[i]['affectedMuscle'],
          'equipment': exercises[i]['equipment'],
        },
      );

      if (res.body != 'done') {
        return false;
      }
      await db.rawUpdate(
        'UPDATE exercises SET synced=1 WHERE name=\'${exercises[i]['name']}\'',
      );
    }

    url = '${global.host}/submitSet';
    List<Map<String, Object?>> sets =
        await db.rawQuery('SELECT * FROM sets WHERE synced=0;');

    for (int i = 0; i < sets.length; i++) {
      final http.Response res = await http.post(
        Uri.parse(url),
        body: {
          'jwt': prefs.getString('jwt'),
          's_id': sets[i]['s_id'].toString(),
          'exerciseName': sets[i]['exerciseName'],
          'reps': sets[i]['reps'].toString(),
          'weight': sets[i]['weight'].toString(),
          'date': sets[i]['date'],
        },
      );
      if (res.body != 'done') {
        return false;
      }
      await db.rawUpdate(
        'UPDATE sets SET synced=1 WHERE s_id=${sets[i]['s_id']};',
      );
    }

    // delete old sets and exercises
    url = '${global.host}/deleteSet';
    sets = await db.rawQuery('SELECT * FROM sets WHERE synced=-1;');
    for (int i = 0; i < sets.length; i++) {
      final http.Response res = await http.post(
        Uri.parse(url),
        body: {
          'jwt': prefs.getString('jwt'),
          's_id': sets[i]['s_id'].toString(),
        },
      );

      if (res.body != 'done') {
        return false;
      }
      await db.rawUpdate(
        'DELETE FROM sets WHERE s_id=${sets[i]['s_id']};',
      );
    }

    url = '${global.host}/deleteExercise';
    exercises = await db.rawQuery('SELECT * FROM exercises WHERE synced=-1;');
    for (int i = 0; i < exercises.length; i++) {
      final http.Response res = await http.post(
        Uri.parse(url),
        body: {
          'jwt': prefs.getString('jwt'),
          'title': exercises[i]['name'],
        },
      );

      if (res.body != 'done') {
        return false;
      }
      await db.rawUpdate(
        'DELETE FROM exercises WHERE name="${exercises[i]['name']}";',
      );
    }
    return true;
  }

  static Future<void> clearData() async {
    Database db = await getDatabase();
    await db.execute('DROP TABLE IF EXISTS exercises;');
    await db.execute('DROP TABLE IF EXISTS sets;');
  }
}
