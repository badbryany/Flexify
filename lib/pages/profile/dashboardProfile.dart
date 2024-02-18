import 'package:flexify/SignInSignUp/choose.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/main.dart';
import 'package:flexify/pages/createTrainingPlan/createTrainingPage.dart';
import 'package:flexify/pages/profile/profilePage/mainProfilePage.dart';
import 'package:flexify/pages/profile/widgets/GetPremium.dart';
import 'package:flexify/pages/profile/widgets/PersonalElement.dart';
import 'package:flexify/widgets/DeleteAlertBox.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class DashboardProfile extends StatefulWidget {
  const DashboardProfile({super.key});

  @override
  State<DashboardProfile> createState() => DashboardProfileState();
}

class DashboardProfileState extends State<DashboardProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: global.height(context) * 0.025),
        //
        const PersonalElement(),
        //
        SizedBox(height: global.height(context) * 0.015),
        //
        SizedBox(
          width: global.width(context) * global.containerWidthFactor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // add friends
              ...[
                {
                  'title': 'invite friends',
                  'icon': null,
                },
                {
                  'title': 'add friends',
                  'icon': null,
                },
                {
                  'title': null,
                  'icon': Icon(
                    Icons.notifications_rounded,
                    size: global.width(context) * 0.06,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                },
              ].map(
                (e) => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: global.width(context) * .065,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius:
                        BorderRadius.circular(global.borderRadius - 10),
                    boxShadow: [global.darkShadow(context)],
                  ),
                  child: e['title'] != null
                      ? Text(
                          e['title'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: global.width(context) * 0.04,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        )
                      : e['icon'] as Widget,
                ),
              ),
            ],
          ),
        ),
        //
        SizedBox(height: global.height(context) * .04),
        //
        const GetPremium(),
        //
        SizedBox(height: global.height(context) * .04),
        //
        SizedBox(
          width: global.width(context) * global.containerWidthFactor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...[
                {
                  'title': 'rate app',
                  'onTap': () {},
                },
                {
                  'title': 'share app',
                  'onTap': () {},
                },
                {
                  'title': 'logout',
                  'onTap': () async {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) => DeleteAlertDialog(
                        title: 'Are you sure to logout?',
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);

                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('username', '');
                              prefs.setString('password', '');
                              prefs.setString('jwt', '');
                              Save.clearData();

                              runApp(const MyApp(startWidget: Choose()));
                            },
                            child: const Text('logout'),
                          ),
                        ],
                      ),
                    );
                  },
                },
              ].map(
                (e) => GestureDetector(
                  onTap: e['onTap'] as void Function(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius:
                          BorderRadius.circular(global.borderRadius - 15),
                      boxShadow: [global.lightShadow(context)],
                    ),
                    child: Text(
                      e['title'] as String,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                        fontSize: global.width(context) * 0.04,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: global.height(context) * .04),
      ],
    );
  }
}
