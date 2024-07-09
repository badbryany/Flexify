import 'package:flexify/pages/dProfile/pages/EditProfile.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/widgets/LoadingImage.dart';
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
  String firstname = '';
  String email = '';

  bool loading = false;

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    username = prefs.getString('username')!;
    firstname = prefs.getString('firstname')!;
    email = prefs.getString('email')!;

    setState(() {});
  }

  shortenString(String str) {
    if (str.length >= 21) {
      return '${str.substring(0, 20)}...';
    } else {
      return str;
    }
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
        SizedBox(
          width: global.width(context),
          child: Stack(
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: global.width(context) * .275,
                  height: global.width(context) * .275,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: global.width(context) * .275,
                          height: global.width(context) * .275,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(1000),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: LoadingImage(
                          url:
                              'https://flexify.kellermann.team/api/getProfilePicture?username=$username',
                          width: global.width(context) * .25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: global.width(context) * .25,
                top: 0,
                child: BounceElement(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: global.width(context) * .2,
                    height: global.height(context) * .035,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(global.borderRadius - 10),
                        topRight: Radius.circular(global.borderRadius - 10),
                        bottomRight: Radius.circular(global.borderRadius - 10),
                      ),
                    ),
                    child: global.gradient(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(),
                          Icon(
                            Icons.edit_outlined,
                            size: global.width(context) * .04,
                          ),
                          Text(
                            'edit',
                            style: TextStyle(
                              fontSize: global.width(context) * .035,
                            ),
                          ),
                          const SizedBox(),
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        global.largeHeight(context),
        Text(
          '${shortenString(username)}, ${shortenString(firstname)}',
          style: TextStyle(
            fontSize: global.width(context) * .05,
            color: Theme.of(context).focusColor,
          ),
        ),
        global.mediumHeight(context),
        Text(
          shortenString(email),
          style: TextStyle(
            fontSize: global.width(context) * .04,
            color: Theme.of(context).focusColor.withOpacity(.75),
          ),
        ),
      ],
    );
  }
}
