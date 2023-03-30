import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/buttons/rounded_rectangle_button.dart';
import 'package:project/infrastructure/widgets/combo_widgets/title_power_status_combo_widget.dart';
import 'package:project/presentation/empty_list_view.dart';
import 'package:project/presentation/home/controllers/home.controller.dart';
import 'package:project/presentation/home/models/favorites_list_model.dart';
import 'package:project/presentation/station.details/widgets/station_brief_details_widget.dart';

class FavouritesView extends GetView<HomeController> {
  const FavouritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.favoritesList.isNotEmpty
        ? ListView.builder(
            itemCount: controller.favoritesList.length,
            itemBuilder: (context, index) {
              Favorites favorites = controller.favoritesList[index];
              return Card(
                  elevation: 2,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(
                      children: [
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: IconButton(
                        //       padding:
                        //           EdgeInsets.only(top: 8, left: 8, bottom: 8),
                        //       onPressed: () {
                        //         NavigationUtils().callScreenYetToBeDone();
                        //       },
                        //       icon: Icon(Icons.close)),
                        // ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TitlePowerStatusComboWidget(
                                  title: favorites.stationName ?? "",
                                  power:
                                      "${favorites.kwh ?? ""} ${translate(LocaleKeys.kw)}",
                                  status: favorites.status ?? ""),
                            ),

                            // Expanded(
                            //   child: StationBriefHeaderWidget(
                            //     connectorPower:
                            //         "${favorites.kwh ?? ""} ${translate(LocaleKeys.kw)}",
                            //     connectorStatus: favorites.status ?? "",
                            //     stationName: favorites.stationName ?? "",
                            //     lat: favorites.lat ?? 0,
                            //     long: favorites.lat ?? 0,
                            //   ),
                            // ),
                            IconButton(
                                padding:
                                    EdgeInsets.only(top: 8, left: 8, bottom: 8),
                                onPressed: () {
                                  NavigationUtils().callScreenYetToBeDone();
                                },
                                icon: Icon(Icons.close)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        Row(
                          children: [
                            ContentItem(
                              title: translate(LocaleKeys.distance),
                              value: favorites.distance ?? "",
                              bgColor: Colors.transparent,
                              textColor: AppColors.btmTextColor,
                              alignment: Alignment.centerLeft,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                            const SizedBox(width: 5),
                            ContentItem(
                              title: translate(LocaleKeys.free),
                              value: (favorites.free ?? 0).toString(),
                              bgColor: Colors.transparent,
                              textColor: AppColors.btmTextColor,
                              alignment: Alignment.centerLeft,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                            const SizedBox(width: 5),
                            ContentItem(
                              title: translate(LocaleKeys.active),
                              value: (favorites.active ?? 0).toString(),
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
                                  NavigationUtils().callScreenYetToBeDone();
                                },
                                text: translate(LocaleKeys.charge),
                                height: 50,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  NavigationUtils().callGoogleMap(
                                      favorites.lat ?? 0, favorites.long ?? 0);
                                },
                                icon: SvgImageUtils().showSvgFromAsset(
                                    Assets.iconsDirection,
                                    width: 24,
                                    height: 24))
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ));
            })
        : EmptyListView(
            subTitle: translate(LocaleKeys.noFavoritesYet),
            title: translate(LocaleKeys.sorry));
  }
}