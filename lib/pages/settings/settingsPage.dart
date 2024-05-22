import 'package:flexify/SignInSignUp/signIn.dart';
import 'package:flexify/pages/settings/widgets/biometricPage.dart';
import 'package:flexify/pages/settings/widgets/feedbackPage.dart';
import 'package:flexify/pages/settings/widgets/notificationsPage.dart';
import 'package:flexify/pages/settings/widgets/privacyPage.dart';
import 'package:flexify/pages/settings/widgets/ratingPage.dart';
import 'package:flexify/pages/settings/widgets/termsPage.dart';
import 'package:flexify/pages/settings/widgets/LightDarkSwitch.dart';
import 'package:flexify/pages/settings/widgets/websitePage.dart';
import 'package:flexify/widgets/DeleteAlertDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final List<String> sections = [
    "Biometrics",
    "Notifications",
    "Rate the app",
    "Send feedback",
    "Privacy policy",
    "Terms of use",
    "Website",
    "Logout"
  ];

  final List<IconData> sectionIcons = [
    // Personal Data
    CupertinoIcons.heart,
    // Notifacitons
    Icons.notifications_active_outlined,
    // Rate
    Icons.star_border_rounded,
    // Feedback
    Icons.chat,
    // Privacy policy
    CupertinoIcons.lock,
    // Terms of use
    Icons.list_alt_outlined,
    // Website
    CupertinoIcons.globe,
    // Logout
    Icons.logout_rounded
  ];

  final List<Widget> sectionPages = [
    const BiometricPage(),
    const NotificationsPage(),
    const RatingPage(),
    const FeedbackPage(),
    const PrivacyPage(),
    const TermsPage(),
    const WebsitePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: global.height(context) * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(global.width(context) * 0.005),
                  width: global.width(context) * 0.14,
                  height: global.width(context) * 0.14,
                  decoration: BoxDecoration(
                    boxShadow: ([global.darkShadow(context)]),
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: IconButton(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Theme.of(context).colorScheme.onBackground,
                    icon: const Icon(Icons.close_rounded),
                    iconSize: global.width(context) * 0.05,
                  ),
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                    fontSize: global.width(context) * .08,
                  ),
                ),
                const LightDarkSwitch(),
              ],
            ),
            SizedBox(
              height: global.height(context) * 0.03,
            ),
            Container(
              width: global.width(context) * global.containerWidthFactor,
              height: global.height(context) * 0.8,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(global.borderRadius),
              ),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (index == 7) {
                        showDialog(
                          context: context,
                          builder: (context) => DeleteAlertDialog(
                            title: 'Sure to log off?',
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  prefs.setString('username', '');
                                  prefs.setString('password', '');

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PopScope(
                                        canPop: false,
                                        child: SignIn(),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Logout'),
                              ),
                            ],
                          ),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        PageTransition(
                          child: sectionPages[index],
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: global.width(context) * 0.1,
                      ),
                      height: global.height(context) * 0.1,
                      width:
                          global.width(context) * global.containerWidthFactor,
                      decoration: BoxDecoration(
                          border: index != 7
                              ? Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                )
                              : Border.all(width: 0, color: Colors.transparent),
                          color: Colors.transparent),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            sectionIcons[index],
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          Text(
                            sections[index],
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: global.width(context) * 0.05,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Theme.of(context).colorScheme.onBackground,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
