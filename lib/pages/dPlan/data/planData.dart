class MuscleGroup {
  final String name;
  final List<Exercise> exerciseSlots;
  final List<Exercise> availableExercises;

  MuscleGroup({
    required this.name,
    required this.exerciseSlots,
    required this.availableExercises,
  });
}

class Exercise {
  String name;

  Exercise({
    required this.name,
  });
}

Exercise nullExercise = Exercise(name: '');

List<Exercise> dummyExercises = [
  Exercise(name: "Bicep Curl"),
  Exercise(name: "Tricep Curl"),
  Exercise(name: "Chest Press your Girlfriend"),
  Exercise(name: "Banged your mum"),
  Exercise(name: "Fucked your grandma"),
  Exercise(name: "Toe sucks - 10 reps"),
];

// Map<String, List<MuscleGroup>> muscleGroups = [
//   Auxilary
//   "Frontal Neck",
//   "Lateral Neck",
//   "Trapezius",
//   "Deltoids",

//   // Upper
//   "Chest",
//   "Triceps",
//   "Biceps",
//   "Forearms",
//   "Rhomboids",
//   "Latissimus",

//   // Core
//   "Lower Back",
//   "Abdominals",
//   "Obliques",

//   // Legs
//   "Glutes",
//   "Quadriceps",
//   "Hamstrings",
//   "Calves",
//   "HipAbductors",
//   "HipAdductors",
// ];

List<MuscleGroup> neckAndShoulders = [
  MuscleGroup(
    name: "Trapeziues",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Frontal Neck",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Lateral Neck",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
];

List<MuscleGroup> upperTorsoFrontal = [
  MuscleGroup(
    name: "Frontal Neck",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Lateral Neck",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Trapezius",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Chest",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
];

List<MuscleGroup> upperTorsoAnterior = [
  MuscleGroup(
    name: "Rhomboids",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Latissimus",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
];

List<MuscleGroup> push = [
  MuscleGroup(
    name: "Chest",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Triceps",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
];

List<MuscleGroup> arms = [
  MuscleGroup(
    name: "Deltoids",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Triceps",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Biceps",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Forearms",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
];

List<MuscleGroup> pull = [
  MuscleGroup(
    name: "Rhomboids",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Latissimus",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Biceps",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Forearms",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
];

List<MuscleGroup> lowerTorsoFrontal = [
  MuscleGroup(
    name: "Abdominals",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Obliques",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
];

List<MuscleGroup> lowerTorsoAnterior = [
  MuscleGroup(
    name: "Lower Back",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Obliques",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
];

List<MuscleGroup> legsFrontal = [
  MuscleGroup(
    name: "Quadriceps",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Hip Abductors",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Hip Adductors",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
];

List<MuscleGroup> legsAnterior = [
  MuscleGroup(
    name: "Glutes",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Hamstrings",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Hip Abductors",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Hip Adductors",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
  MuscleGroup(
    name: "Calves",
    exerciseSlots: List.of(
        [nullExercise, nullExercise, nullExercise, nullExercise],
        growable: false),
    availableExercises: dummyExercises,
  ),
];

List<List<MuscleGroup>> upper = [neckAndShoulders, push, pull];

List<List<MuscleGroup>> lower = [
  lowerTorsoFrontal,
  lowerTorsoAnterior,
  legsFrontal,
  legsAnterior
];

List<List<MuscleGroup>> muscleGroupHitboxes = [
  upperTorsoFrontal,
  upperTorsoAnterior,
  arms,
  lowerTorsoFrontal,
  lowerTorsoAnterior,
  legsFrontal,
  legsAnterior,
];
