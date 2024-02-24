import 'package:flexify/pages/food/widgets/Macros.dart';
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

    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MacrosWidget(),
          ],
        ),
      ],
    );
  }
}
