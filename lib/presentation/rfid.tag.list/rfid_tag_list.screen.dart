import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/card/custom_card_view.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';
import 'package:project/presentation/station.details/widgets/title_subtitle_column_row.dart';
import '../../infrastructure/dal/models/rfid/rfid_response.dart';
import '../../infrastructure/widgets/text/subtitle_widget.dart';
import 'controllers/rfid_tag_list.controller.dart';

class RfidTagListScreen extends GetView<RfidTagListController> {
  const RfidTagListScreen({super.key});

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
                                  name: rfid.tagName ?? "",
                                  rfidStatus: controller
                                      .getStatus(rfid.tagStatus ?? "")
                                      .obs,
                                ),
                                const SizedBox(height: 5),
                                //_IssueDateAndStatusWidget(rfid: rfid),
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

class _RfidNameView extends GetView<RfidTagListController> {
  _RfidNameView(
      {super.key,
      required this.rfid,
      required this.name,
      required this.rfidStatus});

  final Rfid rfid;
  RxBool status = false.obs;
  String name;
  RxBool rfidStatus;
  FocusNode focusNode = FocusNode();
  final isLoadingForStatusChange = false.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Obx(
                () => TextFormField(
                  initialValue: rfid.tagName,
                  enabled: status.value,
                  focusNode: focusNode,
                  autofocus: status.value,
                  onChanged: (value) {
                    name = value;
                  },
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.labelColor2,
                  ),
                  decoration: status.value
                      ? const InputDecoration(border: UnderlineInputBorder())
                      : const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Obx(
              () => status.value
                  ? IconButton(
                      onPressed: () {
                        status.value = false;
                        final id = rfid.id.toString();
                        controller.changeRfidNameStatus(
                            id, name, rfidStatus.value);
                        focusNode.unfocus();
                      },
                      icon: const Icon(Icons.done),
                    )
                  : IconButton(
                      onPressed: () {
                        status.value = true;
                        Future.delayed(const Duration(milliseconds: 1), () {
                          focusNode.requestFocus();
                        });
                      },
                      icon: SvgImageUtils().showSvgFromAsset(Assets.iconsEdit),
                    ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SubtitleWidget(
                      subtitle: translate(LocaleKeys.status),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.iconColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  IntrinsicWidth(
                    child: Obx(
                      () {
                        return isLoadingForStatusChange.value
                            ? buildLoadingWidget()
                            : CupertinoSwitch(
                                activeColor: AppColors.primaryBlue,
                                value: rfidStatus.value,
                                onChanged: (value) async {
                                  //  if (status.value) {
                                  isLoadingForStatusChange.value = true;
                                  rfidStatus.value = !rfidStatus.value;
                                  final id = rfid.id.toString();
                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    controller
                                        .changeRfidNameStatus(
                                            id, name, rfidStatus.value)
                                        .then((value) {
                                      isLoadingForStatusChange.value = value;
                                    });
                                  });

                                  //  }
                                });
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget buildLoadingWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 28,
        width: 28,
        child: CircularProgressIndicator(
          color: AppColors.primaryBlue,
          strokeWidth: 1,
        ),
      ),
    );
  }
}
