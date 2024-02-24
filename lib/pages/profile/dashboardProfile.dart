import 'package:flexify/pages/food/widgets/Macros.dart';
import 'package:flexify/pages/workout/workoutStatsPage/widgets/Sets.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardProfile extends StatefulWidget {
  const DashboardProfile({super.key});

  @override
  State<DashboardProfile> createState() => _DashboardProfileState();
}

class _DashboardProfileState extends State<DashboardProfile> {
  bool isMyProfile = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width:
              MediaQuery.of(context).size.width * global.containerWidthFactor,
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            top: MediaQuery.of(context).size.width * 0.05,
            bottom: MediaQuery.of(context).size.width * 0.05,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.3),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.025),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        "Profile Name",
                        style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.035),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        "@username",
                        style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.035),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "69",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                            ),
                            Text(
                              "Total Workouts",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.6),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.02,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.025),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.03,
                          width: 1,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.025),
                        Column(
                          children: [
                            Text(
                              "420",
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                            Text(
                              "Total Sets",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.6),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.02,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.025),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.03,
                          width: 1,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.025),
                        Column(
                          children: [
                            Text(
                              "24",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                            ),
                            Text(
                              "Workout Hours",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.6),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.02,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        size: MediaQuery.of(context).size.width * 0.0275,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        "Send me location, somewhere",
                        style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: MediaQuery.of(context).size.width * 0.02),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Icon(
                        CupertinoIcons.calendar,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        size: MediaQuery.of(context).size.width * 0.0275,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.022,
                      ),
                      Text(
                        "Joined 23.1.23",
                        style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: MediaQuery.of(context).size.width * 0.02),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.075,
          width:
              MediaQuery.of(context).size.width * global.containerWidthFactor,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              border: Border(
                top: BorderSide(
                    width: 1, color: Theme.of(context).scaffoldBackgroundColor),
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [global.darkShadow(context)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.0225,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.03,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            width: 1,
                            color: Theme.of(context).scaffoldBackgroundColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isMyProfile ? "Edit Profile" : "Add friend",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.8)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.025,
                        ),
                        Icon(
                          isMyProfile
                              ? CupertinoIcons.pen
                              : Icons.person_add_alt_rounded,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          size: MediaQuery.of(context).size.width * 0.0275,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.025,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.height * 0.2,
                    height: MediaQuery.of(context).size.height * 0.03,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            width: 1,
                            color: Theme.of(context).scaffoldBackgroundColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Message",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.8)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.025,
                        ),
                        Icon(
                          CupertinoIcons.bubble_left_bubble_right,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          size: MediaQuery.of(context).size.width * 0.0275,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.2);

    path.quadraticBezierTo(size.width * 0.2, size.height * 0.0,
        size.width * 0.45, size.height * 0.15);
    //
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.35, size.width, size.height * 0.1);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
