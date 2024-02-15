import 'package:flexify/SignInSignUp/choose.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class DashboardProfile extends StatefulWidget {
  const DashboardProfile({super.key});

  @override
  State<DashboardProfile> createState() => DashboardProfileState();
}

class DashboardProfileState extends State<DashboardProfile> {
  String username = '';
  String firstname = '';
  String surname = '';

  List<Map<String, dynamic>> data = [
    {
      'title': 'workouts',
      'count': 0,
    },
    {
      'title': 'average sets',
      'count': 0,
    },
    {
      'title': 'friends',
      'count': 0,
    },
  ];

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    username = prefs.getString('username')!;
    firstname = prefs.getString('firstname')!;
    surname = prefs.getString('surname')!;

    // workouts
    data[0]['count'] = 43;

    // average sets
    data[1]['count'] = 23;

    // friends
    data[2]['count'] = 7;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: global.height(context) * 0.025),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(global.borderRadius),
            boxShadow: [global.lightShadow(context)],
          ),
          width: global.width(context) * global.containerWidthFactor,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.network(
                  'https://pbs.twimg.com/media/FaUuKhkWYAA3u5c.jpg:large',
                  width: MediaQuery.of(context).size.height * 0.1,
                ),
              ),
              SizedBox(height: global.height(context) * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                      fontSize: global.width(context) * 0.06,
                    ),
                  ),
                  SizedBox(width: global.width(context) * 0.025),
                  SvgPicture.asset(
                    'assets/PR.svg',
                    width: global.width(context) * 0.075,
                  ),
                ],
              ),
              SizedBox(height: global.height(context) * 0.0125 / 2),
              Text(
                '$firstname $surname',
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.3),
                  fontWeight: FontWeight.bold,
                  fontSize: global.width(context) * 0.04,
                ),
              ),
              SizedBox(height: global.height(context) * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...data.map(
                    (e) => Column(
                      children: [
                        Text(
                          e['count'].toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.bold,
                            fontSize: global.width(context) * 0.05,
                          ),
                        ),
                        Text(
                          e['title'],
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.3),
                            // fontWeight: FontWeight.bold,
                            fontSize: global.width(context) * 0.035,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: global.height(context) * 0.0125),
            ],
          ),
        ),
        SizedBox(height: global.height(context) * 0.015),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // add friends
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(global.borderRadius - 10),
                boxShadow: [global.lightShadow(context)],
              ),
              width: global.width(context) * .7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'add friends',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                      fontSize: global.width(context) * 0.045,
                    ),
                  ),
                  Icon(Icons.add_rounded),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(global.borderRadius - 10),
                boxShadow: [global.lightShadow(context)],
              ),
              child: Icon(
                Icons.ios_share_rounded,
                size: global.width(context) * 0.05,
              ),
            ),
          ],
        ),
        SizedBox(height: global.height(context) * 0.1),
        GestureDetector(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            prefs.setString('username', '');
            prefs.setString('password', '');
            prefs.setString('jwt', '');
            Save.clearData();

            runApp(const MyApp(startWidget: Choose()));
          },
          child: Text(
            'logout',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold,
              fontSize: global.width(context) * 0.045,
            ),
          ),
        ),
      ],
    );
  }
}
