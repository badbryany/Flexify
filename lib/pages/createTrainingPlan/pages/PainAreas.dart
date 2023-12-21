import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';

class PainAreas extends StatelessWidget {
  const PainAreas({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Tell us your',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 45,
              color: Theme.of(context).focusColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'pain areas',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                '!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Theme.of(context).focusColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              SvgPicture.asset(
                'assets/img/Human_body_silhouette.svg',
                height: MediaQuery.of(context).size.height * 0.6,
              ),

              // SHOLDER DOTS
              Positioned(
                top: MediaQuery.of(context).size.height * 0.12,
                left: MediaQuery.of(context).size.width * 0.1,
                child: Dot(),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.12,
                right: MediaQuery.of(context).size.width * 0.1,
                child: Dot(),
              ),

              // ELBOW DOTS
              Positioned(
                top: MediaQuery.of(context).size.height * 0.21,
                right: MediaQuery.of(context).size.width * 0.1,
                child: Dot(),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.21,
                left: MediaQuery.of(context).size.width * 0.1,
                child: Dot(),
              ),

              // WRIST DOTS
              Positioned(
                top: MediaQuery.of(context).size.height * 0.31,
                right: MediaQuery.of(context).size.width * 0.05,
                child: Dot(),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.31,
                left: MediaQuery.of(context).size.width * 0.05,
                child: Dot(),
              ),

              // HIP DOTS
              Positioned(
                top: MediaQuery.of(context).size.height * 0.31,
                right: MediaQuery.of(context).size.width * 0.15,
                child: Dot(),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.31,
                left: MediaQuery.of(context).size.width * 0.15,
                child: Dot(),
              ),

              // KNEE DOTS
              Positioned(
                top: MediaQuery.of(context).size.height * 0.42,
                right: MediaQuery.of(context).size.width * 0.16,
                child: Dot(),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.42,
                left: MediaQuery.of(context).size.width * 0.16,
                child: Dot(),
              ),
            ],
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.6),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
