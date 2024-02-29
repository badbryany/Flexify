import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/pages/food/widget/button.dart';
import 'package:flexify/pages/food/widget/input.dart';

class AddMeal extends StatefulWidget {
  const AddMeal({
    super.key,
    required this.meal,
  });
  final List<Map<String, dynamic>> meal;

  @override
  State<AddMeal> createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  TextEditingController newMeal = TextEditingController();
  Color borderColorBreakfast = Colors.transparent;
  Color borderColorLunch = Colors.transparent;
  Color borderColorDinner = Colors.transparent;
  String mealTimeString = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> mealTime = [
      {
        'meal.time': 'Breakfast',
        'border.color': borderColorBreakfast,
      },
      {
        'meal.time': 'Lunch',
        'border.color': borderColorLunch,
      },
      {
        'meal.time': 'Dinner',
        'border.color': borderColorDinner,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * (1 - 0.88),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.005),
                      width: MediaQuery.of(context).size.width * 0.14,
                      height: MediaQuery.of(context).size.width * 0.14,
                      decoration: BoxDecoration(
                        boxShadow: ([global.darkShadow(context)]),
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Theme.of(context).colorScheme.onBackground,
                        icon: const Icon(Icons.arrow_back_rounded),
                        iconSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.13,
                        right: MediaQuery.of(context).size.width * 0.13,
                        top: 10,
                      ),
                      child: Text(
                        'Add Meal',
                        style: TextStyle(
                          color: Theme.of(context).focusColor,
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
// BACK BUTTON
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.005),
                      width: MediaQuery.of(context).size.width * 0.14,
                      height: MediaQuery.of(context).size.width * 0.14,
                      decoration: BoxDecoration(
                        boxShadow: ([global.darkShadow(context)]),
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (newMeal.text != '' && mealTimeString != '') {
                            widget.meal.add(
                              {
                                'meal': mealTimeString,
                                'meal.list': newMeal.text,
                              },
                            );
                            Navigator.pop(context);
                          }
                          setState(() {});
                        },
                        color: Theme.of(context).colorScheme.onBackground,
                        icon: const Icon(Icons.check_rounded),
                        iconSize: MediaQuery.of(context).size.width * 0.065,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
// BODY
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
// MAP MEAL TIME
                      ...mealTime.map(
                        (e) => ButtonWithText(
                          text: e['meal.time'],
                          borderColor: e['border.color'],
                          onTap: () {
                            if (e['meal.time'] == 'Breakfast') {
                              borderColorBreakfast =
                                  Theme.of(context).colorScheme.primary;
                              borderColorLunch = Colors.transparent;
                              borderColorDinner = Colors.transparent;
                              mealTimeString = 'Breakfast';
                            }
                            if (e['meal.time'] == 'Lunch') {
                              borderColorBreakfast = Colors.transparent;
                              borderColorLunch =
                                  Theme.of(context).colorScheme.primary;
                              borderColorDinner = Colors.transparent;
                              mealTimeString = 'Lunch';
                            }
                            if (e['meal.time'] == 'Dinner') {
                              borderColorBreakfast = Colors.transparent;
                              borderColorLunch = Colors.transparent;
                              borderColorDinner =
                                  Theme.of(context).colorScheme.primary;
                              mealTimeString = 'Dinner';
                            }
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
// SEARCH BAR
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Input(
                      hintText: 'Search For New Meal',
                      textInputType: TextInputType.text,
                      controller: newMeal,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
