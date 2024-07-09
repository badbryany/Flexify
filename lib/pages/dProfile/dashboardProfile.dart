import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/pages/dProfile/widgets/ShareWithFriends.dart';
import 'package:flexify/pages/dProfile/widgets/UserInfo.dart';
import 'package:flexify/pages/dProfile/widgets/UserStats.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardProfile extends StatefulWidget {
  const DashboardProfile({super.key});

  @override
  State<DashboardProfile> createState() => _DashboardProfileState();
}

class _DashboardProfileState extends State<DashboardProfile> {
  String username = '';

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username')!;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        global.mediumHeight(context),
        const UserInfo(),
        global.largeHeight(context),
        global.mediumHeight(context),
        const UserStats(),
        global.largeHeight(context),
        ShareWithFriends(
          username: username,
        ),
        global.largeHeight(context),
      ],
    );
  }
}
