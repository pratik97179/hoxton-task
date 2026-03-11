import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/components/app_card.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/features/home/home_constants.dart';
import 'package:hoxton_task/features/home/presentation/widgets/home_asset_row.dart';

/// Assets section with header ("Assets" + add icon) and list of asset rows.
class HomeAssetListSection extends StatelessWidget {
  const HomeAssetListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.spacing16,
              AppSpacing.spacing16,
              AppSpacing.spacing16,
              AppSpacing.spacing8,
            ),
            child: Row(
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
          ),
          HomeAssetRow(
            icon: Icons.account_balance_outlined,
            title: HomeConstants.cashAccountsLabel,
            value: HomeConstants.cashAccountsValue,
            showAddButton: true,
          ),
          HomeAssetRow(
            icon: Icons.show_chart,
            title: HomeConstants.investmentsLabel,
            value: HomeConstants.investmentsValue,
          ),
          HomeAssetRow(
            icon: Icons.savings_outlined,
            title: HomeConstants.pensionsLabel,
            value: HomeConstants.pensionsValue,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.spacing8),
            child: HomeAssetRow(
              icon: Icons.home_outlined,
              title: HomeConstants.propertiesLabel,
              value: HomeConstants.propertiesValue,
              showAddButton: true,
            ),
          ),
        ],
      ),
    );
  }
}
