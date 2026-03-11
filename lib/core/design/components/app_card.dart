import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;

  static const EdgeInsets _defaultPadding = EdgeInsets.all(AppSpacing.spacing16);
  static const BorderRadius _defaultRadius = BorderRadius.all(Radius.circular(AppSpacing.spacing8));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: borderRadius ?? _defaultRadius,
      ),
      padding: padding ?? _defaultPadding,
      child: child,
    );
  }
}
