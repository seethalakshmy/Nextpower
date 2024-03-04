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
import 'package:project/presentation/empty_list_view.dart';
import 'package:project/presentation/home/controllers/home.controller.dart';
import '../../../infrastructure/dal/models/favorites/favorites_model.dart';
import '../../../infrastructure/widgets/text/title_widget.dart';

class FavouritesView extends GetView<HomeController> {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
    controller.favoritesList.isNotEmpty
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
                        Expanded(child: TitleWidget(
                          title: favorites.stationName ?? "",
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.textTitleColor,
                        ),),
                        IconButton(
                            padding: const EdgeInsets.only(
                                top: 8, left: 8, bottom: 8),
                            onPressed: () {
                              Get.dialog(
                                CustomAlertView(
                                  title: translate(LocaleKeys
                                      .do_you_really_want_to_delete),
                                  onPositiveTap: () {
                                    final int stationId = controller
                                        .favoritesList[index].stationId;
                                    NavigationUtils().goBack();
                                    controller
                                        .removeFavorite(stationId ?? 0);
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
                    Align(alignment: Alignment.bottomLeft,child: Text(favorites.stationAddress.addressLine1),
                    ),
                    Align(alignment: Alignment.bottomLeft,child: Text(favorites.stationAddress.addressLine2),
                    ),
                    Align(alignment: Alignment.bottomLeft,child: Text(favorites.stationAddress.city),
                    ),
                    Align(alignment: Alignment.bottomLeft,child: Text("Pin:${favorites.stationAddress.postalCode}"),
                    ),
                    Align(alignment: Alignment.bottomLeft,child: Text(favorites.stationAddress.stateName),
                    ),
                    Align(alignment: Alignment.bottomLeft,child: Text(favorites.stationAddress.countryName),
                    ),

                    const Divider(),
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
                                  favorites.latitude ?? 0,
                                  favorites.longitude ?? 0);
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
