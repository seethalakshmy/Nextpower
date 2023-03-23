import 'package:flutter/material.dart';

import '../buttons/back_button.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar(
      {Key? key,
      required this.title,
      this.leading,
      this.onBackPressed,
      this.centerTitle,
      this.elevation})
      : super(key: key);

  final String title;
  final Widget? leading;
  final VoidCallback? onBackPressed;
  final bool? centerTitle;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
      ),
      centerTitle: centerTitle ?? false,
      leading: leading ??
          BackButtonAppbar(
            onBackPressed: onBackPressed,
          ),
      // actions: [
      //   Obx(() => controller.isEditable.value
      //       ? const SizedBox.shrink()
      //       : IconButton(
      //           onPressed: () {
      //             controller.setProfileEditable();
      //           },
      //           icon: SvgImageUtils().showSvgFromAsset(Assets.iconsEdit)))
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}