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
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.spacing12),
            child: _NetWorthValueBlock(home: home),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.spacing12),
            child: const _GraphCard(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.spacing16),
            child: const _TimeRangeChips(),
          ),
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
      mainAxisSize: MainAxisSize.min,
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
          mainAxisSize: MainAxisSize.min,
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

class _GraphCard extends StatelessWidget {
  const _GraphCard();

  static const double _chartHeight = 266;
  static const List<String> _yLabels = ['150K', '125K', '100K', '50K', '25K'];
  static const List<String> _xLabels = [
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _chartHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.spacing8),
      ),
      padding: const EdgeInsets.only(
        top: AppSpacing.spacing16,
        left: AppSpacing.spacing16,
        right: AppSpacing.spacing16,
        bottom: AppSpacing.spacing16,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const yLabelWidth = 32.0;
          const xLabelHeight = 20.0;
          final chartWidth = constraints.maxWidth - yLabelWidth;
          final chartHeight = constraints.maxHeight - xLabelHeight;
          return Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                bottom: xLabelHeight,
                width: chartWidth,
                child: CustomPaint(
                  painter: _NetWorthGraphPainter(),
                  size: Size(chartWidth, chartHeight),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: xLabelHeight,
                width: yLabelWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: _yLabels
                      .map(
                        (label) => Text(
                          label,
                          style: const TextStyle(
                            color: AppColors.coolGrey,
                            fontSize: 14,
                            height: 20 / 14,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Positioned(
                left: 0,
                right: yLabelWidth,
                bottom: 0,
                height: xLabelHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _xLabels
                      .map(
                        (label) => SizedBox(
                          width: 24,
                          child: Text(
                            label,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.coolGrey,
                              fontSize: 14,
                              height: 20 / 14,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _NetWorthGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const lineColor = AppColors.tertiary;
    final gridPaint = Paint()
      ..color = AppColors.greyGreenTint2
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final yTicks = 5;
    final chartTop = 0.0;
    final chartBottom = size.height;
    for (var i = 0; i <= yTicks; i++) {
      final y = chartTop + (chartBottom - chartTop) * i / yTicks;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final pts = _chartPoints(size);
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          lineColor.withValues(alpha: 0.25),
          lineColor.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final fillPath = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (var i = 1; i < pts.length; i++) {
      fillPath.lineTo(pts[i].dx, pts[i].dy);
    }
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);

    final linePath = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (var i = 1; i < pts.length; i++) {
      linePath.lineTo(pts[i].dx, pts[i].dy);
    }
    canvas.drawPath(linePath, linePaint);
  }

  List<Offset> _chartPoints(Size size) {
    final w = size.width;
    final h = size.height;
    final normalizedY = [0.167, 0.67, 0.6, 0.63, 0.8, 0.8, 1.0];
    return List.generate(7, (i) {
      final x = w * i / 6;
      final y = h * (1 - normalizedY[i]);
      return Offset(x, y);
    });
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Row(
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
      ),
    );
  }
}
