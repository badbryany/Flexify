import 'package:flexify/pages/food/meal/dinner.dart';
import 'package:flexify/pages/food/meal/lunch.dart';
import 'package:flutter/material.dart';
import 'package:flexify/pages/food/widget/background.dart';
import 'package:flexify/data/globalVariables.dart';
import 'package:flexify/pages/food/meal/breakfast.dart';

class DashboardFood extends StatefulWidget {
  const DashboardFood({super.key});

  @override
  State<DashboardFood> createState() => DashboardFoodState();
}

class DashboardFoodState extends State<DashboardFood> {
  Widget? refresh;
  int pagecounter = 1;
  final controller = PageController(initialPage: 1);

  List<Map<String, dynamic>> dailyPlan = [
    {
      'meal': 'Breakfast',
      'calories': 0.0,
      'foodEaten': [],
    },
    {
      'meal': 'Lunch',
      'calories': 0.0,
      'foodEaten': [],
    },
    {
      'meal': 'Dinner',
      'calories': 0.0,
      'foodEaten': [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    controller.addListener(
      () {
        if (controller.page == 0) {
          refresh = const Breakfast();
        }
        if (controller.page == 1) {
          refresh = const Lunch();
        }
        if (controller.page == 2) {
          refresh = const Dinner();
        }
        setState(() {});
      },
    );

    return Container(
      padding: EdgeInsets.all(containerPadding),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Background(
            child: Center(
              child: Text(
                'Daily Plan:',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: containerPadding),
            width: MediaQuery.of(context).size.width - containerPadding * 2,
            height: MediaQuery.of(context).size.height * 0.1,
            child: PageView(
              controller: controller,
              children: dailyPlan.map((e) {
                return Background(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          e['meal'],
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'calories: ',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            Text(
                              e['calories'].toString(),
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          AnimatedSwitcher(
            duration: standardAnimationDuration,
            child: refresh,
          )
        ],
      ),
    );
  }
}
