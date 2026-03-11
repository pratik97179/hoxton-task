import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/components/app_card.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/features/home/data/models/home_model.dart';
import 'package:hoxton_task/features/home/home_constants.dart';

class HomeLiabilitiesSection extends StatelessWidget {
  const HomeLiabilitiesSection({super.key, this.home});

  final HomeModel? home;

  @override
  Widget build(BuildContext context) {
    final liabilities = home?.liabilities ?? [];
    final hasLiabilities = liabilities.isNotEmpty;
    return AppCard(
      child: hasLiabilities
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.spacing8),
                  child: Text(
                    HomeConstants.liabilitiesLabel,
                    style: const TextStyle(
                      color: AppColors.coolGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 28 / 20,
                    ),
                  ),
                ),
                ...liabilities.map(
                  (l) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.spacing8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            l.title,
                            style: const TextStyle(
                              color: AppColors.captionGrey,
                              fontSize: 16,
                              height: 24 / 16,
                            ),
                          ),
                        ),
                        Text(
                          l.value,
                          style: const TextStyle(
                            color: AppColors.coolGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            height: 26 / 18,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.spacing8),
                        Icon(Icons.arrow_forward_ios,
                            size: 16, color: AppColors.coolGrey),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        HomeConstants.liabilitiesLabel,
                        style: const TextStyle(
                          color: AppColors.coolGrey,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          height: 28 / 20,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        HomeConstants.liabilitiesEmptyMessage,
                        style: const TextStyle(
                          color: AppColors.captionGrey,
                          fontSize: 14,
                          height: 20 / 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.spacing16),
                Icon(Icons.arrow_forward_ios, size: 24, color: AppColors.coolGrey),
              ],
            ),
    );
  }
}
