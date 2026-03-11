import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/components/app_image.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/features/home/home_constants.dart';

class HomeAssetRow extends StatelessWidget {
  const HomeAssetRow({
    super.key,
    this.icon,
    this.iconSvgPath,
    required this.title,
    required this.value,
    this.showAddButton = false,
  }) : assert(
         icon != null || iconSvgPath != null,
         'Either icon or iconSvgPath must be provided',
       );

  final IconData? icon;
  final String? iconSvgPath;
  final String title;
  final String value;
  final bool showAddButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.spacing8),
      child: Row(
        children: [
          _IconCircle(icon: icon, iconSvgPath: iconSvgPath),
          const SizedBox(width: AppSpacing.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.captionGrey,
                    fontSize: 16,
                    height: 24 / 16,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.coolGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 26 / 18,
                  ),
                ),
              ],
            ),
          ),
          if (showAddButton)
            _AddChip()
          else
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.coolGrey),
        ],
      ),
    );
  }
}

class _IconCircle extends StatelessWidget {
  const _IconCircle({this.icon, this.iconSvgPath});

  final IconData? icon;
  final String? iconSvgPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        color: AppColors.secondaryAccent,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: iconSvgPath != null
          ? AppImage.svg(iconSvgPath!, width: 48, height: 48)
          : Icon(icon!, size: 24, color: AppColors.primaryBg),
    );
  }
}

class _AddChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing16,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryBg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        HomeConstants.addAssetButtonLabel,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 20 / 14,
        ),
      ),
    );
  }
}
