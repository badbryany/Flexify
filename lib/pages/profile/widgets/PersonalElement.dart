import 'dart:convert';

import 'package:flexify/data/exerciseModels.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PersonalElement extends StatefulWidget {
  const PersonalElement({super.key});

  @override
  State<PersonalElement> createState() => _PersonalElementState();
}

class _PersonalElementState extends State<PersonalElement> {
  int workouts = -1;
  int friends = -1;
  int streak = -1;

  bool isPremium = true;

  DateTime joinDate = DateTime.now();

  String username = '...';

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    username = prefs.getString('username')!;
    workouts = 0;
    List<Set> sets = await Save.getSetList();
    if (sets.isNotEmpty) {
      workouts++;
    }
    for (var i = 0; i < sets.length - 1; i++) {
      if (sets[i + 1].date.difference(sets[i].date) >
          const Duration(hours: 5)) {
        workouts++;
      }
    }
    setState(() {});

    http.Response res = await http.get(
      Uri.parse('${global.host}/getFriends?jwt=${prefs.getString('jwt')}'),
    );

    if (res.body == 'bad request' || res.body == 'jwt not valid') {
      await Future.delayed(const Duration(seconds: 10), getData);
      return;
    }

    friends = jsonDecode(res.body).length;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  String numToShortString(int num) {
    if (num > 1000000) {
      return '${(num / 1000000).round()}M';
    }
    if (num > 999) {
      return '${(num / 1000).round()}k';
    }
    return '$num';
  }

  String dateString(DateTime date) {
    String month = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ][date.month - 1];

    return '$month ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(global.containerPadding - 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(global.borderRadius),
        boxShadow: [global.darkShadow(context)],
      ),
      width: global.width(context) * global.containerWidthFactor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.network(
                  'https://pbs.twimg.com/media/FaUuKhkWYAA3u5c.jpg',
                  width: MediaQuery.of(context).size.height * 0.075,
                ),
              ),
              SizedBox(width: global.width(context) * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // USERNAME
                  Row(
                    children: [
                      Text(
                        username,
                        style: TextStyle(
                          color: isPremium
                              ? global.gold
                              : Theme.of(context).colorScheme.onBackground,
                          fontSize: global.width(context) * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: global.width(context) * 0.01),
                      Visibility(
                        visible: isPremium,
                        child: SvgPicture.asset(
                          'assets/PR.svg',
                          width: global.width(context) * 0.06,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'since ${dateString(joinDate)}',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.5),
                      fontSize: global.width(context) * 0.04,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // SMALL ITEMS
          Column(
            children: [
              ...[
                [workouts, 'workouts'],
                [friends, 'friends'],
                [streak, 'streak']
              ].map((e) => Column(
                    children: [
                      Text(
                        e[0] == -1
                            ? '--'
                            : (e[1] == 'streak' ? '🔥' : '') +
                                numToShortString(e[0] as int),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: global.width(context) * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        e[1].toString(),
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(.3),
                          fontSize: global.width(context) * 0.03,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
