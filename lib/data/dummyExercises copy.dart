import 'package:flexify/data/exerciseModels.dart';
import 'dart:convert';
import 'dart:io';

var exercises = File('/Users/yugashi/Desktop/Flexify/lib/data/exercises.json');
var contents = exercises.readAsStringSync();

List<Exercise> gymExercises = jsonDecode(contents)
    .map((json) => Exercise.fromJSONtoObject(json))
    .toList();
