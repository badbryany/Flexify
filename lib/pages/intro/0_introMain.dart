import 'package:flexify/pages/intro/10_split.dart';
import 'package:flexify/pages/intro/11_targetMuscles.dart';
import 'package:flexify/pages/intro/12_location.dart';
import 'package:flexify/pages/intro/13_equipment.dart';
import 'package:flexify/pages/intro/14_targetWeight.dart';
import 'package:flexify/pages/intro/1_welcome.dart';
import 'package:flexify/pages/intro/2_gender.dart';
import 'package:flexify/pages/intro/3_height.dart';
import 'package:flexify/pages/intro/4_weight.dart';
import 'package:flexify/pages/intro/5_bodyfat.dart';
import 'package:flexify/pages/intro/6_birthday.dart';
import 'package:flexify/pages/intro/7_experience.dart';
import 'package:flexify/pages/intro/8_schedule.dart';
import 'package:flexify/pages/intro/9_duration.dart';
import 'package:flutter/material.dart';

class ZeroIntro extends StatefulWidget {
  const ZeroIntro({super.key});

  @override
  State<ZeroIntro> createState() => ZeroIntroState();
}

class ZeroIntroState extends State<ZeroIntro> {
  int i = 0;

  List<Widget> pages = [
    OneWelcome(),
    TwoGender(),
    ThreeHeight(),
    FourWeight(),
    FiveBodyFat(),
    SixBirthday(),
    SevenExperience(),
    EightSchedule(),
    NineDuration(),
    TenSplit(),
    ElevenTargetMuscles(),
    TwelveLocation(),
    ThirteenEquipment(),
    FourteenTargetWeight()
  ];

  @override
  Widget build(BuildContext context) {
    return pages[1];
  }
}
