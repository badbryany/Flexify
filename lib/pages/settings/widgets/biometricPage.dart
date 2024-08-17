import 'package:flexify/pages/dShop/pages/widgets/ShopNavbar.dart';
import 'package:flexify/pages/intro/10_split.dart';
import 'package:flexify/pages/intro/11_targetMuscles.dart';
import 'package:flexify/pages/intro/12_location.dart';
import 'package:flexify/pages/intro/13_equipment.dart';
import 'package:flexify/pages/intro/14_targetWeight.dart';
import 'package:flexify/pages/intro/2_gender.dart';
import 'package:flexify/pages/intro/3_height.dart';
import 'package:flexify/pages/intro/4_weight.dart';
import 'package:flexify/pages/intro/5_bodyfat.dart';
import 'package:flexify/pages/intro/6_birthday.dart';
import 'package:flexify/pages/intro/7_experience.dart';
import 'package:flexify/pages/intro/8_schedule.dart';
import 'package:flexify/pages/intro/9_duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class BiometricPage extends StatefulWidget {
  const BiometricPage({super.key});

  @override
  State<BiometricPage> createState() => _BiometricPageState();
}

class _BiometricPageState extends State<BiometricPage> {
  List<String> sections = [
    "Gender",
    "Height",
    "Weight",
    "Bodyfat Percentage",
    "Birthday",
    "Experience",
    "Schedule",
    "Duration",
    "Split",
    "Target Muscles",
    "Location",
    "Equipment",
    "Weight Goal"
  ];

  List<IconData> sectionIcons = [
    // Gender
    CupertinoIcons.person_2_fill,
    // Height
    Icons.height_rounded,
    // Weight
    Icons.accessibility_new_rounded,
    // Bodyfat Percentage
    CupertinoIcons.percent,
    // Birthday
    Icons.cake_outlined,
    // Experience
    Icons.call_split_rounded,
    // Schedule
    Icons.calendar_month_outlined,
    // Duration
    CupertinoIcons.hourglass,
    // Split
    CupertinoIcons.chart_pie,
    // Target Muscles
    Icons.fact_check_outlined,
    // Location
    CupertinoIcons.house_fill,
    // Equipment
    CupertinoIcons.hammer,
    // Weight Goal
    Icons.blender_outlined
  ];

  List<Widget> sectionPages = [
    const TwoGender(
      isSettings: true,
    ),
    const ThreeHeight(
      isSettings: true,
    ),
    const FourWeight(
      isSettings: true,
    ),
    const FiveBodyFat(
      isFemale: true,
      isSettings: true,
    ),
    const SixBirthday(
      isSettings: true,
    ),
    const SevenExperience(
      isSettings: true,
    ),
    const EightSchedule(
      isSettings: true,
    ),
    const NineDuration(
      isSettings: true,
    ),
    const TenSplit(
      isSettings: true,
    ),
    const ElevenTargetMuscles(
      isSettings: true,
    ),
    const TwelveLocation(
      isSettings: true,
    ),
    const ThirteenEquipment(
      isSettings: true,
    ),
    const FourteenTargetWeight(
      isSettings: true,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const ShopNavbar(
              title: 'Biometrics',
            ),
            SizedBox(
              height: global.height(context) * 0.8,
              width: global.width(context) * global.containerWidthFactor,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 13,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (index != 13) {
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
                        left: global.width(context) * 0.1,
                        right: global.width(context) * 0.1,
                      ),
                      height: global.height(context) * 0.1,
                      width:
                          global.width(context) * global.containerWidthFactor,
                      decoration: BoxDecoration(
                        borderRadius: index == 0
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              )
                            : index == 12
                                ? const BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  )
                                : BorderRadius.circular(0),
                        border: index != 13
                            ? Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                              )
                            : Border.all(width: 0, color: Colors.transparent),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            sectionIcons[index],
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          Text(
                            sections[index],
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: global.width(context) * 0.05),
                          ),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Theme.of(context).colorScheme.onBackground,
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
