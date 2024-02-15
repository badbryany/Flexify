import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class AnimSearchBar extends StatefulWidget {
  ///  width - double ,isRequired : Yes
  ///  textController - TextEditingController  ,isRequired : Yes
  ///  onSuffixTap - Function, isRequired : Yes
  ///  onSubmitted - Function, isRequired : Yes
  ///  rtl - Boolean, isRequired : No
  ///  autoFocus - Boolean, isRequired : No
  ///  style - TextStyle, isRequired : No
  ///  closeSearchOnSuffixTap - bool , isRequired : No
  ///  suffixIcon - Icon ,isRequired :  No
  ///  prefixIcon - Icon  ,isRequired : No
  ///  animationDurationInMilli -  int ,isRequired : No
  ///  helpText - String ,isRequired :  No
  ///  inputFormatters - TextInputFormatter, Required - No
  ///  boxShadow - bool ,isRequired : No
  ///  textFieldColor - Color ,isRequired : No
  ///  searchIconColor - Color ,isRequired : No
  ///  textFieldIconColor - Color ,isRequired : No
  ///
  final double width;
  final TextEditingController textController;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final String helpText;
  final int animationDurationInMilli;
  final onSuffixTap;
  final bool open;
  final bool rtl;
  final bool autoFocus;
  final TextStyle? style;
  final bool closeSearchOnSuffixTap;
  final Color? color;
  final Color? textFieldColor;
  final Color? searchIconColor;
  final Color? textFieldIconColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool boxShadow;
  final Function(String) onSubmitted;
  final Function(int) onToggle;
  const AnimSearchBar(
      {Key? key,

      /// The width cannot be null
      required this.width,
      required this.open,

      /// The textController cannot be null
      required this.textController,
      this.suffixIcon,
      this.prefixIcon,
      this.helpText = "Search...",

      /// choose your custom color
      this.color = Colors.red,

      /// choose your custom color for the search when it is expanded
      this.textFieldColor = Colors.white,

      /// choose your custom color for the search when it is expanded
      this.searchIconColor = Colors.black,

      /// choose your custom color for the search when it is expanded
      this.textFieldIconColor = Colors.black,

      /// The onSuffixTap cannot be null
      required this.onSuffixTap,
      this.animationDurationInMilli = 375,

      /// The onSubmitted cannot be null
      required this.onSubmitted,

      /// make the search bar to open from right to left
      this.rtl = false,

      /// make the keyboard to show automatically when the AnimSearchBar is expanded
      this.autoFocus = false,

      /// TextStyle of the contents inside the AnimSearchBar
      this.style,

      /// close the search on suffix tap
      this.closeSearchOnSuffixTap = false,

      /// enable/disable the box shadow decoration
      this.boxShadow = true,

      /// can add list of inputformatters to control the input
      this.inputFormatters,
      required this.onToggle})
      : super(key: key);

  @override
  _AnimSearchBarState createState() => _AnimSearchBarState();
}

///toggle - 0 => false or closed
///toggle 1 => true or open
int toggle = 0;

/// * use this variable to check current text from OnChange
String textFieldValue = '';

class _AnimSearchBarState extends State<AnimSearchBar>
    with SingleTickerProviderStateMixin {
  ///initializing the AnimationController
  late AnimationController _con;
  FocusNode focusNode = FocusNode();
  final GlobalKey<_AnimSearchBarState> searchBarKey =
      GlobalKey<_AnimSearchBarState>();

  @override
  void initState() {
    toggle = widget.open ? 1 : 0;

    super.initState();

    ///Initializing the animationController which is responsible for the expanding and shrinking of the search bar
    _con = AnimationController(
      vsync: this,

      /// animationDurationInMilli is optional, the default value is 375
      duration: Duration(milliseconds: widget.animationDurationInMilli),
    );
  }

  void switchToggle(int incoming) {
    setState(() {
      incoming == 0 ? toggle = 1 : toggle = 0;
    });
  }

  unfocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    toggle = widget.open ? 1 : 0;
    return Container(
      ///if the rtl is true, search bar will be from right to left
      alignment:
          widget.rtl ? Alignment.centerRight : const Alignment(-1.0, 0.0),

      ///Using Animated container to expand and shrink the widget
      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.animationDurationInMilli),
        height: (toggle == 0)
            ? MediaQuery.of(context).size.width * 0.15
            : MediaQuery.of(context).size.height * 0.07,
        width: (toggle == 0)
            ? MediaQuery.of(context).size.width * 0.15
            : widget.width,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          /// can add custom  color or the color will be white
          color: toggle == 1
              ? Theme.of(context).colorScheme.background
              : widget.color,
          borderRadius: BorderRadius.circular(100),

          /// show boxShadow unless false was passed
          boxShadow: !widget.boxShadow
              ? null
              : [
                  global.isDarkMode(context)
                      ? global.darkShadow(context)
                      : global.lightShadow(context)
                ],
        ),
        child: Stack(
          children: [
            ///Using Animated Positioned widget to expand and shrink the widget
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              top: MediaQuery.of(context).size.height * 0.02,
              right: MediaQuery.of(context).size.width * 0.05,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  decoration: BoxDecoration(
                    /// can add custom color or the color will be white
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: AnimatedBuilder(
                    builder: (context, widget) {
                      ///Using Transform.rotate to rotate the suffix icon when it gets expanded
                      return Transform.rotate(
                        angle: _con.value * 2.0 * pi,
                        child: widget,
                      );
                    },
                    animation: _con,
                    child: GestureDetector(
                      onTap: () {
                        try {
                          ///trying to execute the onSuffixTap function
                          widget.onSuffixTap();

                          // * if field empty then the user trying to close bar
                          if (textFieldValue == '') {
                            unfocusKeyboard();
                            setState(() {
                              toggle = 0;
                            });

                            ///reverse == close
                            _con.reverse();
                          }

                          // * why not clear textfield here?
                          widget.textController.clear();
                          textFieldValue = '';

                          ///closeSearchOnSuffixTap will execute if it's true
                          if (widget.closeSearchOnSuffixTap) {
                            unfocusKeyboard();
                            setState(() {
                              toggle = 0;
                              widget.onToggle(toggle);
                            });
                          }
                        } catch (e) {
                          ///print the error if the try block fails
                          print(e);
                        }
                      },

                      ///suffixIcon is of type Icon
                      child: widget.suffixIcon ??
                          Icon(
                            Icons.close,
                            size: 20,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              left: (toggle == 0) ? 20.0 : 40.0,
              curve: Curves.easeOut,
              top: MediaQuery.of(context).size.height * 0.0185,

              ///Using Animated opacity to change the opacity of th textField while expanding
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: SizedBox(
                  width: widget.width / 1.7,
                  child: TextField(
                    ///Text Controller. you can manipulate the text inside this textField by calling this controller.
                    controller: widget.textController,
                    inputFormatters: widget.inputFormatters,
                    focusNode: focusNode,
                    cursorRadius: const Radius.circular(10.0),
                    cursorWidth: 2.0,
                    onChanged: (value) {
                      textFieldValue = value;
                    },
                    onSubmitted: (value) => {
                      widget.onSubmitted(value),
                      unfocusKeyboard(),
                      setState(() {
                        toggle = 0;
                        widget.onToggle(toggle);
                      }),
                      widget.textController.clear(),
                    },
                    onEditingComplete: () {
                      /// on editing complete the keyboard will be closed and the search bar will be closed
                      unfocusKeyboard();
                      setState(() {
                        toggle = 0;
                      });
                    },

                    ///style is of type TextStyle, the default is just a color black
                    style: widget.style ??
                        TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                    cursorColor: Theme.of(context).colorScheme.onBackground,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 5),
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: widget.helpText,
                      hintStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.7),
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            ///Using material widget here to get the ripple effect on the prefix icon
            Material(
              /// can add custom color or the color will be white
              /// toggle button color based on toggle state
              color:
                  toggle == 0 ? Theme.of(context).colorScheme.background : null,
              borderRadius: BorderRadius.circular(1000),

              child: Container(
                  child: toggle == 0
                      ? IconButton(
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          alignment: Alignment.center,

                          ///if toggle is 1, which means it's open. so show the back icon, which will close it.
                          ///if the toggle is 0, which means it's closed, so tapping on it will expand the widget.
                          ///prefixIcon is of type Icon
                          icon: Center(
                            child: Icon(
                              Icons.add,
                              color: Theme.of(context).colorScheme.onBackground,
                              size: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                          onPressed: () {
                            setState(
                              () {
                                ///if the search bar is closed
                                if (toggle == 0) {
                                  toggle = 1;
                                  widget.onToggle(toggle);
                                  setState(() {
                                    ///if the autoFocus is true, the keyboard will pop open, automatically
                                    if (widget.autoFocus) {
                                      FocusScope.of(context)
                                          .requestFocus(focusNode);
                                    }
                                  });

                                  ///forward == expand
                                  _con.forward();
                                } else {
                                  ///if the search bar is expanded
                                  toggle = 0;
                                  widget.onToggle(toggle);

                                  ///if the autoFocus is true, the keyboard will close, automatically
                                  setState(() {
                                    if (widget.autoFocus) unfocusKeyboard();
                                  });

                                  ///reverse == close
                                  _con.reverse();
                                }
                              },
                            );
                          },
                        )
                      : const SizedBox()),
            ),
          ],
        ),
      ),
    );
  }
}
