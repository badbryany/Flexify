import 'package:flexify/SignInSignUp/widgets/input.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/widgets/Button.dart';
import 'package:flexify/widgets/DeleteAlertDialog.dart';
import 'package:flexify/widgets/LoadingImage.dart';
import 'package:flexify/widgets/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool loading = false;
  XFile? image;
  String username = '';
  String firstname = '';
  String email = '';

  List<Map<String, dynamic>> controllers = [
    {
      'title': 'Username',
      'controller': TextEditingController(),
      'inputType': TextInputType.name,
      'password': false,
    },
    {
      'title': 'Email',
      'controller': TextEditingController(),
      'inputType': TextInputType.emailAddress,
      'password': false,
    },
  ];

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    username = prefs.getString('Username')!;
    email = prefs.getString('Email')!;

    controllers[0]['controller'].text = username;
    controllers[1]['controller'].text = email;

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
      await uploadImage(image!);
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if ((controllers[0]['controller'] as TextEditingController).text ==
            username &&
        (controllers[1]['controller'] as TextEditingController).text ==
            prefs.getString('firstname') &&
        (controllers[2]['controller'] as TextEditingController).text == email) {
      loading = false;
      setState(() {});
      return;
    }

    http.Response res =
        await http.post(Uri.parse('${global.host}/editAccount'), body: {
      'jwt': prefs.getString('jwt'),
      'Username': (controllers[0]['controller'] as TextEditingController).text,
      'firstname': (controllers[1]['controller'] as TextEditingController).text,
      'email': (controllers[2]['controller'] as TextEditingController).text,
    });

    if (res.body == 'Username already taken') {
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
      (controllers[0]['controller'] as TextEditingController).text = username;
    }

    if (res.body == 'done') {
      prefs.setString('username',
          (controllers[0]['controller'] as TextEditingController).text);
      prefs.setString('firstname',
          (controllers[1]['controller'] as TextEditingController).text);
      prefs.setString('email',
          (controllers[2]['controller'] as TextEditingController).text);

      username = (controllers[0]['controller'] as TextEditingController).text;
      email = (controllers[2]['controller'] as TextEditingController).text;
    }

    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Navbar(
              title: 'Edit Profile',
              titleSize: global.width(context) * .075,
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                width: global.width(context) * .5,
                height: global.width(context) * .3,
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
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
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
                            right: 0,
                            top: 0,
                            child: BounceElement(
                              onTap: pickImage,
                              child: Container(
                                alignment: Alignment.center,
                                width: global.width(context) * .2,
                                height: global.height(context) * .035,
                                decoration: BoxDecoration(
                                  color: global.darkGrey,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        global.borderRadius - 10),
                                    topRight: Radius.circular(
                                        global.borderRadius - 10),
                                    bottomRight: Radius.circular(
                                        global.borderRadius - 10),
                                  ),
                                ),
                                child: global.gradient(
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(),
                                      Icon(
                                        Icons.edit_outlined,
                                        size: global.width(context) * .04,
                                      ),
                                      Text(
                                        'Edit',
                                        style: TextStyle(
                                          fontSize:
                                              global.width(context) * .035,
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
                  ],
                ),
              ),
            ),
            global.largeHeight(context),
            Center(
              child: Container(
                padding: EdgeInsets.all(global.containerPadding - 10),
                width: global.containerWidth(context),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(global.borderRadius - 5),
                  boxShadow: global.shadow(context),
                ),
                child: Column(
                  children: [
                    ...controllers.map((e) => Input(
                          hintText: e['title'],
                          textInputType: e['inputType'],
                          controller: e['controller'],
                          password: e['password'],
                        )),
                    global.mediumHeight(context),
                    GestureDetector(
                      onTap: () => print('Forgot Password'),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          decoration: TextDecoration.underline,
                          fontSize: global.width(context) * .0375,
                          decorationThickness: 5,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Button(
              onTap: saveData,
              title: 'Save',
              loading: loading,
            ),
          ],
        ),
      ),
    );
  }
}
