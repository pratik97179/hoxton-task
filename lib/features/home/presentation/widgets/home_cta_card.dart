import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/components/app_button.dart';
import 'package:hoxton_task/core/design/components/app_image.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';

class HomeCtaCard extends StatelessWidget {
  const HomeCtaCard({
    super.key,
    this.icon,
    this.iconSvgPath,
    required this.title,
    required this.description,
    required this.buttonLabel,
  }) : assert(icon != null || iconSvgPath != null,
            'Either icon or iconSvgPath must be provided');

  final IconData? icon;
  final String? iconSvgPath;
  final String title;
  final String description;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white),
      padding: const EdgeInsets.all(AppSpacing.spacing16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _IconCircle(icon: icon, iconSvgPath: iconSvgPath),
          const SizedBox(height: AppSpacing.spacing16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.coolGrey,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 26 / 18,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.captionGrey,
              fontSize: 14,
              height: 20 / 14,
            ),
          ),
          const SizedBox(height: AppSpacing.spacing16),
          AppButton(label: buttonLabel, onPressed: () {}),
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
