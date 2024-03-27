import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class LoadingImage extends StatelessWidget {
  const LoadingImage({
    super.key,
    required this.url,
    required this.width,
    this.path,
  });

  final String url;
  final double width;
  final String? path;

  @override
  Widget build(BuildContext context) {
    return path != null
        ? Image.file(
            width: global.width(context) * .2,
            height: global.width(context) * .2,
            File(path!),
          )
        : Image.network(
            url,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;

              return SizedBox(
                width: global.width(context) * .05,
                height: global.width(context) * .05,
                child: const CircularProgressIndicator(),
              );
            },
            width: width,
          );
  }
}
