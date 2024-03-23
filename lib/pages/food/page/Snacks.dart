import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class Snacks extends StatefulWidget {
  const Snacks({
    super.key,
    required this.meal,
  });
  final List<Map<String, dynamic>> meal;

  @override
  State<Snacks> createState() => _SnacksState();
}

class _SnacksState extends State<Snacks> {
  TextEditingController newMeal = TextEditingController();
  Color borderColorBreakfast = Colors.transparent;
  Color borderColorLunch = Colors.transparent;
  Color borderColorDinner = Colors.transparent;
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    DateTime mealTime = DateTime(now.hour);
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
                        'Snacks',
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
                          if (newMeal.text != '') {
                            widget.meal.add(
                              {
                                'meal': mealTime
                                    .toString()
                                    .replaceAll('00:00:00.000', '')
                                    .replaceAll('-01', ''),
                                'meal.list': newMeal.text,
                              },
                            );
                            Navigator.pop(context);
                          }
                          print(
                            mealTime.toString().replaceAll('00:00:00.000', ''),
                          );
                          setState(() {});
                          ;
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
            ],
          ),
        ),
      ),
    );
  }
}
