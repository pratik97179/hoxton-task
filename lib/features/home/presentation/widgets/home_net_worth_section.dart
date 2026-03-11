import 'package:fl_chart/fl_chart.dart';
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
            Icon(
              Icons.arrow_upward_outlined,
              size: 20,
              color: AppColors.successDark,
            ),
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

  static const double _minY = 0;
  static const double _maxY = 150;
  static const double _minX = 11;
  static const double _maxX = 17;

  static final List<FlSpot> _chartSpots = [
    const FlSpot(11, 25),
    const FlSpot(12, 98),
    const FlSpot(13, 72),
    const FlSpot(14, 88),
    const FlSpot(15, 118),
    const FlSpot(16, 102),
    const FlSpot(17, 152),
  ];

  static const _axisLabelStyle = TextStyle(
    color: AppColors.coolGrey,
    fontSize: 14,
    height: 20 / 14,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _chartHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.spacing8),
      ),
      padding: const EdgeInsets.only(
        top: AppSpacing.spacing16,
        bottom: AppSpacing.spacing16,
      ),
      child: LineChart(
        LineChartData(
          minX: _minX,
          maxX: _maxX,
          minY: _minY,
          maxY: _maxY,
          gridData: FlGridData(
            show: true,
            verticalInterval: 25,
            horizontalInterval: (_maxY - _minY) / 4,
            getDrawingHorizontalLine: (_) =>
                FlLine(color: AppColors.captionGrey, strokeWidth: 1),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 44,
                interval: (_maxY - _minY) / 4,
                getTitlesWidget: (value, meta) {
                  const labels = ['', '25K', '50K', '100K', '125K', '150K'];
                  final index = ((value - _minY) / ((_maxY - _minY) / 4))
                      .round()
                      .clamp(0, 4);
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      labels[index],
                      style: _axisLabelStyle,
                      textAlign: TextAlign.right,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 20,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final label = value.toInt().toString();
                  return Text(
                    label,
                    style: _axisLabelStyle,
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineTouchData: const LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: _chartSpots,
              isCurved: true,
              curveSmoothness: 0.35,
              color: AppColors.primaryBg,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryBg.withValues(alpha: 0.3),
                    AppColors.primaryBg.withValues(alpha: 0.2),
                    AppColors.tertiary.withValues(alpha: 0.2),
                  ],
                  stops: [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 150),
      ),
    );
  }
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
