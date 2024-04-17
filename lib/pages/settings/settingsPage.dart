import 'package:flexify/pages/settings/widgets/biometricPage.dart';
import 'package:flexify/pages/settings/widgets/feedbackPage.dart';
import 'package:flexify/pages/settings/widgets/notificationsPage.dart';
import 'package:flexify/pages/settings/widgets/privacyPage.dart';
import 'package:flexify/pages/settings/widgets/ratingPage.dart';
import 'package:flexify/pages/settings/widgets/termsPage.dart';
import 'package:flexify/pages/settings/widgets/LightDarkSwitch.dart';
import 'package:flexify/pages/settings/widgets/websitePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

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
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.11,
                ),
                IconButton(
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    size: MediaQuery.of(context).size.width * 0.06,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.17,
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                    fontSize: global.width(context) * 0.07,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.13,
                ),
                const LightDarkSwitch(),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              width: MediaQuery.of(context).size.width *
                  global.containerWidthFactor,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                border:
                    Border.all(width: 1, color: Theme.of(context).focusColor),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (index != 7) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => sectionPages[index],
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1,
                        right: MediaQuery.of(context).size.width * 0.1,
                      ),
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width *
                          global.containerWidthFactor,
                      decoration: BoxDecoration(
                          border: index != 7
                              ? Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                )
                              : Border.all(width: 0, color: Colors.transparent),
                          color: Colors.transparent),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            sectionIcons[index],
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          Text(
                            sections[index],
                            style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Theme.of(context).scaffoldBackgroundColor,
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
