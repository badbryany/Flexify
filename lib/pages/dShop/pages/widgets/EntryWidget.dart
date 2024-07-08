import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/widgets/ModalBottomSheet.dart';
import 'package:flutter/material.dart';

class EntryWidget extends StatefulWidget {
  final String title;
  final String? hintText;
  final double? width;
  final TextEditingController entryController;
  final TextInputType? keyboardType;

  const EntryWidget({
    super.key,
    required this.title,
    required this.entryController,
    this.keyboardType,
    this.hintText,
    this.width,
  });

  @override
  State<EntryWidget> createState() => _EntryWidgetState();
}

class _EntryWidgetState extends State<EntryWidget> {
  void suffixClearOnTap() {
    widget.entryController.clear();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.entryController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        global.gradient(
          Text(
            '${widget.title}:',
            style: TextStyle(
              color: Colors.white,
              fontSize: global.width(context) * .04,
            ),
          ),
        ),
        SizedBox(
          height: global.height(context) * .01,
        ),
        GestureDetector(
          onTap: () {
            showCustomModalBottomSheet(
              context,
              ModalBottomSheet(
                title: widget.title,
                height: global.height(context) * .8,
                topPadding: 0,
                titleSize: global.width(context) * .08,
                submitButtonText: "Enter",
                content: Container(
                  padding: EdgeInsets.only(bottom: global.height(context) * .3),
                  height: global.height(context) * .38,
                  width: global.width(context) * .8,
                  child: global.gradient(
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                        left: global.width(context) * .045,
                        right: global.width(context) * .03,
                      ),
                      width: global.containerWidth(context),
                      height: global.height(context) * .08,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        autofocus: true,
                        onSubmitted: (value) {
                          Navigator.pop(context);
                          setState(() {
                            
                          });
                        },
                        keyboardType:
                            widget.keyboardType ?? widget.keyboardType,
                        controller: widget.entryController,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          hintText: widget.hintText ?? widget.hintText,
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: global.width(context) * .04,
                          ),
                          suffixIcon: IconButton(
                            highlightColor: Colors.transparent,
                            icon: const Icon(
                              Icons.clear_rounded,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              suffixClearOnTap();
                            },
                          ),
                        ),
                        cursorColor: Colors.black.withOpacity(.7),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          child: global.gradient(
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: global.width(context) * .03),
              height: global.height(context) * .08,
              width: widget.width ?? widget.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.entryController.text,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
