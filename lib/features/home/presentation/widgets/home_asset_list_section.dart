import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/components/app_card.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/features/home/home_constants.dart';
import 'package:hoxton_task/features/home/presentation/widgets/home_asset_row.dart';

class HomeAssetListSection extends StatelessWidget {
  const HomeAssetListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                HomeConstants.assetsLabel,
                style: const TextStyle(
                  color: AppColors.coolGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 28 / 20,
                ),
              ),
              Icon(Icons.add_circle_outline, size: 24, color: AppColors.primaryBg),
            ],
          ),
          HomeAssetRow(
            iconSvgPath: HomeConstants.homeCashSvg,
            title: HomeConstants.cashAccountsLabel,
            value: HomeConstants.cashAccountsValue,
            showAddButton: true,
          ),
          HomeAssetRow(
            iconSvgPath: HomeConstants.homeInvestmentsSvg,
            title: HomeConstants.investmentsLabel,
            value: HomeConstants.investmentsValue,
          ),
          HomeAssetRow(
            iconSvgPath: HomeConstants.homePensionsSvg,
            title: HomeConstants.pensionsLabel,
            value: HomeConstants.pensionsValue,
          ),
          HomeAssetRow(
            iconSvgPath: HomeConstants.homePropertiesSvg,
            title: HomeConstants.propertiesLabel,
            value: HomeConstants.propertiesValue,
            showAddButton: true,
          ),
        ],
      ),
    );
  }
}
