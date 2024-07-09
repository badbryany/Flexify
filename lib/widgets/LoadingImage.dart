import 'dart:io';
import 'dart:ui';

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
    return SizedBox(
      width: width,
      height: width,
      child: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(1000),
              ),
            ),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: AnimatedScale(
                duration: global.standardAnimationDuration,
                scale: 2,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 30,
                    sigmaY: 30,
                  ),
                  child: path != null
                      ? Image.file(
                          File(path!),
                        )
                      : Image.network(
                          url,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;

                            return SizedBox(
                              width: global.width(context) * .05,
                              height: global.width(context) * .05,
                              child: global.loadingWidget(context, 1),
                            );
                          },
                          width: width,
                        ),
                ),
              ),
            ),
          ),
          Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: path != null
                    ? Image.file(
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
                      )),
          ),
        ],
      ),
    );
  }
}



/* 

 */