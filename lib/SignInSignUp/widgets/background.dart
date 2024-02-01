import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            color: Colors.black,
          ),
        ),
// image
        Center(
          child: Image.asset(
            'assets/img/SignIn-background.jpg',
          ),
        ),
// fade to black
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      Colors.black,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
// gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black,
                Colors.transparent,
              ],
            ),
          ),
        ),
// logo
        Container(
          alignment: const Alignment(0, -0.65),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.width * 0.2,
                child: Image.asset(
                  'assets/img/logo.png',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
