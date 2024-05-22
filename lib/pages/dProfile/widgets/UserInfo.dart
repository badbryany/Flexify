import 'package:flexify/pages/dProfile/pages/QRShow.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(
        top: global.height(context) * .05,
        bottom: global.height(context) * .02,
        left: global.width(context) * .03,
        right: global.width(context) * .03,
      ),
      height: global.height(context) * .25,
      width: global.width(context) * global.containerWidthFactor,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(30),
          boxShadow: global.isDarkMode(context)
              ? [global.darkShadow(context)]
              : [global.lightShadow(context)]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: global.height(context) * .045,
              ),
              Container(
                height: global.height(context) * .1,
                width: global.height(context) * .1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [global.lightShadow(context)],
                ),
              ),
              SizedBox(
                width: global.width(context) * .055,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nickname',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: global.height(context) * .04,
                      letterSpacing: -1,
                    ),
                  ),
                  global.gradient(
                    Text(
                      '@username',
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.9),
                        fontSize: global.height(context) * .025,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: global.height(context) * .005,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              UserInfoButton(
                icon: Icons.person_add_rounded,
                // onTap: () => Navigator.push(
                //   context,
                //   PageTransition(
                //     child: const AddFriends(),
                //     type: PageTransitionType.rightToLeft,
                //   ),
                // ),
                onTap: () {
                  // Issue1#TODO:
                  // Need Server || Read The Code Oskar has writeen
                },
              ),
              SizedBox(
                width: global.width(context) * .025,
              ),
              UserInfoButton(
                icon: Icons.qr_code_2_rounded,
                onTap: () => Navigator.push(
                  context,
                  PageTransition(
                    child: const QRShow(),
                    type: PageTransitionType.rightToLeft,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserInfoButton extends StatelessWidget {
  final IconData icon;
  final Function() onTap;

  const UserInfoButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BounceElement(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: global.height(context) * .05,
          width: global.width(context) *
              ((global.containerWidthFactor / 2) - 0.045),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 26, 26, 29),
              boxShadow: global.shadow(context),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white.withOpacity(.9),
                size: global.width(context) * .08,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
