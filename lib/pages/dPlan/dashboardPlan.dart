import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/pages/dPlan/data/planData.dart' as planData;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardPlan extends StatefulWidget {
  const DashboardPlan({super.key});

  @override
  State<DashboardPlan> createState() => _DashboardPlanState();
}

class _DashboardPlanState extends State<DashboardPlan> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EquipmentWidget(
          hitboxMuscleGroups: planData.muscleGroupHitboxes.first,
        )
      ],
    );
  }
}

class EquipmentWidget extends StatefulWidget {
  final List<planData.MuscleGroup> hitboxMuscleGroups;

  const EquipmentWidget({super.key, required this.hitboxMuscleGroups});

  @override
  State<EquipmentWidget> createState() => _EquipmentWidgetState();
}

class _EquipmentWidgetState extends State<EquipmentWidget> {
  int selectedMuscleGroup = 0;
  int selectedSlot = 0;
  int state = 0;

  selectMuscleGroup(int muscleGroupIndex) {
    setState(() {
      selectedMuscleGroup = muscleGroupIndex;
      state++;
    });
  }

  selectSlot(int slotIndex) {
    setState(() {
      selectedSlot = slotIndex;
      state++;
    });
  }

  selectExercise(planData.MuscleGroup muscleGroup, planData.Exercise exercise,
      int slotIndex) {
    setState(() {
      muscleGroup.exerciseSlots[slotIndex] = exercise;
      state--;
    });
  }

  pop() {
    setState(() {
      state--;
    });
  }

  randomizeSlots() {
    planData.MuscleGroup muscleGroup =
        widget.hitboxMuscleGroups[selectedMuscleGroup];
    List<planData.Exercise> exercises = muscleGroup.availableExercises;

    for (var idx in [0, 1, 2, 3]) {
      muscleGroup.exerciseSlots[idx] =
          exercises[Random().nextInt(exercises.length)];
    }

    setState(
      () {},
    );
  }

  deleteSlot() {
    setState(
      () {
        widget.hitboxMuscleGroups[selectedMuscleGroup]
            .exerciseSlots[selectedSlot] = planData.Exercise(name: '');
        state--;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    navbarButton(bool backButton) => GestureDetector(
          onTap: () {
            backButton
                ? pop()
                : state == 1
                    ? randomizeSlots()
                    : deleteSlot();
          },
          child: SizedBox(
            child: Container(
              height: global.height(context) * .05,
              width: global.height(context) * .05,
              decoration: BoxDecoration(
                  gradient: global.linearGradient,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [global.darkShadow(context)]),
              child: Icon(
                backButton
                    ? Icons.arrow_back_rounded
                    : state == 1
                        ? Icons.replay
                        : CupertinoIcons.delete_simple,
                color: Colors.black,
                size: global.height(context) * .03,
              ),
            ),
          ),
        );

    Container equipmentNavbar = Container(
      padding: EdgeInsets.symmetric(
        horizontal: global.width(context) * .05,
      ),
      height: global.height(context) * .1,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          navbarButton(true),
          Text(
            state == 1
                ? widget.hitboxMuscleGroups[selectedMuscleGroup].name
                : 'Slot ${(selectedSlot + 1).toString()}',
            style: TextStyle(
              fontSize: global.height(context) * .0275,
              color: Colors.white,
            ),
          ),
          navbarButton(false)
        ],
      ),
    );

    return AnimatedContainer(
      duration: global.standardAnimationDuration,
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.bottomCenter,
      padding: state == 0
          ? EdgeInsets.symmetric(
              vertical: global.width(context) * .02,
              horizontal: global.width(context) * .025,
            )
          : const EdgeInsets.all(0),
      height: state == 0
          ? global.height(context) * (widget.hitboxMuscleGroups.length * .1)
          : state == 1
              ? global.height(context) * .45
              : global.height(context) * .6,
      width: state == 0
          ? global.width(context) * .6
          : global.height(context) * .35,
      decoration: global.boxDecoration(context),
      child: state == 0
          ? MuscleGroupSelection(
              hitboxMuscleGroups: widget.hitboxMuscleGroups,
              selectMuscleGroup: selectMuscleGroup,
            )
          : state == 1
              ? SlotSelection(
                  muscleGroup: widget.hitboxMuscleGroups[selectedMuscleGroup],
                  selectSlot: selectSlot,
                  navbar: equipmentNavbar,
                )
              : ExerciseSelection(
                  muscleGroup: widget.hitboxMuscleGroups[selectedMuscleGroup],
                  selectExercise: selectExercise,
                  navbar: equipmentNavbar,
                  slotIndex: selectedSlot,
                ),
    );
  }
}

class MuscleGroupSelection extends StatelessWidget {
  final Function selectMuscleGroup;
  final List<planData.MuscleGroup> hitboxMuscleGroups;

  const MuscleGroupSelection({
    super.key,
    required this.hitboxMuscleGroups,
    required this.selectMuscleGroup,
  });

  @override
  Widget build(BuildContext context) {
    Flexible title = Flexible(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            alignment: Alignment.center,
            child: global.gradient(
              Text(
                'Select',
                style: TextStyle(fontSize: global.width(context) * .06),
              ),
            ),
          ),
          Container(
            width: global.width(context) * .3,
            height: 1,
            color: Colors.white.withOpacity(.4),
          )
        ],
      ),
    );

    List<Flexible> muscleGroupTiles = hitboxMuscleGroups
        .mapIndexed(
          (index, muscleGroup) => Flexible(
            flex: 1,
            child: MuscleGroupTile(
              muscleGroup: muscleGroup,
              selectMuscleGroup: selectMuscleGroup,
              index: index,
            ),
          ),
        )
        .toList();

    muscleGroupTiles.insert(0, title);

    return Column(children: muscleGroupTiles);
  }
}

class MuscleGroupTile extends StatelessWidget {
  final planData.MuscleGroup muscleGroup;
  final Function selectMuscleGroup;
  final int index;

  const MuscleGroupTile({
    super.key,
    required this.muscleGroup,
    required this.selectMuscleGroup,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectMuscleGroup(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 4,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: global.width(context) * .05),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(.4)),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                muscleGroup.name,
                style: TextStyle(
                  fontSize: global.width(context) * .05,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
              width: global.width(context),
            ),
          ),
        ],
      ),
    );
  }
}

class SlotSelection extends StatelessWidget {
  final planData.MuscleGroup muscleGroup;
  final Function selectSlot;
  final Container navbar;

  const SlotSelection({
    super.key,
    required this.muscleGroup,
    required this.selectSlot,
    required this.navbar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        navbar,
        SizedBox(
          height: global.height(context) * .35,
          width: global.height(context) * .35,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return SlotTile(
                muscleGroup: muscleGroup,
                selectSlot: selectSlot,
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }
}

class SlotTile extends StatefulWidget {
  final planData.MuscleGroup muscleGroup;
  final Function selectSlot;
  final int index;

  const SlotTile({
    super.key,
    required this.muscleGroup,
    required this.selectSlot,
    required this.index,
  });

  @override
  State<SlotTile> createState() => _SlotTileState();
}

class _SlotTileState extends State<SlotTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.selectSlot(widget.index);
      },
      child: Padding(
        padding: widget.index % 2 == 0
            ? EdgeInsets.only(
                bottom: global.height(context) * .02,
                left: global.height(context) * .02,
                right: global.height(context) * .01,
              )
            : EdgeInsets.only(
                bottom: global.height(context) * .02,
                left: global.height(context) * .01,
                right: global.height(context) * .02,
              ),
        child: global.gradient(
          Container(
            padding: EdgeInsets.all(global.width(context) * .025),
            alignment: Alignment.center,
            height: global.height(context) * .2,
            width: global.height(context) * .2,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              widget.muscleGroup.exerciseSlots[widget.index].name,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
        ),
      ),
    );
  }
}

class ExerciseSelection extends StatelessWidget {
  final planData.MuscleGroup muscleGroup;
  final Function selectExercise;
  final Container navbar;
  final int slotIndex;

  const ExerciseSelection({
    super.key,
    required this.muscleGroup,
    required this.selectExercise,
    required this.navbar,
    required this.slotIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        navbar,
        SizedBox(
          height: global.height(context) * .5,
          width: global.height(context) * .35,
          child: ListView.builder(
            itemCount: muscleGroup.availableExercises.length,
            itemBuilder: (context, index) {
              return ExerciseTile(
                muscleGroup: muscleGroup,
                exercise: muscleGroup.availableExercises[index],
                selectExercise: selectExercise,
                slotIndex: slotIndex,
              );
            },
          ),
        ),
      ],
    );
  }
}

class ExerciseTile extends StatelessWidget {
  final planData.Exercise exercise;
  final planData.MuscleGroup muscleGroup;
  final Function selectExercise;
  final int slotIndex;

  const ExerciseTile({
    super.key,
    required this.exercise,
    required this.muscleGroup,
    required this.selectExercise,
    required this.slotIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectExercise(muscleGroup, exercise, slotIndex);
      },
      child: SizedBox(
        height: global.height(context) * .25,
        width: global.height(context) * .175,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(
                    height: global.height(context) * .075,
                    child: Container(
                      alignment: Alignment.center,
                      child: global.gradient(
                        Text(textAlign: TextAlign.center, exercise.name),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: global.height(context) * .175,
                    child: Container(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(
                    height: global.height(context) * .075,
                    child: Container(
                      alignment: Alignment.center,
                      child: global.gradient(
                        Text(textAlign: TextAlign.center, exercise.name),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: global.height(context) * .175,
                    child: Container(
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
