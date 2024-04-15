import 'dart:convert';
import 'dart:ui';

import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/widgets/LoadingImage.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class PersonalElement extends StatefulWidget {
  const PersonalElement({super.key});

  @override
  State<PersonalElement> createState() => _PersonalElementState();
}

class _PersonalElementState extends State<PersonalElement> {
  int workouts = -1;
  int friends = -1;
  int streak = -1;

  bool isPremium = false;
  bool editing = false;
  bool loading = false;

  DateTime joinDate = DateTime.now();

  String username = '...';

  String profilePicturePath = '${global.host}/getProfilePicture?username=';

  List<Map<String, dynamic>> inputs = [
    {
      'title': 'username',
      'icon': const Icon(Icons.person),
      'controller': TextEditingController(),
      'obscure': false,
    },
    {
      'title': 'E-Mail',
      'icon': const Icon(Icons.email_rounded),
      'controller': TextEditingController(),
      'obscure': false,
    },
    {
      'title': 'firstname',
      'icon': const Icon(Icons.person_2),
      'controller': TextEditingController(),
      'obscure': false,
    }
  ];

  getData() async {
    loading = true;
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();

    username = prefs.getString('username')!;

    if (!profilePicturePath.contains(username)) {
      profilePicturePath =
          '${global.host}/getProfilePicture?username=$username';
      setState(() {});
    }

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
    loading = false;
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

  XFile? image;

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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: AnimatedContainer(
            duration: global.standardAnimationDuration,
            padding: EdgeInsets.all(global.containerPadding - 5),
            decoration: BoxDecoration(
              color: editing
                  ? global.darken(Theme.of(context).colorScheme.background, .05)
                  : Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(global.borderRadius),
              boxShadow: [global.lightShadow(context)],
            ),
            width: global.width(context) * global.containerWidthFactor,
            height: global.height(context) * (editing ? .5 : .19),
            child: Stack(
              children: [
                AnimatedOpacity(
                  duration: global.standardAnimationDuration,
                  opacity: editing ? 0 : 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          LoadingImage(
                            url: profilePicturePath,
                            width: global.width(context) * .18,
                          ),
                          SizedBox(width: global.width(context) * 0.05),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // USERNAME
                              Row(
                                children: [
                                  Text(
                                    username,
                                    style: TextStyle(
                                      color: isPremium
                                          ? global.gold
                                          : Theme.of(context)
                                              .colorScheme
                                              .onBackground,
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
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
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: global.standardAnimationDuration,
                  height: editing ? global.height(context) * .5 : 0,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      AnimatedOpacity(
                        duration: global.standardAnimationDuration,
                        opacity: editing ? 1 : 0,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async => await pickImage(),
                                child: Container(
                                  width: global.width(context) * .25,
                                  height: global.width(context) * .25,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: Stack(
                                    children: [
                                      LoadingImage(
                                        url: profilePicturePath,
                                        path: image?.path,
                                        width: global.width(context) * .25,
                                      ),
                                      Container(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            bottom:
                                                global.width(context) * .035,
                                            right: global.width(context) * .035,
                                          ),
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background
                                                .withOpacity(.9),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Icon(
                                            Icons.edit,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                            size: global.width(context) * .04,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ...inputs.map(
                                (e) => Container(
                                  width: global.width(context) * .8,
                                  margin:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    borderRadius: BorderRadius.circular(
                                        global.borderRadius - 10),
                                  ),
                                  child: TextField(
                                    enabled: false,
                                    obscureText: e['obscure'],
                                    controller: e['controller'],
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                                    decoration: InputDecoration(
                                      prefixIcon: e['icon'],
                                      prefixIconColor: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      labelText: e['title'],
                                      labelStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(.3),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    cursorColor: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                              ),
                            ],
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
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(
            left: global.width(context) * .04,
            top: global.width(context) * .015,
          ),
          child: IconButton(
            onPressed: () => setState(() {
              editing = !editing;
              image = null;
            }),
            icon: AnimatedSwitcher(
              duration: global.standardAnimationDuration,
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: editing
                  ? Icon(
                      key: const ValueKey('close_rounded'),
                      Icons.close_rounded,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: global.width(context) * .05,
                    )
                  : Icon(
                      key: const ValueKey('edit_rounded'),
                      Icons.edit_rounded,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: global.width(context) * .05,
                    ),
            ),
          ),
        ),
        AnimatedOpacity(
          duration: global.standardAnimationDuration,
          opacity: editing ? 1 : 0,
          child: Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(
              right: global.width(context) * .04,
              top: global.width(context) * .015,
            ),
            padding: const EdgeInsets.all(7.5),
            child: AnimatedContainer(
              duration: global.standardAnimationDuration,
              width: global.width(context) * .09,
              height: global.width(context) * .09,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(loading ? .3 : .7),
              ),
              child: IconButton(
                onPressed: () async {
                  if (image == null) {
                    editing = false;
                    setState(() {});
                    return;
                  }

                  loading = true;
                  setState(() {});
                  await uploadImage(image!);
                  await getData();
                  editing = false;
                  image = null;
                  if (profilePicturePath.contains('https://')) {
                    profilePicturePath =
                        profilePicturePath.replaceAll('https://', 'http://');
                    setState(() {});
                    return;
                  }
                  profilePicturePath =
                      profilePicturePath.replaceAll('http://', 'https://');

                  setState(() {});
                },
                icon: loading
                    ? global.loadingWidget(context, .5)
                    : Icon(
                        Icons.check_rounded,
                        color: Theme.of(context).colorScheme.onBackground,
                        size: global.width(context) * .05,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
