import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/components/app_card.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/features/home/data/models/home_model.dart';
import 'package:hoxton_task/features/home/home_constants.dart';

/// Assets vs Liabilities summary card with two columns and underline on Assets.
class HomeAssetsLiabilitiesSummary extends StatelessWidget {
  const HomeAssetsLiabilitiesSummary({super.key, this.home});

  final HomeModel? home;

  @override
  Widget build(BuildContext context) {
    final assetsValue = home?.assetsTotalDisplay ?? HomeConstants.assetsValue;
    final liabilitiesValue =
        home?.liabilitiesTotalDisplay ?? HomeConstants.liabilitiesValue;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  HomeConstants.assetsLabel,
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
                  textAlign: TextAlign.right,
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
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 80,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.successDark,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  assetsValue,
                  style: const TextStyle(
                    color: AppColors.coolGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 26 / 18,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  liabilitiesValue,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: AppColors.coolGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 26 / 18,
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
