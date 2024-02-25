import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flexify/pages/food/page/addMeal.dart';
import 'package:flexify/pages/food/widget/button.dart';

class DashboardFood extends StatefulWidget {
  const DashboardFood({super.key});

  @override
  State<DashboardFood> createState() => DashboardFoodState();
}

class DashboardFoodState extends State<DashboardFood> {
  double maxCalories = 2000;
  double eatenCalories = 2000;

  List<Map<String, dynamic>> meals = [];

  @override
  Widget build(BuildContext context) {
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
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                        left: containerPadding * 0.5,
                        top: containerPadding,
                      ),
                      child: Text(
                        'Your Meales Today:',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      height: MediaQuery.of(context).size.height * 0.06,
                      alignment: Alignment.bottomRight,
                      child: ButtonWithIcon(
                        icon: const Icon(Icons.add),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: AddMeal(meals: meals,),
                              type: PageTransitionType.fade,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                ...meals.map(
                  (e) => Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          left: containerPadding * 0.5,
                          top: containerPadding * 0.5,
                        ),
                        child: Text(
                          e['meal'],
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder(
                          itemCount: e['meal.list'].length,
                          itemBuilder: (context, index) => Text(
                            e['meal.list'][index],
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
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
    );
  }
}
