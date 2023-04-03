import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final Color? activeColor;
  final Color? inactiveColor;

  final ValueChanged<bool> onChanged;

  const CustomSwitch(
      {Key? key,
      required this.value,
      required this.onChanged,
      this.activeColor,
      this.inactiveColor})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerLeft : Alignment.centerRight,
            end: widget.value ? Alignment.centerRight : Alignment.centerLeft)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            // widget.value == false
            //     ? widget.onChanged(true)
            //     : widget.onChanged(false);
            widget.onChanged(!widget.value);
          },
          child: Container(
            width: 50.0,
            height: 26.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: _circleAnimation!.value == Alignment.centerRight
                  ? widget.activeColor ?? Colors.grey
                  : widget.inactiveColor ?? Colors.blue,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 7.0),
              child: Container(
                alignment: widget.value
                    ? ((Directionality.of(context) == TextDirection.rtl)
                        ? Alignment.centerLeft
                        : Alignment.centerRight)
                    : ((Directionality.of(context) == TextDirection.rtl)
                        ? Alignment.centerRight
                        : Alignment.centerLeft),
                child: Container(
                  width: 13.0,
                  height: 13.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}