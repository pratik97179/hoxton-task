import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/components/app_button.dart';
import 'package:hoxton_task/core/design/components/app_card.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';

/// Full-width CTA card: icon, title, description, and primary button.
class HomeCtaCard extends StatelessWidget {
  const HomeCtaCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonLabel,
  });

  final IconData icon;
  final String title;
  final String description;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _IconCircle(icon: icon),
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
  const _IconCircle({required this.icon});

  final IconData icon;

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
      child: Icon(icon, size: 24, color: AppColors.primaryBg),
    );
  }
}
