import 'package:flexify/data/globalVariables.dart' as global;
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
  final FocusNode entryFocusNode = FocusNode();

  void closeKeyboard() {
    entryFocusNode.unfocus();
  }

  void suffixClearOnTap() {
    widget.entryController.clear();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.entryController.addListener(() {});
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
              fontSize: global.width(context) * .04,
            ),
          ),
        ),
        SizedBox(
          height: global.height(context) * .01,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding:
              EdgeInsets.symmetric(horizontal: global.width(context) * .05),
          height: global.height(context) * .08,
          width: widget.width ?? widget.width,
          decoration: BoxDecoration(
            color: global.lightGrey,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            focusNode: entryFocusNode,
            autofocus: false,
            onSubmitted: (value) {
              closeKeyboard();
            },
            keyboardType: widget.keyboardType ?? widget.keyboardType,
            controller: widget.entryController,
            decoration: InputDecoration(
              isCollapsed: true,
              hintText: widget.hintText ?? widget.hintText,
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: global.width(context) * .04,
              ),
              suffixIcon: IconButton(
                highlightColor: Colors.transparent,
                icon: const Icon(
                  Icons.clear_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  suffixClearOnTap();
                },
              ),
            ),
            cursorColor: Colors.white.withOpacity(.7),
          ),
        ),
      ],
    );
  }
}
