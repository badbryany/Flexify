import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class settingsPage extends StatelessWidget {
  settingsPage({super.key});

  List<String> sections = [
    "Theme",
    "Notifications",
    "Rate the app",
    "Send feedback",
    "Privacy policy",
    "Terms of use",
    "Website",
    "Logout"
  ];

  List<IconData> sectionIcons = [
    // Theme
    Icons.color_lens_outlined,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.037,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close_rounded,
                    size: MediaQuery.of(context).size.width * 0.06,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.11,
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
                  width: MediaQuery.of(context).size.width * 0.28,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              width: MediaQuery.of(context).size.width *
                  global.containerWidthFactor,
              height: MediaQuery.of(context).size.height * 0.4,
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
                  return Container(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1,
                        right: MediaQuery.of(context).size.width * 0.1),
                    height: MediaQuery.of(context).size.height * 0.05,
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
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03),
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        )
                      ],
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
