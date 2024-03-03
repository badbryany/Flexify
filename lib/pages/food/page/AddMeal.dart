import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart';
import 'package:flexify/widgets/SearchBar.dart';
import 'package:flutter_svg/svg.dart';

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
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(containerPadding),
              alignment: Alignment.center,
              child: AnimSearchBar(
                color: Theme.of(context).colorScheme.background,
                textColor: Theme.of(context).colorScheme.onBackground,
                hintTextColor: Theme.of(context).colorScheme.onBackground,
                onSuffixTap: () {
                  controller.clear();
                  Navigator.pop(context);
                },
                onToggle: (int open) {},
                suffixIcon: Icon(
                  Icons.clear,
                  color: Theme.of(context).focusColor,
                ),
                closeSearchOnSuffixTap: true,
                open: true,
                textController: controller,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            ...(widget.meal.map(
              (e) => Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.1,
                    ),
                    child: SvgPicture.asset(
                      'assets/Squiggly Arrow.svg',
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.6,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Click  \'+\'  to add an exercise!  :)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
