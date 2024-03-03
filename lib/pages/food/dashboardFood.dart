import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flexify/pages/food/page/Meal.dart';

class DashboardFood extends StatefulWidget {
  const DashboardFood({super.key});

  @override
  State<DashboardFood> createState() => DashboardFoodState();
}

class DashboardFoodState extends State<DashboardFood> {
  double maxCalories = 2000;
  double eatenCalories = 1000;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> meal = [
      {
        'meal': 'Breakfast',
        'direction': const Meal(
          title: 'Breakfast',
          meal: [],
        ),
      },
      {
        'meal': 'Lunch',
        'direction': const Meal(
          title: 'Lunch',
          meal: [],
        ),
      },
      {
        'meal': 'Dinner',
        'direction': const Meal(
          title: 'Dinner',
          meal: [],
        ),
      },
      {
        'meal': 'Snacks',
        'direction': const Meal(
          title: 'Snacks',
          meal: [],
        ),
      },
    ];
    double leftCalories = eatenCalories / maxCalories;
    Color progressColor = Theme.of(context).colorScheme.primary;

    if (leftCalories > 1.0) {
      leftCalories = 1.0;
      progressColor = Theme.of(context).colorScheme.error;
    }

    return Container(
      padding: EdgeInsets.only(top: containerPadding),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: containerPadding,
              bottom: containerPadding,
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: [global.lightShadow(context)]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
// HEADING
                Padding(
                  padding: EdgeInsets.only(bottom: containerPadding),
                  child: Text(
                    'Today',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
// PROGRESS CIRCLE
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(right: containerPadding * 0.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Eaten Calories: ',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            Text(
                              eatenCalories.toString(),
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: CircularPercentIndicator(
                          radius: 40,
                          lineWidth: 6,
                          backgroundColor: Theme.of(context).canvasColor,
                          percent: leftCalories,
                          progressColor: progressColor,
                          circularStrokeCap: CircularStrokeCap.round,
                          animation: true,
                          center: Text(
                            '${leftCalories * 100}%',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: containerPadding * 0.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Max Calories: ',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            Text(
                              maxCalories.toString(),
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
// MEAL LIST
          Column(
            children: [
              ...meal.map(
                (e) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: e['direction'],
                        type: PageTransitionType.fade,
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    margin: EdgeInsets.only(top: containerPadding * 0.5),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding:
                              EdgeInsets.only(left: containerPadding * 0.5),
                          child: Text(
                            e['meal'],
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width * 0.67,
                          child: const Icon(Icons.arrow_forward_rounded),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
