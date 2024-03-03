import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/usage_history/UsageHistoryResponse.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/infrastructure/widgets/text/list_title_widget.dart';
import 'package:project/infrastructure/widgets/text/subtitle_widget.dart';
import 'package:project/presentation/empty_list_view.dart';
import 'package:project/presentation/home/controllers/home.controller.dart';
import 'package:project/presentation/station.details/widgets/title_subtitle_column_row.dart';

class UsageHistoryView extends GetView<HomeController> {
  const UsageHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                subTitle: translate(LocaleKeys.noDataFound),
                title: translate(LocaleKeys.sorry)),
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
                        _ArrowWidget(id: history.id?.toInt() ?? 0)
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

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    required this.history,
  });

  final UsageHistoryItem history;

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
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              const SizedBox(width: 5),
              SubtitleWidget(
                subtitle: "${history.totalCost}",
                fontSize: 16,
                textColor: AppColors.btmTextColor,
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

  final UsageHistoryItem history;

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