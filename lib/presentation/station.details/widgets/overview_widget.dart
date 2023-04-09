import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';
import 'package:project/presentation/empty_list_view.dart';
import 'package:project/presentation/my.address/widgets/show_address_widget.dart';
import 'package:project/presentation/station.details/controllers/station_details.controller.dart';
import 'package:project/presentation/station.details/models/station_details_model.dart';

class OverviewWidget extends GetView<StationDetailsController> {
  const OverviewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (controller.details!.overview != null) {
      Overview overview = controller.details!.overview!;

      return Column(
        children: [
          const _IconsRow(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _OverviewDetailsWidget(overview: overview),
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
    return (controller.getAmenities().isNotEmpty)
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
              _LabelWidget(label: controller.getAmenities())
            ],
          )
        : Container();
  }
}

class _OverviewDetailsWidget extends StatelessWidget {
  const _OverviewDetailsWidget({
    super.key,
    required this.overview,
  });

  final Overview overview;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShowAddressWidget(
            addressLine1: overview.address?.addressLine1 ?? "",
            addressLine2: overview.address?.addressLine2 ?? "",
            city: overview.address?.city ?? "",
            country: overview.address?.countryName ?? "",
            state: overview.address?.stateName ?? "",
            postalCode: overview.address?.postalCode ?? ""),
        const SizedBox(height: 10),
        SmallIconLabelWidget(
          assetPath: Assets.iconsTime,
          label: overview.openTime ?? "",
        ),
        const SizedBox(height: 10),
        SmallIconLabelWidget(
          assetPath: Assets.iconsCallBig,
          label: overview.mobileNumber ?? "",
        ),
        const SizedBox(height: 10),
        SmallIconLabelWidget(
          assetPath: Assets.iconsEmail,
          label: overview.mailId ?? "",
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
  const _IconsRow();

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
            onTap: () {},
          ),
          _IconsLabelWidget(
            asset: Assets.iconsShareBig,
            label: LocaleKeys.share,
            onTap: () {},
          ),
          _IconsLabelWidget(
            asset: Assets.iconsCallBig,
            label: LocaleKeys.call,
            onTap: () {},
          ),
          _IconsLabelWidget(
            asset: Assets.iconsFavouriteBig,
            label: LocaleKeys.favourites,
            onTap: () {},
          ),
        ],
      ),
    );
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
    return Column(
      children: [
        SvgImageUtils().showSvgFromAsset(asset, width: 28, height: 28),
        const SizedBox(height: 10),
        TitleWidget(
          title: translate(label),
          fontWeight: FontWeight.w600,
        )
      ],
    );
  }
}