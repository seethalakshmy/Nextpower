import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/views/custom_alert_view.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/card/custom_card_view.dart';
import 'package:project/infrastructure/widgets/custom_switch.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';
import 'package:project/presentation/station.details/widgets/title_subtitle_column_row.dart';

import '../../infrastructure/dal/models/rfid/rfid_response.dart';
import '../../infrastructure/widgets/text/subtitle_widget.dart';
import 'controllers/rfid_tag_list.controller.dart';

class RfidTagListScreen extends GetView<RfidTagListController> {
  const RfidTagListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(title: translate(LocaleKeys.rfidTag)),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            CustomSnackBar.showSuccessSnackBar(
                'Success', "Successfully requested new RFID tag");
          },
          child: Container(
              height: 62,
              color: AppColors.primaryBlue,
              alignment: Alignment.center,
              child: Wrap(
                alignment: WrapAlignment.center,
                direction: Axis.horizontal,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SvgImageUtils()
                          .showSvgFromAsset(Assets.iconsRequestRfidWhiteIcon)),
                  const SizedBox(
                    width: 10,
                  ),
                  TitleWidget(
                    title: translate(LocaleKeys.requestRfidTag),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  )
                ],
              )),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const LoadingWidget()
              : ListView(
                  children: [
                    const SizedBox(height: 10),
                    SvgImageUtils().showSvgFromAsset(Assets.iconsRfidTagCarIcon,
                        width: 150, height: 150),
                    // const SizedBox(height: 10),
                    CustomCardView(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.rfidList.value.rfids?.length ?? 0,
                        itemBuilder: (context, index) {
                          final rfid = controller.rfidList.value.rfids?[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Column(
                              children: [
                                _RfidNameView(
                                  rfid: rfid!,
                                ),
                                const SizedBox(height: 5),
                               // _IssueDateAndStatusWidget(rfid: rfid),
                                const SizedBox(height: 10),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ),
                    ),
                  ],
                ),
        ));
  }
}

class _IssueDateAndStatusWidget extends GetView<RfidTagListController> {
  const _IssueDateAndStatusWidget({
    super.key,
    required this.rfid,
  });

  final Rfid rfid;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TitleSubtitleColumnRowWidget(
              title: translate(LocaleKeys.issuedDate),
              subtitle: rfid.tagIssuedDate ?? "",
              showAsColumn: true),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubtitleWidget(
                subtitle: translate(LocaleKeys.status),
                fontSize: 15,
                fontWeight: FontWeight.w400,
                textColor: AppColors.iconColor,
              ),
              const SizedBox(height: 5),
              Obx(() => IntrinsicWidth(
                    child: CustomSwitch(
                      value: rfid.tagStatus == "Active" ? true:false,
                      onChanged: (value) {
                        print(value);
                        if (rfid.tagStatus == "Active") {
                          Get.dialog(CustomAlertView(
                            title: translate(
                                LocaleKeys.doYouReallyWantMakeYourRFIDInactive),
                            onPositiveTap: () {
                             // rfid.tagStatus(false);
                              NavigationUtils().goBack(closeOverlays: false);
                            },
                            onNegativeTap: () {
                             // rfid.tagStatus(true);
                              NavigationUtils().goBack(closeOverlays: false);
                            },
                          ));
                          // rfid.tagStatus(value);
                        } else {
                         // rfid.tagStatus(true);
                        }
                      },
                      // activeColor: AppColors.primaryBlue,
                      // inactiveColor: AppColors.switchInactiveColor,
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

class _RfidNameView extends GetView<RfidTagListController> {
  const _RfidNameView({
    super.key,
    required this.rfid,
  });

  final Rfid rfid;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Obx(() => TextFormField(
                initialValue: rfid.tagName,
                enabled: false, //rfid.isNameEditable.value,
                //focusNode: "",//rfid.focusNode,
                //autofocus: rfid.isNameEditable.value,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.labelColor2),
                decoration: const InputDecoration(border: InputBorder.none),
              )),
        ),
        const SizedBox(width: 10),
        // Obx(() => rfid.isNameEditable.value
        //     ? IconButton(
        //         onPressed: () {
        //          // rfid.isNameEditable(false);
        //         },
        //         icon: const Icon(Icons.done),
        //       )
        //     : IconButton(
        //         onPressed: () {
        //          // rfid.isNameEditable(true);
        //
        //          // FocusScope.of(context).requestFocus(rfid.focusNode);
        //         },
        //         icon: SvgImageUtils().showSvgFromAsset(Assets.iconsEdit),
        //       ))
      ],
    );
  }
}