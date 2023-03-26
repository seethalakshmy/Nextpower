import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/border_utils.dart';
import 'package:project/infrastructure/utils/input_formatter_utils.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/text/subtitle_widget.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';
import 'package:project/presentation/charging.session/controllers/charging_session.controller.dart';

class ChargingOptionsSection extends GetView<ChargingSessionController> {
  const ChargingOptionsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(
          title: translate(LocaleKeys.chargingOptions),
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: AppColors.labelColor2,
        ),
        const SizedBox(height: 20),
        const _ChargingOptionTitleSection(),
        const SizedBox(height: 10),
        Obx(() => Center(
              child: SubtitleWidget(
                subtitle: controller.getSubtitleText(),
                fontSize: 16,
              ),
            )),
        const SizedBox(height: 20),
        Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _AddSubtractWidget(
                icon: Icons.remove,
                iconBackground: AppColors.minusRed,
                onTap: () {
                  String text = controller.textController.text;
                  if (text.isEmpty) {
                    text = "0";
                  }
                  if (int.parse(text) <= 0) {
                    controller.textController.text = "0";
                    return;
                  }
                  controller.textController.text =
                      (int.parse(text) - 1).toString();
                },
              ),
              Container(
                width: 145,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: InputFormatterUtils().onlyNumber(),
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    border: CustomBorders().textFieldBorder(radius: 50),
                  ),
                  controller: controller.textController,
                ),
              ),
              _AddSubtractWidget(
                icon: Icons.add,
                iconBackground: AppColors.addGreen,
                onTap: () {
                  String text = controller.textController.text;
                  if (text.isEmpty) {
                    text = "0";
                  }
                  controller.textController.text =
                      (int.parse(text) + 1).toString();
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _AddSubtractWidget extends StatelessWidget {
  const _AddSubtractWidget({
    super.key,
    required this.icon,
    required this.onTap,
    required this.iconBackground,
  });

  final IconData icon;
  final GestureTapCallback onTap;
  final Color iconBackground;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: iconBackground, borderRadius: BorderRadius.circular(25.0)),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _ChargingOptionTitleSection extends GetView<ChargingSessionController> {
  const _ChargingOptionTitleSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: AppColors.optionsNotSelectedColor,
          borderRadius: const BorderRadius.all(Radius.circular(30.0))),
      child: Obx(
        () => Row(
          children: [
            _ChargingOptionItem(
              isOptionChosen: controller.selectedChargingOption.value ==
                  controller.moneyOptionValue,
              title: translate(LocaleKeys.money),
              onTap: () {
                controller.setSelectedOption(controller.moneyOptionValue);
              },
            ),
            _ChargingOptionItem(
              isOptionChosen: controller.selectedChargingOption.value ==
                  controller.timeOptionValue,
              title: translate(LocaleKeys.time),
              onTap: () {
                controller.setSelectedOption(controller.timeOptionValue);
              },
            ),
            _ChargingOptionItem(
              isOptionChosen: controller.selectedChargingOption.value ==
                  controller.energyOptionValue,
              title: translate(LocaleKeys.energy),
              onTap: () {
                controller.setSelectedOption(controller.energyOptionValue);
              },
            )
          ],
        ),
      ),
    );
  }
}

class _ChargingOptionItem extends StatelessWidget {
  const _ChargingOptionItem({
    super.key,
    required this.isOptionChosen,
    required this.title,
    required this.onTap,
  });

  final bool isOptionChosen;
  final String title;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
                color: isOptionChosen
                    ? AppColors.primaryGreen
                    : AppColors.optionsNotSelectedColor,
                borderRadius: const BorderRadius.all(Radius.circular(25.0))),
            height: 44,
            alignment: Alignment.center,
            child: Text(title)),
      ),
    );
  }
}