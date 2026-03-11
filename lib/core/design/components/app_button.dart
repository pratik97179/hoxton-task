import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isEnabled = true,
  }) : _isBordered = false;

  const AppButton.bordered({
    super.key,
    required this.label,
    this.onPressed,
  })  : isEnabled = true,
        _isBordered = true;

  final String label;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool _isBordered;

  static const double _defaultVerticalPadding = 10;
  static const double _borderedVerticalPadding = 8;

  @override
  Widget build(BuildContext context) {
    if (_isBordered) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.white,
            side: const BorderSide(color: AppColors.white, width: 2),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing16,
              vertical: _borderedVerticalPadding,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.spacing8),
            ),
            backgroundColor: AppColors.primaryBg,
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
            vertical: _defaultVerticalPadding,
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

