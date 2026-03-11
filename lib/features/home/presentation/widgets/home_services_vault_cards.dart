import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/components/app_card.dart';
import 'package:hoxton_task/core/design/components/app_image.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/features/home/home_constants.dart';

class HomeServicesVaultCards extends StatelessWidget {
  const HomeServicesVaultCards({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _SmallCard(
              icon: Icons.headset_mic_outlined,
              title: HomeConstants.servicesTitle,
              description: HomeConstants.servicesDescription,
            ),
          ),
          const SizedBox(width: AppSpacing.spacing16),
          Expanded(
            child: _SmallCard(
              iconSvgPath: HomeConstants.homeVaultSvg,
              title: HomeConstants.vaultTitle,
              description: HomeConstants.vaultDescription,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallCard extends StatelessWidget {
  const _SmallCard({
    this.icon,
    this.iconSvgPath,
    required this.title,
    required this.description,
  }) : assert(icon != null || iconSvgPath != null,
            'Either icon or iconSvgPath must be provided');

  final IconData? icon;
  final String? iconSvgPath;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
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
          ),
          const SizedBox(height: AppSpacing.spacing12),
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
          const SizedBox(height: 4),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.captionGrey,
              fontSize: 14,
              height: 20 / 14,
            ),
          ),
        ],
      ),
    );
  }
}
