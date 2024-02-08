import 'package:flexify/data/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProfilPage extends StatefulWidget {
  const MainProfilPage({super.key});

  @override
  State<MainProfilPage> createState() => _MainProfilPageState();
}

class _MainProfilPageState extends State<MainProfilPage> {
  String? username;
  String? password;
  String? firstName;
  String? surname;
  String? emailAddress;

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username');
    password = prefs.getString('password');
    firstName = prefs.getString('firstName');
    surname = prefs.getString('surname');
    emailAddress = prefs.getString('emailAddress');
  }

  @override
  Widget build(BuildContext context) {
    getUserData();

    List<Map<String, dynamic>> userData = [
      {
        'label': 'username:',
        'data': username,
      },
      {
        'label': 'password:',
        'data': password,
      },
      {
        'label': 'first name:',
        'data': firstName,
      },
      {
        'label': 'surname:',
        'data': surname,
      },
      {
        'label': 'email:',
        'data': emailAddress,
      },
    ];

    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  alignment: const Alignment(0, -0.8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(borderRadius * 5)),
                      child: Icon(
                        Icons.person,
                        size: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: const Alignment(0.45, -0.8),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.edit),
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...userData.map(
                      (e) => Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03,
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                ),
                                child: Text(
                                  '${e['label']}',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03,
                              right: MediaQuery.of(context).size.width * 0.03,
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.71,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                ),
                                child: Text(
                                  '${e['data']}',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
