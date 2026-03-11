import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/core/di/injection.dart';
import 'package:hoxton_task/core/router/app_route_names.dart';
import 'package:hoxton_task/core/session/session_manager.dart';
import 'package:hoxton_task/features/home/data/models/home_model.dart';
import 'package:hoxton_task/features/home/home_constants.dart';

class HomeNetWorthSection extends StatelessWidget {
  const HomeNetWorthSection({super.key, this.home});

  final HomeModel? home;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NetWorthHeader(),
          const SizedBox(height: AppSpacing.spacing12),
          _NetWorthValueBlock(home: home),
          const SizedBox(height: AppSpacing.spacing12),
          const _GraphPlaceholder(),
          const SizedBox(height: AppSpacing.spacing16),
          const _TimeRangeChips(),
        ],
      ),
    );
  }
}

class _NetWorthHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          HomeConstants.netWorthTitle,
          style: const TextStyle(
            color: AppColors.captionGrey,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 24 / 18,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                size: 24,
                color: AppColors.coolGrey,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: AppSpacing.spacing16),
            IconButton(
              onPressed: () async {
                await sl<SessionManager>().clear();
                if (context.mounted) {
                  context.go(AppRouteNames.email);
                }
              },
              icon: const Icon(
                Icons.logout,
                size: 24,
                color: AppColors.coolGrey,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ],
    );
  }
}

class _NetWorthValueBlock extends StatelessWidget {
  const _NetWorthValueBlock({this.home});

  final HomeModel? home;

  @override
  Widget build(BuildContext context) {
    final netWorth = home?.netWorthDisplay ?? HomeConstants.netWorthValue;
    final change = home?.netWorthChangeDisplay ?? HomeConstants.netWorthChange;
    final updated = home?.lastUpdatedDisplay ?? HomeConstants.lastUpdated;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          netWorth,
          style: const TextStyle(
            color: AppColors.coolGrey,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 32 / 24,
          ),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Icon(Icons.trending_up, size: 20, color: AppColors.successDark),
            const SizedBox(width: 2),
            Text(
              change,
              style: const TextStyle(
                color: AppColors.successDark,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 20 / 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          updated,
          style: const TextStyle(
            color: AppColors.captionGrey,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 16 / 12,
          ),
        ),
      ],
    );
  }
}

class _GraphPlaceholder extends StatelessWidget {
  const _GraphPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 266,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.spacing8),
      ),
      padding: const EdgeInsets.all(AppSpacing.spacing16),
      child: CustomPaint(
        painter: _SimpleLineGraphPainter(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _SimpleLineGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pts = [
      Offset(size.width * 0.0, size.height * 0.85),
      Offset(size.width * 0.2, size.height * 0.7),
      Offset(size.width * 0.4, size.height * 0.5),
      Offset(size.width * 0.6, size.height * 0.35),
      Offset(size.width * 0.8, size.height * 0.2),
      Offset(size.width * 1.0, size.height * 0.1),
    ];
    final linePaint = Paint()
      ..color = AppColors.tertiary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.tertiary.withValues(alpha: 0.3),
          AppColors.tertiary.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (var i = 1; i < pts.length; i++) {
      path.lineTo(pts[i].dx, pts[i].dy);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(
      Path()
        ..moveTo(pts.first.dx, pts.first.dy)
        ..lineTo(pts[1].dx, pts[1].dy)
        ..lineTo(pts[2].dx, pts[2].dy)
        ..lineTo(pts[3].dx, pts[3].dy)
        ..lineTo(pts[4].dx, pts[4].dy)
        ..lineTo(pts[5].dx, pts[5].dy),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TimeRangeChips extends StatelessWidget {
  const _TimeRangeChips();

  @override
  Widget build(BuildContext context) {
    final labels = HomeConstants.timeRangeLabels;
    final selectedIndex = HomeConstants.selectedTimeRangeIndex;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(labels.length, (i) {
        final isSelected = i == selectedIndex;
        return Padding(
          padding: EdgeInsets.only(
            right: i < labels.length - 1 ? AppSpacing.spacing16 : 0,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing8,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryBg : AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              labels[i],
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.captionGrey,
                fontSize: 12,
                height: 16 / 12,
              ),
            ),
          ),
        );
      }),
    );
  }
}
