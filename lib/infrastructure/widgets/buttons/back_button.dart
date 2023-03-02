
import 'package:flutter/material.dart';

class BackButtonAppbar extends StatelessWidget {
  const BackButtonAppbar({
    Key? key, required this.onBackPressed,
  }) : super(key: key);

  final VoidCallback onBackPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: onBackPressed,
    );
  }
}