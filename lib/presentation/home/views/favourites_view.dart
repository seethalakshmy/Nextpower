import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/combo_widgets/station_brief_header_widget.dart';
import 'package:project/presentation/empty_list_view.dart';
import 'package:project/presentation/home/controllers/home.controller.dart';
import 'package:project/presentation/home/models/favorites_list_model.dart';

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
                        StationBriefHeaderWidget(
                          connectorPower:
                              "${favorites.kwh ?? ""} ${translate(LocaleKeys.kw)}",
                          connectorStatus: favorites.status ?? "",
                          stationName:
                              controller.favoritesList[index].stationName ?? "",
                          lat: controller.favoritesList[index].lat ?? 0,
                          long: controller.favoritesList[index].lat ?? 0,
                        ),
                      ],
                    ),
                  ));
            })
        : EmptyListView(
            subTitle: translate(LocaleKeys.noFavoritesYet),
            title: translate(LocaleKeys.sorry));
  }
}