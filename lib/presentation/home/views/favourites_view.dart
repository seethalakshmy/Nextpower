import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/views/custom_alert_view.dart';
import 'package:project/infrastructure/widgets/buttons/rounded_outline_button.dart';
import 'package:project/infrastructure/widgets/buttons/rounded_rectangle_button.dart';
import 'package:project/infrastructure/widgets/combo_widgets/title_power_status_combo_widget.dart';
import 'package:project/presentation/empty_list_view.dart';
import 'package:project/presentation/home/controllers/home.controller.dart';
import 'package:project/presentation/station.details/widgets/station_brief_details_widget.dart';

import '../../../infrastructure/dal/models/favorites/favorites_model.dart';

class FavouritesView extends GetView<HomeController> {
  const FavouritesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Obx(() => controller.favoritesList.isNotEmpty
        ? ListView.builder(
            itemCount: controller.favoritesList.length,
            itemBuilder: (context, index) {
              Favorite favorites = controller.favoritesList[index];
              return Card(
                  elevation: 2,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TitlePowerStatusComboWidget(
                                  title: favorites.stationName ?? "",
                                  titleFontSize: 18,
                                  power:  "",
                                  status: favorites.stationStatus ?? ""),
                            ),
                            IconButton(
                                padding: const EdgeInsets.only(
                                    top: 8, left: 8, bottom: 8),
                                onPressed: () {

                                  Get.dialog(
                                    CustomAlertView(
                                      title: translate(LocaleKeys.do_you_really_want_to_delete),
                                      onPositiveTap: (){
                                        final int stationId = controller.favoritesList[index].stationId?.toInt() ?? 0;
                                        NavigationUtils().goBack();
                                        controller.removeFavorite(stationId);
                                      },
                                      positiveButtonRightAlign: true,
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: AppColors.iconColor,
                                )),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        Row(
                          children: [
                            ContentItem(
                              title: translate(LocaleKeys.distance),
                              value:  "",
                              bgColor: Colors.transparent,
                              textColor: AppColors.btmTextColor,
                              alignment: Alignment.centerLeft,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                            const SizedBox(width: 5),
                            ContentItem(
                              title: translate(LocaleKeys.free),
                              value: "",//(favorites.free ?? 0).toString(),
                              bgColor: Colors.transparent,
                              textColor: AppColors.btmTextColor,
                              alignment: Alignment.centerLeft,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                            const SizedBox(width: 5),
                            ContentItem(
                              title: translate(LocaleKeys.active),
                              value:"",// (favorites.active ?? 0).toString(),
                              bgColor: Colors.transparent,
                              textColor: AppColors.btmTextColor,
                              alignment: Alignment.centerLeft,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: RoundedRectangleButton(
                                textSize: 15,
                                asset: Assets.iconsChargeWhiteIcon,
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  NavigationUtils().callStationDetails(
                                      favorites.stationId ?? 0);
                                },
                                text: translate(LocaleKeys.details),
                                height: 50,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: RoundedOutlineButton(
                                asset: Assets.iconsDirection,
                                assetHeight: 24,
                                onPressed: () {
                                  NavigationUtils().callGoogleMap(
                                      favorites.latitude ?? 0, favorites.longitude ?? 0);
                                },
                                text: translate(LocaleKeys.direction),
                                height: 50,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ));
            })
        : EmptyListView(
            subTitle: translate(LocaleKeys.noFavoritesYet),
            title: translate(LocaleKeys.sorry)));
  }
}