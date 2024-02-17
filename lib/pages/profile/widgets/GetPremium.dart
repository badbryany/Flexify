import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class GetPremium extends StatefulWidget {
  const GetPremium({super.key});

  @override
  State<GetPremium> createState() => _GetPremiumState();
}

class _GetPremiumState extends State<GetPremium> {
  getData() async {}

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return BounceElement(
      child: Container(
        padding: EdgeInsets.all(global.containerPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(global.borderRadius),
          boxShadow: [global.darkShadow(context)],
          border: Border.all(color: Theme.of(context).colorScheme.primary),
        ),
        width: global.width(context) * global.containerWidthFactor,
        child: Column(
          children: [
            Text(
              'Get Premium',
              style: TextStyle(
                color: global.gold,
                fontWeight: FontWeight.bold,
                fontSize: global.width(context) * 0.06,
              ),
            ),
            SizedBox(height: global.height(context) * .0125),
            ...[
              'advanced statistics',
              'personal training plan optimaization',
              'personal meal plan',
              'unlimited friends',
            ].map(
              (e) => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.75),
                    size: global.width(context) * 0.04,
                  ),
                  SizedBox(width: global.width(context) * 0.025),
                  Text(
                    e,
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.75),
                      fontSize: global.width(context) * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: global.height(context) * .025),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(global.borderRadius - 10),
                color: Theme.of(context).colorScheme.background,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.onPrimary,
                  ],
                ),
              ),
              child: Text(
                'GO PREMIUM',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: global.width(context) * 0.04,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
