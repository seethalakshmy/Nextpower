import 'package:flutter/material.dart';

class CustomCardView extends StatelessWidget {
  const CustomCardView(
      {Key? key,
      required this.child,
      this.padding,
      this.color,
      this.margin,
      this.radius})
      : super(key: key);
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 20),
      elevation: 30,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            radius ?? 10.0), // Adjust the radius as needed
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0.0),
        child: child,
      ),
    );
  }
}
