import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/components/app_image.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/features/home/home_constants.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.greyGreenTint2)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppSpacing.spacing8,
            bottom: AppSpacing.spacing16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                iconSvgPath: HomeConstants.navHomeSvg,
                label: HomeConstants.navHome,
                isSelected: true,
              ),
              _NavItem(
                iconSvgPath: HomeConstants.navAssetsSvg,
                label: HomeConstants.navAssetsLiabilities,
              ),
              _NavItem(
                iconSvgPath: HomeConstants.navWealthflowSvg,
                label: HomeConstants.navWealthFlow,
              ),
              _NavItem(
                iconSvgPath: HomeConstants.navMyhoxtonSvg,
                label: HomeConstants.navMyHoxton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.iconSvgPath,
    required this.label,
    this.isSelected = false,
  });

  final String iconSvgPath;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppImage.svg(iconSvgPath, width: 24, height: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? AppColors.primaryBg : AppColors.coolGrey,
          ),
        ),
      ],
    );
  }
}
