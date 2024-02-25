import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class MacrosWidget extends StatefulWidget {
  const MacrosWidget({super.key});

  @override
  State<MacrosWidget> createState() => _MacrosWidgetState();
}

class _MacrosWidgetState extends State<MacrosWidget> {
  int averageKcal = 2500;
  int targetKcal = 3000;
  List<List<dynamic>> macroPercentages = [
    ['Proteins', 80],
    ['Fats', 23],
    ['Carbs', 62],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 + MediaQuery.of(context).size.width * 0.3,
      width: MediaQuery.of(context).size.width * global.containerWidthFactor,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [global.darkShadow(context)]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: 3,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Avg. Calories",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: MediaQuery.of(context).size.width * 0.05 +
                                MediaQuery.of(context).size.height * 0.005),
                      ),
                      Text(
                        "${averageKcal}kcal / ${targetKcal}kcal",
                        style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: MediaQuery.of(context).size.width * 0.03 +
                                MediaQuery.of(context).size.height * 0.01),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.battery_charging_full_outlined,
                size: MediaQuery.of(context).size.width * 0.1,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...macroPercentages.map(
                (e) {
                  return Row(
                    children: [
                      MacroTile(
                        macro: e[0],
                        percentage: e[1],
                      ),
                    ],
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class MacroTile extends StatelessWidget {
  final String macro;
  final int percentage;

  const MacroTile({super.key, required this.macro, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.width * 0.2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(1000),
          border: Border.all(
              width: 1, color: Theme.of(context).colorScheme.primary),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      macro,
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: MediaQuery.of(context).size.width * 0.022,
                      ),
                    ),
                    Text(
                      '${percentage.toString()}%',
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: MediaQuery.of(context).size.width * 0.022,
                      ),
                    ),
                  ],
                ),
                Transform.scale(
                  scale: MediaQuery.of(context).size.width * 0.004,
                  child: CircularProgressIndicator(
                    value: percentage / 100,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
