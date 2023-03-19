import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyListView extends StatelessWidget {
  final String? assetPath;
  final IconData? icon;
  final String title;
  final String subTitle;
  final bool isAsset;
  final bool isIcon;
  final bool isExpanded;

  EmptyListView(
      {Key? key,
      this.assetPath,
      required this.subTitle,
      required this.title,
      this.isAsset = false,
      this.isIcon = false,
      this.icon,
      this.isExpanded = false})
      : assert((isAsset == true &&
                (assetPath != null || assetPath!.isNotEmpty)) ||
            ((isAsset == false) && (assetPath == null || assetPath.isEmpty))),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var isSvg = false;
    if (assetPath != null) {
      isSvg = assetPath!.split(".").last == ".svg";
    }
    if (isExpanded) {
      return Expanded(
        child: EmptyListViewContentWidget(
            isAsset: isAsset,
            assetPath: assetPath,
            isSvg: isSvg,
            isIcon: isIcon,
            icon: icon,
            title: title,
            subTitle: subTitle),
      );
    } else {
      return EmptyListViewContentWidget(
          isAsset: isAsset,
          assetPath: assetPath,
          isSvg: isSvg,
          isIcon: isIcon,
          icon: icon,
          title: title,
          subTitle: subTitle);
    }
  }
}

class EmptyListViewContentWidget extends StatelessWidget {
  const EmptyListViewContentWidget({
    Key? key,
    required this.isAsset,
    required this.assetPath,
    required this.isSvg,
    required this.isIcon,
    required this.icon,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final bool isAsset;
  final String? assetPath;
  final bool isSvg;
  final bool isIcon;
  final IconData? icon;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isAsset && (assetPath != null && assetPath!.isNotEmpty)
              ? Container(
                  child: isSvg
                      ? Column(
                          children: [
                            SvgPicture.asset(
                              assetPath!,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Image.asset(
                              assetPath!,
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                )
              : Container(),
          isIcon ? Icon(icon ?? Icons.inbox_rounded, size: 50) : Container(),
          if (isIcon || isAsset)
            SizedBox(
              height: 20,
            ),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
          Text(subTitle, textAlign: TextAlign.center)
        ],
      ),
    );
  }
}