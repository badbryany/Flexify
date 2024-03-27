import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

showCustomModalBottomSheet(
  BuildContext context,
  ModalBottomSheet bottomSheet,
) =>
    showModalBottomSheet(
      context: context,
      builder: (context) => bottomSheet,
      backgroundColor: Colors.transparent,
    );

// ignore: must_be_immutable
class ModalBottomSheet extends StatelessWidget {
  ModalBottomSheet({
    Key? key,
    required this.title,
    required this.content,
    this.extraButton,
    this.submitButtonText,
    this.onPop,
    this.bigTitle,
  }) : super(key: key);

  final String title;
  String? submitButtonText;
  final Widget content;
  Map<String, dynamic>? extraButton; // {'onTap': () {}, 'child': Container(),}
  Function? onPop;
  bool? bigTitle;

  @override
  Widget build(BuildContext context) {
    onPop ??= () => Navigator.pop(context);
    bigTitle ??= false;
    submitButtonText ??= 'fertig';
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(global.borderRadius),
          topRight: Radius.circular(global.borderRadius),
        ),
        color: Theme.of(context).colorScheme.background,
      ),
      child: SizedBox(
        width: global.width(context),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: global.width(context),
              child: Container(
                margin: const EdgeInsets.all(10),
                width: global.width(context) * .35,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: bigTitle! ? 28 : 23,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    child: content,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      extraButton != null
                          ? Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: extraButton!['onTap'],
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.3,
                                      color: Colors.grey,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: extraButton!['child'],
                                ),
                              ),
                            )
                          : const SizedBox(),
                      GestureDetector(
                        onTap: () => onPop!(),
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Center(
                            child: Text(
                              submitButtonText!,
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
