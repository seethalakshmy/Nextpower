import 'package:flutter/material.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';

class BackButtonAppbar extends StatelessWidget {
  const BackButtonAppbar({
    Key? key,
    this.onBackPressed,
  }) : super(key: key);

  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: onBackPressed ??
          () {
            NavigationUtils().goBack();
          },
    );
  }
}