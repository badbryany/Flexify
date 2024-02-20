import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:percent_indicator/circular_percent_indicator.dart';

class DashboardFood extends StatefulWidget {
  const DashboardFood({super.key});

  @override
  State<DashboardFood> createState() => DashboardFoodState();
}

class DashboardFoodState extends State<DashboardFood> {
  double maxCalories = 2000;
  double eatenCalories = 200;

  @override
  Widget build(BuildContext context) {
    double leftCalories = eatenCalories / maxCalories;
    Color progressColor = Theme.of(context).colorScheme.primary;

    if (leftCalories > 1.0) {
      leftCalories = 1.0;
      progressColor = Theme.of(context).colorScheme.error;
    }

    return Container(
      padding: EdgeInsets.all(containerPadding),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        padding: EdgeInsets.only(top: containerPadding),
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
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        Text(
                          eatenCalories.toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: CircularPercentIndicator(
                      radius: 25,
                      lineWidth: 3,
                      backgroundColor: Theme.of(context).canvasColor,
                      percent: leftCalories,
                      progressColor: progressColor,
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                      center: Text(
                        '${maxCalories.toInt() - eatenCalories.toInt()}',
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
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        Text(
                          maxCalories.toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
