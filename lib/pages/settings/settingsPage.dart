import 'package:collection/collection.dart';
import 'package:flexify/SignInSignUp/signIn.dart';
import 'package:flexify/pages/dProfile/pages/EditProfile.dart';
import 'package:flexify/pages/settings/widgets/biometricPage.dart';

import 'package:flexify/pages/settings/widgets/notificationsPage.dart';
import 'package:flexify/pages/settings/widgets/privacyPage.dart';
import 'package:flexify/pages/settings/widgets/termsPage.dart';
import 'package:flexify/pages/settings/widgets/LightDarkSwitch.dart';
import 'package:flexify/widgets/DeleteAlertDialog.dart';
import 'package:flexify/widgets/Navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  logout(BuildContext context) async {
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
              SharedPreferences prefs = await SharedPreferences.getInstance();

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
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> sections = [
      {
        'title': 'Personal Data',
        'icon': CupertinoIcons.heart,
        'link': const BiometricPage(),
      },
      {
        'title': 'Edit Profile',
        'icon': Icons.edit,
        'link': const EditProfile(),
      },
      {
        'title': 'Notifications',
        'icon': Icons.notifications_active_outlined,
        'link': const NotificationsPage(),
      },
      {
        'title': 'Privacy policy',
        'icon': CupertinoIcons.lock,
        'link': PrivacyPage(),
      },
      {
        'title': 'Terms of use',
        'icon': Icons.list_alt_outlined,
        'link': TermsPage(),
      },
      {
        'title': 'Website',
        'icon': CupertinoIcons.globe,
        'onTap': () async => launchUrl(
              Uri.parse('https://flexify.kellermann.team'),
              mode: LaunchMode.externalApplication,
            ),
      },
      {
        'title': 'Logout',
        'icon': Icons.logout_rounded,
        'onTap': () => logout(context),
      },
    ];

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Navbar(
              title: 'Settings',
              titleSize: global.width(context) * .075,
              topRightWidget: const LightDarkSwitch(),
            ),
            Center(
              child: Container(
                width: global.containerWidth(context),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(global.borderRadius),
                ),
                child: Column(
                  children: [
                    ...sections.mapIndexed(
                      (index, e) => GestureDetector(
                        onTap: () => e['link'] != null
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => e['link'],
                                ))
                            : e['onTap'](),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: global.width(context) * 0.1,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: index != sections.length - 1
                                  ? BorderSide(
                                      width: 1,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(.25),
                                    )
                                  : BorderSide(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                            ),
                          ),
                          height: global.height(context) * 0.1,
                          width: global.width(context) *
                              global.containerWidthFactor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                e['icon'],
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                              Text(
                                e['title'],
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: global.width(context) * 0.05,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
