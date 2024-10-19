import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class Tuple<T1, T2> {
  final T1 item1;
  final T2 item2;

  const Tuple(this.item1, this.item2);
}

class AnimatedSearchBar extends StatefulWidget {
  final bool isOpen;
  final Duration duration;
  final VoidCallback onTap;
  final IconData openIcon;
  final IconData closedIcon;
  final double iconSize;
  final Color iconColor;
  final Color backgroundColor;
  final double radius;
  final Duration? fadeDuration;
  final Tuple<double, double> searchBarWidth;
  final TextEditingController searchController;

  const AnimatedSearchBar({
    super.key,
    required this.isOpen,
    required this.duration,
    required this.onTap,
    required this.openIcon,
    required this.closedIcon,
    required this.searchController,
    this.iconSize = 100,
    this.iconColor = Colors.white,
    this.backgroundColor = Colors.black,
    this.radius = 75.0,
    this.fadeDuration,
    required this.searchBarWidth,
  });

  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _opacityAnimation = widget.fadeDuration != null
        ? Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Interval(
                0.0,
                (widget.fadeDuration!.inMilliseconds /
                        widget.duration.inMilliseconds)
                    .clamp(0.0, 1.0),
                curve: Curves.easeInOut,
              ),
            ),
          )
        : Tween<double>(begin: 1.0, end: 1.0).animate(_controller);

    final searchBarWidth = widget.searchBarWidth;
    _widthAnimation = Tween<double>(
      begin: searchBarWidth.item1,
      end: searchBarWidth.item2,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.isOpen) {
      _controller.value = 0;
    } else {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(AnimatedSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen != oldWidget.isOpen) {
      if (widget.isOpen) {
        _controller.animateTo(0, duration: global.standardAnimationDuration);
      } else {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            alignment: widget.isOpen ? Alignment.centerRight : Alignment.center,
            width: _widthAnimation.value,
            padding: widget.isOpen
                ? EdgeInsets.only(right: global.width(context) * .05)
                : const EdgeInsets.all(0),
            height: widget.radius * 2,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(widget.radius),
              boxShadow: [global.darkShadow(context)],
            ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                Widget animatedChild = child!;
                if (widget.fadeDuration != null) {
                  animatedChild = Opacity(
                    opacity: widget.isOpen ? _opacityAnimation.value : 1.0,
                    child: animatedChild,
                  );
                }
                return animatedChild;
              },
              child: widget.isOpen
                  ? SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: global.width(context) * .05,
                            ),
                            width: global.width(context) * .6,
                            child: TextField(
                              textAlignVertical: TextAlignVertical.center,
                              autofocus: true,
                              controller: widget.searchController,
                              decoration: InputDecoration(
                                isCollapsed: true,
                                hintText: 'Search',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(.5),
                                  fontSize: global.width(context) * .03,
                                ),
                              ),
                              cursorColor: Colors.white,
                            ),
                          ),
                          Icon(
                            widget.openIcon,
                            size: widget.iconSize,
                            color: widget.iconColor,
                          )
                        ],
                      ),
                    )
                  : Icon(
                      widget.closedIcon,
                      size: widget.iconSize,
                      color: widget.iconColor,
                    ),
            ),
          );
        },
      ),
    );
  }
}
