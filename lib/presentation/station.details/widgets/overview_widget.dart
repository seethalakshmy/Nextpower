import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/station_details/station_details_model.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';
import 'package:project/presentation/empty_list_view.dart';
import 'package:project/presentation/my.address/widgets/show_address_widget.dart';
import 'package:project/presentation/station.details/controllers/station_details.controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../infrastructure/navigation/navigation_utils.dart';
import '../../../infrastructure/widgets/loaders/loading_widget.dart';

class OverviewWidget extends GetView<StationDetailsController> {
  const OverviewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (controller.stationDetails.value.stationId != null) {
      //Overview overview = controller.details!.overview!;

      return Column(
        children: [
          _IconsRow(
            controller: controller,
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _OverviewDetailsWidget(
                    station: controller.stationDetails.value),
                const SizedBox(height: 20),
                const _AmenitiesWidget(),
                const SizedBox(height: 20),
              ],
            ),
          )
        ],
      );
    } else {
      return EmptyListView(
          subTitle: translate(LocaleKeys.noDataFound),
          title: translate(LocaleKeys.oops));
    }
  }
}

class _AmenitiesWidget extends GetView<StationDetailsController> {
  const _AmenitiesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String amenities = controller.stationDetails.value.amenities!.join(" | ");
    return (controller.stationDetails.value.amenities != null)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: translate(LocaleKeys.amenities),
                fontWeight: FontWeight.bold,
                color: AppColors.btmTextColor,
                fontSize: 17,
              ),
              const SizedBox(
                height: 10,
              ),
              _LabelWidget(label: amenities)
            ],
          )
        : Container();
  }
}

class _OverviewDetailsWidget extends StatelessWidget {
  const _OverviewDetailsWidget({super.key, required this.station});

  final Station station;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShowAddressWidget(
            addressLine1: station.address?.addressLine1 ?? "",
            addressLine2: station.address?.addressLine2 ?? "",
            city: station.address?.city ?? "",
            country: station.address?.countryName ?? "",
            state: station.address?.stateName ?? "",
            postalCode: station.address?.postalCode ?? ""),
        const SizedBox(height: 10),
        SmallIconLabelWidget(
          assetPath: Assets.iconsTime,
          label: station.overview?.openTime ?? "",
        ),
        const SizedBox(height: 10),
        SmallIconLabelWidget(
          assetPath: Assets.iconsCallBig,
          label: station.overview?.mobileNumber ?? "",
        ),
        const SizedBox(height: 10),
        SmallIconLabelWidget(
          assetPath: Assets.iconsEmail,
          label: station.mailId ?? "",
        ),
      ],
    );
  }
}

class SmallIconLabelWidget extends StatelessWidget {
  const SmallIconLabelWidget({
    super.key,
    required this.assetPath,
    required this.label,
  });

  final String assetPath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgImageUtils().showSvgFromAsset(assetPath, width: 20, height: 20),
        const SizedBox(width: 10),
        _LabelWidget(label: label)
      ],
    );
  }
}

class _LabelWidget extends StatelessWidget {
  const _LabelWidget({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(color: AppColors.iconColor, fontSize: 16),
    );
  }
}

class _IconsRow extends StatelessWidget {
  const _IconsRow({
    super.key,
    required this.controller,
  });

  final StationDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _IconsLabelWidget(
            asset: Assets.iconsDirection,
            label: LocaleKeys.direction,
            onTap: () {
              NavigationUtils().callGoogleMap(
                  controller.stationDetails.value.overview?.latitude ?? 0.0,
                  controller.stationDetails.value.overview?.longitude ?? 0.0);
            },
          ),
          _IconsLabelWidget(
            asset: Assets.iconsShareBig,
            label: LocaleKeys.share,
            onTap: () {},
          ),
          _IconsLabelWidget(
            asset: Assets.iconsCallBig,
            label: LocaleKeys.call,
            onTap: () {
              _makePhoneCall(
                  controller.stationDetails.value.overview?.mobileNumber ?? "");
            },
          ),
          Obx(() => FavoritesWidget(
            loading:controller.isFavoritesLoading.value,
                    asset: controller.isFavorite.value
                        ? Assets.iconsFavFillHeart
                        : Assets.iconsFavouriteBig,
                    onTap: () {
                      controller.removeAddFavorite(controller.stationId,
                          controller.isFavorite.value ? 0 : 1);
                    },
                  )
              )
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}

class _IconsLabelWidget extends StatelessWidget {
  const _IconsLabelWidget({
    required this.asset,
    required this.label,
    required this.onTap,
  });

  final String asset;
  final String label;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SvgImageUtils().showSvgFromAsset(asset, width: 28, height: 28),
          const SizedBox(height: 10),
          TitleWidget(
            title: translate(label),
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }
}

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({
    required this.asset,
    required this.onTap,
    this.loading = false,
  });

  final bool loading;
  final String asset;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          loading
              ? buildLoadingWidget()
              : SvgImageUtils().showSvgFromAsset(asset, width: 28, height: 28),
          const SizedBox(height: 10),
          TitleWidget(
            title: translate(LocaleKeys.favourites),
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }

  Widget buildLoadingWidget() {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 28,
      width: 28,
      child: CircularProgressIndicator(
        color: AppColors.primaryBlue,
        strokeWidth: 1,
      ),
    );
  }
}
