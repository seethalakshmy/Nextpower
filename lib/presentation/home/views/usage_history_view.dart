import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/infrastructure/widgets/text/list_title_widget.dart';
import 'package:project/infrastructure/widgets/text/subtitle_widget.dart';
import 'package:project/presentation/empty_list_view.dart';
import 'package:project/presentation/home/controllers/home.controller.dart';
import 'package:project/presentation/home/models/usage_history_list_model.dart';
import 'package:project/presentation/station.details/widgets/title_subtitle_column_row.dart';

class UsageHistoryView extends GetView<HomeController> {
  const UsageHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _OptionsWidgetSection(),
        Expanded(
          child: Obx(
            () => controller.historyLoading.value
                ? LoadingWidget(
                    strokeWidth: 2,
                    strokeColor: AppColors.primaryGreen,
                  )
                : controller.usageHistoryList.isNotEmpty
                    ? const _ListContentSection()
                    : EmptyListView(
                        subTitle: 'No Histories yet', title: "Oops"),
          ),
        )
      ],
    );
  }
}

class _ListContentSection extends GetView<HomeController> {
  const _ListContentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView.builder(
          itemCount: controller.usageHistoryList.length,
          itemBuilder: (context, index) {
            final history = controller.usageHistoryList[index];
            return Container(
              // elevation: 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.dropShadow,
                    blurRadius: 10.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: const Offset(
                      5.0, // Move to right 10  horizontally
                      5.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10, top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _HeaderWidget(history: history),
                        _ArrowWidget(id: history.id ?? 0)
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    _TimeViews(history: history),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class _OptionsWidgetSection extends GetView<HomeController> {
  const _OptionsWidgetSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: BoxDecoration(
        color: AppColors.optionsNotSelectedColor,
        border: Border.all(color: AppColors.optionsNotSelectedColor),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _OptionsView(
            text: LocaleKeys.success,
            currentIndex: controller.successHistory,
          ),
          _OptionsView(
            text: LocaleKeys.pendingInvoice,
            currentIndex: controller.pendingHistory,
          )
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    super.key,
    required this.history,
  });

  final UsageHistory history;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTitleWidget(
              title:
                  "${(translate(LocaleKeys.id)).toUpperCase()}: ${history.id}"),
          Wrap(
            children: [
              SubtitleWidget(
                  subtitle: "${translate(LocaleKeys.totalCost)}:",
                  fontWeight: FontWeight.w400),
              const SizedBox(width: 5),
              SubtitleWidget(
                subtitle: "${history.totalCost}",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ArrowWidget extends StatelessWidget {
  const _ArrowWidget({required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          NavigationUtils().callHistoryDetails(id);
        },
        icon: Icon(
          Icons.keyboard_arrow_right,
          color: AppColors.primaryBlue,
        ));
  }
}

class _TimeViews extends StatelessWidget {
  const _TimeViews({
    super.key,
    required this.history,
  });

  final UsageHistory history;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TitleSubtitleColumnRowWidget(
                title: translate(LocaleKeys.startTime),
                subtitle: history.startTime ?? "",
                showAsColumn: true)),
        Expanded(
            child: TitleSubtitleColumnRowWidget(
                title: translate(LocaleKeys.endTime),
                subtitle: history.endTime ?? "",
                showAsColumn: true))
      ],
    );
  }
}

class _OptionsView extends GetView<HomeController> {
  const _OptionsView({
    required this.text,
    required this.currentIndex,
    super.key,
  });

  final String text;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.setHistorySelectedIndex(currentIndex);
        },
        child: Obx(() => Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: currentIndex == controller.historySelectedIndex.value
                    ? AppColors.primaryGreen
                    : AppColors.optionsNotSelectedColor,
                border: Border.all(color: AppColors.optionsNotSelectedColor),
                borderRadius: BorderRadius.circular(30),
              ),
              alignment: Alignment.center,
              child: SubtitleWidget(
                subtitle: translate(text),
                fontWeight: FontWeight.w600,
                textColor: currentIndex == controller.historySelectedIndex.value
                    ? Colors.white
                    : AppColors.btmTextColor,
                fontSize: 17,
              ),
            )),
      ),
    );
  }
}