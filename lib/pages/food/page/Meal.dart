import 'package:flexify/pages/food/page/AddMeal.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:page_transition/page_transition.dart';

class Meal extends StatefulWidget {
  const Meal({
    super.key,
    required this.title,
    required this.meal,
  });
  final String title;
  final List<Map<String, dynamic>> meal;

  @override
  State<Meal> createState() => _MealState();
}

class _MealState extends State<Meal> {
  TextEditingController newMeal = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        'Add ${widget.title}',
                        style: TextStyle(
                          color: Theme.of(context).focusColor,
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
// ADD BUTTON
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
                          Navigator.of(context).push(
                            PageTransition(
                              child: AddMeal(
                                meal: widget.meal,
                              ),
                              type: PageTransitionType.fade,
                            ),
                          );
                        },
                        color: Theme.of(context).colorScheme.onBackground,
                        icon: const Icon(Icons.add),
                        iconSize: MediaQuery.of(context).size.width * 0.065,
                      ),
                    ),
                  ],
                ),
              ),
// BODY
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ...widget.meal.map(
                (e) => Container(
                  padding: EdgeInsets.all(containerPadding * 0.5),
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Text(e['meal']),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
