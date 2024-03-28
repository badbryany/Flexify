import 'dart:ui';

import 'package:flexify/pages/dashboard.dart';
import 'package:flexify/widgets/Button.dart';
import 'package:flexify/widgets/LoadingImage.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;

class UploadProfilePicture extends StatefulWidget {
  const UploadProfilePicture({super.key});

  @override
  State<UploadProfilePicture> createState() => UploadStateProfilePicture();
}

class UploadStateProfilePicture extends State<UploadProfilePicture> {
  bool loading = false;
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

    await uploadImage(image!);

    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.centerRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.onPrimary,
                ],
              ),
            ),
          ),
          ClipPath(
            clipper: BezierClipper(),
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              height: global.height(context) * .8,
            ),
          ),
          Center(
            child: Container(
              width: global.width(context) * global.containerWidthFactor,
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(.8),
                borderRadius: BorderRadius.circular(global.borderRadius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    width: global.width(context),
                    child: Text(
                      'Add a picture',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.1,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: image != null
                        ? SizedBox(
                            width: global.width(context) * .2,
                            height: global.width(context) * .2,
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      borderRadius: BorderRadius.circular(1000),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: AnimatedScale(
                                      duration:
                                          global.standardAnimationDuration,
                                      scale: 2,
                                      child: ImageFiltered(
                                        imageFilter: ImageFilter.blur(
                                          sigmaX: 30,
                                          sigmaY: 30,
                                        ),
                                        child: LoadingImage(
                                          path: image!.path,
                                          url: '',
                                          width: global.width(context) * .2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Stack(
                                      children: [
                                        LoadingImage(
                                          path: image!.path,
                                          url: '',
                                          width: global.width(context) * .2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            width: global.width(context) * .2,
                            height: global.width(context) * .2,
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                colors: [
                                  Colors.grey.shade400,
                                  Colors.grey.shade600,
                                ],
                              ),
                            ),
                          ),
                  ),
                  Button(
                    onTap: () => pickImage(),
                    title: 'add picture',
                    loading: loading,
                  ),
                  Button(
                    onTap: () => Navigator.push(
                      context,
                      PageTransition(
                        child: const Dashboard(),
                        type: PageTransitionType.fade,
                      ),
                    ),
                    title: 'done',
                    loading: loading,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.75);

    path.quadraticBezierTo(size.width * 0.25, size.height * 0.5,
        size.width * 0.5, size.height * 0.75);
    //
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 1, size.width, size.height * 0.75);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
