import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/components/app_card.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/features/home/data/models/home_model.dart';
import 'package:hoxton_task/features/home/home_constants.dart';

class HomeAssetsLiabilitiesSummary extends StatelessWidget {
  const HomeAssetsLiabilitiesSummary({super.key, this.home});

  final HomeModel? home;

  static const double _separatorHeight = 3;

  @override
  Widget build(BuildContext context) {
    final assetsValue = home?.assetsTotalDisplay ?? HomeConstants.assetsValue;
    final liabilitiesValue =
        home?.liabilitiesTotalDisplay ?? HomeConstants.liabilitiesValue;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.spacing16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  HomeConstants.assetsLabel,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.coolGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 26 / 18,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  HomeConstants.liabilitiesLabel,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.coolGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 26 / 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spacing12),
          Container(
            height: _separatorHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.successDark,
              borderRadius: BorderRadius.circular(_separatorHeight / 2),
            ),
          ),
          const SizedBox(height: AppSpacing.spacing12),
          Row(
            children: [
              Expanded(
                child: Text(
                  assetsValue,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.coolGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    height: 28 / 22,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  liabilitiesValue,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.coolGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    height: 28 / 22,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
