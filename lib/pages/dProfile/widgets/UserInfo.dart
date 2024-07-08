import 'package:flexify/widgets/LoadingImage.dart';
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
  String firstname = '';
  String email = '';

  XFile? image;
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

    // !TODO implement me

    print('update Data');

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
