import 'package:flexify/SignInSignUp/widgets/input.dart';
import 'package:flexify/pages/dProfile/pages/AddFriends.dart';
import 'package:flexify/pages/dProfile/widgets/QRBottomsheet.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/widgets/DeleteAlertDialog.dart';
import 'package:flexify/widgets/LoadingImage.dart';
import 'package:flexify/widgets/ModalBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String username = '';
  String email = '';
  String firstname = '';

  bool editing = false;
  bool loading = false;

  XFile? image;

  Map<String, Map<String, dynamic>> controllers = {
    'firstname': {
      'title': 'Firstname',
      'controller': TextEditingController(),
      'textInputType': TextInputType.name,
      'password': false,
      'icon': const Icon(
        Icons.person_2,
        size: 20,
      ),
    },
    'username': {
      'title': 'Username',
      'controller': TextEditingController(),
      'textInputType': TextInputType.text,
      'password': false,
      'icon': const Icon(
        Icons.person,
        size: 20,
      ),
    },
    'email': {
      'title': 'E-Mail',
      'controller': TextEditingController(),
      'textInputType': TextInputType.emailAddress,
      'password': false,
      'icon': const Icon(
        Icons.email,
        size: 20,
      ),
    },
  };

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    username = prefs.getString('username')!;
    email = prefs.getString('email')!;
    firstname = prefs.getString('firstname')!;

    ((controllers['username'] as Map)['controller'] as TextEditingController)
        .text = username;
    ((controllers['email'] as Map)['controller'] as TextEditingController)
        .text = email;
    ((controllers['firstname'] as Map)['controller'] as TextEditingController)
        .text = firstname;

    setState(() {});
  }

  Future<List<int>> compressImage(XFile image) async {
    final decodedImage = img.decodeImage(await image.readAsBytes());
    final compressedImage = img.encodeJpg(
      decodedImage!,
      quality: 10,
    );
    return compressedImage;
  }

  Future<http.Response> uploadImage(XFile image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var multipartRequest = http.MultipartRequest(
      'POST',
      Uri.parse('${global.host}/uploadProfilePicture'),
    );

    multipartRequest.fields['jwt'] = prefs.getString('jwt')!;
    var multipartFile = http.MultipartFile.fromBytes(
      'image',
      await compressImage(image),
      filename: image.path.split('/').last,
    );
    multipartRequest.files.add(multipartFile);

    var response = await multipartRequest.send();
    return http.Response.fromStream(response);
  }

  pickImage() async {
    if (loading) return;

    loading = true;
    setState(() {});

    XFile? tmpImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (tmpImage == null) {
      loading = false;
      setState(() {});
      return;
    }

    image = tmpImage;

    loading = false;
    setState(() {});
  }

  saveData() async {
    loading = true;
    setState(() {});

    if (image != null) {
      print((await uploadImage(image!)).body);
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (((controllers['username'] as Map)['controller']
                    as TextEditingController)
                .text ==
            username &&
        ((controllers['email'] as Map)['controller'] as TextEditingController)
                .text ==
            email &&
        ((controllers['firstname'] as Map)['controller']
                    as TextEditingController)
                .text ==
            firstname) {
      editing = false;
      loading = false;
      setState(() {});
      return;
    }

    http.Response res =
        await http.post(Uri.parse('${global.host}/editAccount'), body: {
      'jwt': prefs.getString('jwt'),
      'username': ((controllers['username'] as Map)['controller']
              as TextEditingController)
          .text,
      'firstname': ((controllers['firstname'] as Map)['controller']
              as TextEditingController)
          .text,
      'email':
          ((controllers['email'] as Map)['controller'] as TextEditingController)
              .text,
    });

    if (res.body == 'username already taken') {
      await showDialog(
        context: context,
        builder: (context) => DeleteAlertDialog(
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Got it!'),
            )
          ],
          title: 'The username is already taken!',
        ),
      );
      ((controllers['username'] as Map)['controller'] as TextEditingController)
          .text = username;
    }

    if (res.body == 'done') {
      prefs.setString(
          'username',
          ((controllers['username'] as Map)['controller']
                  as TextEditingController)
              .text);
      prefs.setString(
          'firstname',
          ((controllers['firstname'] as Map)['controller']
                  as TextEditingController)
              .text);
      prefs.setString(
          'email',
          ((controllers['email'] as Map)['controller'] as TextEditingController)
              .text);

      username = ((controllers['username'] as Map)['controller']
              as TextEditingController)
          .text;
      email =
          ((controllers['email'] as Map)['controller'] as TextEditingController)
              .text;

      editing = false;
    }

    loading = false;
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
            curve: Curves.easeInOut,
            height: editing ? containerHeight * 2 : containerHeight,
            width: global.width(context) * global.containerWidthFactor,
            decoration: BoxDecoration(
              color: global.darkGrey,
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
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  child: SizedBox(
                    key: ValueKey(editing),
                    child: editing
                        ? Container(
                            margin: EdgeInsets.only(
                                top: global.height(context) * .075),
                            alignment: Alignment.center,
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: controllers.entries
                                    .toList()
                                    .map(
                                      (e) => Input(
                                        hintText: e.value['title'],
                                        textInputType: e.value['textInputType'],
                                        controller: e.value['controller'],
                                        password: e.value['password'],
                                        icon: e.value['icon'],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          )
                        : Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              top: containerHeight * .25,
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
                                      fontSize: global.width(context) * .05 + 5,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: global.height(context) * .005,
                                ),
                                Text(
                                  email.isNotEmpty
                                      ? '${email.length >= 20 ? email.substring(0, 20).trim() : email}...'
                                      : '---',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(.75),
                                    fontSize: global.width(context) * .03 + 5,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                // Profilepicture
                GestureDetector(
                  onTap: editing ? pickImage : null,
                  child: AnimatedScale(
                    duration: global.standardAnimationDuration,
                    curve: Curves.easeInOut,
                    scale: editing ? 1.125 : 1,
                    child: AnimatedContainer(
                      curve: Curves.easeInOut,
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
                        top: (containerHeight / 2) -
                            global.height(context) * .075,
                        left: editing
                            ? (global.width(context) *
                                    global.containerWidthFactor /
                                    2) -
                                global.height(context) * .055
                            : global.width(context) * .075,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(1.5),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: global.darkGrey,
                                  borderRadius: BorderRadius.circular(100)),
                              child: LoadingImage(
                                url:
                                    'https://flexify.kellermann.team/api/getProfilePicture?username=$username',
                                path: image?.path,
                                width: global.width(context) * .25,
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            duration: global.standardAnimationDuration,
                            opacity: editing ? 1 : 0,
                            child: Container(
                              alignment: Alignment.center,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: global.lightGrey.withOpacity(.7),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(
                                  CupertinoIcons.camera,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  size: global.width(context) * .05,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                      bottom: global.width(context) * .05,
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
                            MaterialPageRoute(
                              builder: (context) => const AddFriends(),
                            ),
                          ),
                        ),
                        UserInfoButton(
                          icon: CupertinoIcons.qrcode,
                          onTap: () => showCustomModalBottomSheet(
                            context,
                            modalBottomSheet(context, username),
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
                      child: Container(
                        padding: EdgeInsets.all(global.width(context) * .025),
                        decoration: BoxDecoration(
                          color: global.lightGrey,
                          borderRadius: BorderRadius.circular(12.5),
                        ),
                        key: ValueKey(editing),
                        child: Icon(
                          editing ? Icons.close : Icons.edit,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                ),

                // save / delete edited data
                Visibility(
                  visible: editing,
                  child: AnimatedOpacity(
                    duration: global.standardAnimationDuration,
                    opacity: editing ? 1 : 0,
                    child: loading
                        ? Container(
                            height: containerHeight * 2.5,
                            width: global.width(context) *
                                global.containerWidthFactor,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.5),
                              borderRadius:
                                  BorderRadius.circular(global.borderRadius),
                            ),
                            child: global.loadingWidget(context, .75),
                          )
                        : Container(
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.only(
                              bottom: global.width(context) * .05,
                              left: global.width(context) * .05,
                              right: global.width(context) * .05,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                UserInfoButton(
                                    icon: Icons.close,
                                    onTap: () =>
                                        setState(() => editing = false)),
                                UserInfoButton(
                                  icon: Icons.save,
                                  highlight: true,
                                  onTap: saveData,
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
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
              color: global.lightGrey,
              gradient: highlight == true ? global.linearGradient : null,
              boxShadow: [global.darkShadow(context)],
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: highlight == true
                    ? Colors.black
                    : Colors.white.withOpacity(.9),
                size: global.width(context) * .06,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
