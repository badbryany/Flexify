import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter/material.dart';

showCustomModalBottomSheet(
  BuildContext context,
  ModalBottomSheet bottomSheet,
) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => bottomSheet,
      backgroundColor: Colors.transparent,
    );

class ModalBottomSheet extends StatefulWidget {
  const ModalBottomSheet({
    Key? key,
    required this.title,
    required this.titleSize,
    required this.content,
    this.submitButtonText,
    this.onPop,
    this.bigTitle,
    this.height,
    this.topPadding
  }) : super(key: key);

  final String title;
  final double titleSize;
  final String? submitButtonText;
  final Widget content;
  final Function? onPop;
  final bool? bigTitle;
  final double? height;
  final double? topPadding;

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    widget.bigTitle ?? false;
    widget.submitButtonText ?? 'fertig';
    
    return Container(
      height: widget.height,
      padding: EdgeInsets.symmetric(horizontal: global.width(context) * .05),
      width: global.width(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(global.borderRadius),
          topRight: Radius.circular(global.borderRadius),
        ),
        color: const Color.fromARGB(255, 26, 26, 29),
      ),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: global.width(context),
            child: Container(
              margin: const EdgeInsets.all(10),
              width: global.width(context) * .3,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white.withOpacity(0.6),
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
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: widget.titleSize,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  child: widget.content,
                ),
                const SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            gradient: global.linearGradient),
                        child: Center(
                          child: Text(
                            widget.submitButtonText!,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
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
    );
  }
}
