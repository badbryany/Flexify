import 'package:flexify/pages/dProfile/widgets/QRBottomsheet.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/widgets/ModalBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class ShareWithFriends extends StatelessWidget {
  const ShareWithFriends({
    super.key,
    required this.username,
  });

  final String username;

  @override
  Widget build(BuildContext context) {
    return BounceElement(
      onTap: () => showCustomModalBottomSheet(
        context,
        modalBottomSheet(context, username),
      ),
      child: Center(
        child: Container(
          width: global.containerWidth(context),
          height: global.height(context) * .075,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(global.borderRadius - 10),
            boxShadow: global.shadow(context),
            color: Theme.of(context).colorScheme.background,
            // gradient: LinearGradient(
            //   colors: [
            //     Theme.of(context).colorScheme.primary,
            //     Theme.of(context).colorScheme.onPrimary,
            //   ],
            // ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Connect with Friends',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: global.width(context) * .05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Icon(
              //   Icons.connect_without_contact_outlined,
              //   color: Colors.black,
              //   size: global.width(context) * .06,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
