import 'dart:io';

import 'package:flexify/pages/profile/widgets/AddFriends.dart';
import 'package:flexify/pages/profile/widgets/PersonalElement.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class DashboardProfile extends StatefulWidget {
  const DashboardProfile({super.key});

  @override
  State<DashboardProfile> createState() => _DashboardProfileState();
}

class _DashboardProfileState extends State<DashboardProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PersonalElement(),

        // ADD FRIENDS LINK
        Container(
          margin: EdgeInsets.only(top: global.height(context) * .03),
          width: global.width(context) * global.containerWidthFactor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BounceElement(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    PageTransition(
                      child: const AddFriends(),
                      type: PageTransitionType.rightToLeft,
                    ),
                  ),
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      width: global.width(context) * .68,
                      decoration: BoxDecoration(
                        boxShadow: [global.lightShadow(context)],
                        color: Theme.of(context).colorScheme.background,
                        borderRadius:
                            BorderRadius.circular(global.borderRadius - 10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(Icons.person_add_rounded),
                          Text(
                            'add friends',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: global.width(context) * .045,
                            ),
                          ),
                        ],
                      )),
                ),
              ),

              // SHARE BUTTON
              BounceElement(
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      boxShadow: [global.lightShadow(context)],
                      color: Theme.of(context).colorScheme.background,
                      borderRadius:
                          BorderRadius.circular(global.borderRadius - 10),
                    ),
                    child: Platform.isAndroid
                        ? Icon(
                            Icons.share,
                            size: global.width(context) * .05,
                          )
                        : const Icon(Icons.ios_share_rounded),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
