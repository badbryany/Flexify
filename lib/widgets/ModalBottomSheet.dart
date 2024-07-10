import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/widgets/BounceElement.dart';
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
    this.topPadding,
    this.extraButtonTitle,
    this.extraButtonOnTap,
  }) : super(key: key);

  final String title;
  final double titleSize;
  final String? submitButtonText;
  final Widget content;
  final Function? onPop;
  final bool? bigTitle;
  final double? height;
  final double? topPadding;
  final String? extraButtonTitle;
  final Function()? extraButtonOnTap;

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
                    BounceElement(
                      onTap: () => widget.onPop != null
                          ? widget.onPop!()
                          : Navigator.pop(context),
                      child: Container(
                        width: global.width(context) * .3,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            gradient: global.linearGradient),
                        child: Center(
                          child: Text(
                            widget.submitButtonText!,
                            style: TextStyle(
                              fontSize: global.width(context) * .04,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (widget.extraButtonOnTap != null &&
                        widget.extraButtonTitle != null)
                      Padding(
                        padding:
                            EdgeInsets.only(left: global.width(context) * .05),
                        child: BounceElement(
                          onTap: widget.extraButtonOnTap,
                          child: Container(
                            width: global.width(context) * .4,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                widget.extraButtonTitle!,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: global.width(context) * .04,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
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
