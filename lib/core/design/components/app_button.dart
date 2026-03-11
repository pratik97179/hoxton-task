import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isEnabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final VoidCallback? effectiveOnPressed =
        isEnabled && onPressed != null ? onPressed : null;

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: effectiveOnPressed,
        style: FilledButton.styleFrom(
          backgroundColor:
              isEnabled ? AppColors.primaryBg : AppColors.primaryBg.withValues(alpha: 0.4),
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spacing16,
            vertical: 10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.spacing8),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 24 / 16,
          ),
        ),
      ),
    );
  }
}

