import 'dart:io';

import 'package:flexify/pages/profile/widgets/AddFriends.dart';
import 'package:flexify/pages/profile/widgets/PersonalElement.dart';
import 'package:flexify/pages/profile/widgets/QRShow.dart';
import 'package:flexify/pages/profile/widgets/Sets.dart';
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
        Container(
          margin: EdgeInsets.only(top: global.height(context) * .01),
          width: global.width(context) * global.containerWidthFactor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                    padding:
                        EdgeInsets.only(right: global.height(context) * .005),
                    height: global.height(context) * .075,
                    width: global.width(context) * .55,
                    decoration: BoxDecoration(
                      boxShadow: [global.lightShadow(context)],
                      color: Theme.of(context).colorScheme.background,
                      borderRadius:
                          BorderRadius.circular(global.borderRadius - 10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_add_rounded,
                          color: Theme.of(context).colorScheme.onBackground,
                          size: global.width(context) * .08,
                        ),
                        SizedBox(
                          width: global.width(context) * .04,
                        ),
                        Text(
                          "Add Friends",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: global.width(context) * .05,
                              letterSpacing: -.2),
                        ),
                        SizedBox(
                          width: global.width(context) * .03,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: global.width(context) * .02,
              ),
              BounceElement(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    PageTransition(
                      child: const QRShow(),
                      type: PageTransitionType.rightToLeft,
                    ),
                  ),
                  child: Container(
                    height: global.height(context) * .075,
                    width: global.width(context) * .18,
                    decoration: BoxDecoration(
                      boxShadow: [global.lightShadow(context)],
                      color: Theme.of(context).colorScheme.background,
                      borderRadius:
                          BorderRadius.circular(global.borderRadius - 10),
                    ),
                    child: Icon(
                      Icons.qr_code_2_rounded,
                      color: Colors.white,
                      size: global.width(context) * .08,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: global.width(context) * .02,
              ),
              const ShareButton(),
            ],
          ),
        ),
        SizedBox(
          height: global.height(context) * .01,
        ),
        const SetsWidget(),
      ],
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BounceElement(
      child: GestureDetector(
        child: Container(
          height: global.height(context) * .075,
          width: global.width(context) * .18,
          decoration: BoxDecoration(
            boxShadow: global.isDarkMode(context)
                ? [global.darkShadow(context)]
                : [global.lightShadow(context)],
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(global.borderRadius - 10),
          ),
          child: Platform.isAndroid
              ? Icon(
                  Icons.share,
                  size: global.width(context) * .08,
                  color: Theme.of(context).colorScheme.onBackground,
                )
              : Icon(
                  Icons.ios_share_rounded,
                  color: Theme.of(context).colorScheme.onBackground,
                  size: global.width(context) * .08,
                ),
        ),
      ),
    );
  }
}
