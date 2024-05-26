import 'package:flexify/SignInSignUp/widgets/input.dart';
import 'package:flexify/pages/dProfile/pages/AddFriends.dart';
import 'package:flexify/pages/dProfile/pages/QRShow.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/widgets/LoadingImage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String username = '';
  String email = '';

  bool editing = false;

  List<Map<String, dynamic>> controllers = [
    {
      'title': 'username',
      'controller': TextEditingController(),
      'textInputType': TextInputType.text,
      'password': false,
      'icon': const Icon(
        Icons.person,
        size: 20,
      ),
    },
    {
      'title': 'firstname',
      'controller': TextEditingController(),
      'textInputType': TextInputType.text,
      'password': false,
      'icon': const Icon(
        Icons.person_2,
        size: 20,
      ),
    },
    {
      'title': 'E-Mail',
      'controller': TextEditingController(),
      'textInputType': TextInputType.emailAddress,
      'password': false,
      'icon': const Icon(
        Icons.email,
        size: 20,
      ),
    },
    {
      'title': 'password',
      'controller': TextEditingController(),
      'textInputType': TextInputType.text,
      'password': true,
      'icon': const Icon(
        Icons.key,
        size: 20,
      ),
    },
  ];

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    username = prefs.getString('username')!;
    email = prefs.getString('email')!;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight = global.height(context) * .25;
    return Stack(
      children: [
        Center(
          child: AnimatedContainer(
            duration: global.standardAnimationDuration,
            height: editing ? containerHeight * 2.5 : containerHeight,
            width: global.width(context) * global.containerWidthFactor,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(global.borderRadius),
              boxShadow: global.isDarkMode(context)
                  ? [global.darkShadow(context)]
                  : [global.lightShadow(context)],
            ),
            child: Stack(
              children: [
                // username and email Column
                AnimatedSwitcher(
                  duration: global.standardAnimationDuration,
                  child: SizedBox(
                    key: ValueKey(editing),
                    child: editing
                        ? Container(
                            margin: EdgeInsets.only(
                                top: global.height(context) * .1),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: controllers
                                  .map(
                                    (e) => Input(
                                      hintText: e['title'],
                                      textInputType: e['textInputType'],
                                      controller: e['controller'],
                                      password: e['password'],
                                      icon: e['icon'],
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        : Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              top: containerHeight * .3,
                              left: global.width(context) * .1,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                global.gradient(
                                  Text(
                                    username.isNotEmpty ? username : '---',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: global.height(context) * .0375,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: global.height(context) * .005,
                                ),
                                Text(
                                  email.isNotEmpty ? email : '---',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(.75),
                                    fontSize: global.height(context) * .02,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                // Profilepicture
                AnimatedScale(
                  duration: global.standardAnimationDuration,
                  scale: editing ? 1.125 : 1,
                  child: AnimatedContainer(
                    duration: global.standardAnimationDuration,
                    height: global.height(context) * .1,
                    width: global.height(context) * .1,
                    alignment:
                        editing ? Alignment.topCenter : Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      boxShadow: [global.darkShadow(context)],
                    ),
                    margin: EdgeInsets.only(
                      top:
                          (containerHeight / 2) - global.height(context) * .075,
                      left: editing
                          ? (global.width(context) *
                                  global.containerWidthFactor /
                                  2) -
                              global.height(context) * .055
                          : global.width(context) * .075,
                    ),
                    child: LoadingImage(
                      url:
                          'https://flexify.kellermann.team/api/getProfilePicture?username=${username.isNotEmpty ? username : '---'}',
                      width: global.height(context) * .1,
                    ),
                  ),
                ),
                // addfriends and qrcode / edit -> cancle/save
                AnimatedOpacity(
                  duration: global.standardAnimationDuration,
                  opacity: editing ? 0 : 1,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(
                      bottom: global.height(context) * .0125,
                      left: global.width(context) * .05,
                      right: global.width(context) * .05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        UserInfoButton(
                          icon: Icons.person_add_rounded,
                          onTap: () => Navigator.push(
                            context,
                            PageTransition(
                              child: const AddFriends(),
                              type: PageTransitionType.rightToLeft,
                            ),
                          ),
                        ),
                        UserInfoButton(
                          icon: Icons.qr_code_2_rounded,
                          onTap: () => Navigator.push(
                            context,
                            PageTransition(
                              child: const QRShow(),
                              type: PageTransitionType.rightToLeft,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // save / delete edited data
                AnimatedOpacity(
                  duration: global.standardAnimationDuration,
                  opacity: editing ? 1 : 0,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(
                      bottom: global.height(context) * .0125,
                      left: global.width(context) * .05,
                      right: global.width(context) * .05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        UserInfoButton(
                            icon: Icons.close,
                            onTap: () => setState(() => editing = false)),
                        UserInfoButton(
                          icon: Icons.save,
                          highlight: true,
                          onTap: () => print('saveData'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // edit / cancel icon-utton
        Container(
          alignment: Alignment.topRight,
          margin: EdgeInsets.all(global.width(context) * .05),
          padding: EdgeInsets.all(global.width(context) * .025),
          child: GestureDetector(
            onTap: () => setState(() => editing = !editing),
            child: AnimatedSwitcher(
              duration: global.standardAnimationDuration,
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: SizedBox(
                  key: ValueKey(editing),
                  child: Icon(
                    editing ? Icons.close : Icons.edit,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.75),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

class UserInfoButton extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final bool? highlight;

  const UserInfoButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    return BounceElement(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: global.height(context) * .05,
          width: global.width(context) * .4,
          padding: EdgeInsets.symmetric(
              horizontal: global.width(context) * .1,
              vertical: global.height(context) * .005),
          decoration: BoxDecoration(
              color: highlight == true
                  ? Theme.of(context).colorScheme.primary.withOpacity(.25)
                  : const Color.fromARGB(255, 26, 26, 29),
              boxShadow: [global.lightShadow(context)],
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white.withOpacity(.9),
                size: global.width(context) * .06,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
