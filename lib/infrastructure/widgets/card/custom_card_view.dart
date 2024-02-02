import 'package:flutter/material.dart';

class CustomCardView extends StatelessWidget {
  const CustomCardView(
      {Key? key, required this.child, this.padding,this.color, this.margin})
      : super(key: key);
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 20),
      elevation: 30,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0.0),
        child: child,
      ),
    );
  }
}