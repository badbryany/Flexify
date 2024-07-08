import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/pages/dProfile/widgets/UserInfo.dart';
import 'package:flexify/pages/dProfile/widgets/UserStats.dart';
import 'package:flutter/material.dart';

class DashboardProfile extends StatefulWidget {
  const DashboardProfile({super.key});

  @override
  State<DashboardProfile> createState() => _DashboardProfileState();
}

class _DashboardProfileState extends State<DashboardProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const UserInfo(),
        global.largeHeight(context),
        global.mediumHeight(context),
        const UserStats(),
        global.largeHeight(context),
      ],
    );
  }
}
