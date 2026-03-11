import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/features/home/data/models/home_model.dart';
import 'package:hoxton_task/features/home/home_constants.dart';
import 'package:hoxton_task/features/home/presentation/widgets/home_assets_liabilities_summary.dart';
import 'package:hoxton_task/features/home/presentation/widgets/home_asset_list_section.dart';
import 'package:hoxton_task/features/home/presentation/widgets/home_bottom_nav.dart';
import 'package:hoxton_task/features/home/presentation/widgets/home_cta_card.dart';
import 'package:hoxton_task/features/home/presentation/widgets/home_liabilities_section.dart';
import 'package:hoxton_task/features/home/presentation/widgets/home_net_worth_section.dart';
import 'package:hoxton_task/features/home/presentation/widgets/home_news_card.dart';
import 'package:hoxton_task/features/home/presentation/widgets/home_services_vault_cards.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key, this.home});

  final HomeModel? home;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: AppSpacing.spacing12,
              bottom: AppSpacing.spacing24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HomeNetWorthSection(home: home),
                const SizedBox(height: AppSpacing.spacing16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
                  child: HomeAssetsLiabilitiesSummary(home: home),
                ),
                const SizedBox(height: AppSpacing.spacing16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
                  child: HomeAssetListSection(),
                ),
                const SizedBox(height: AppSpacing.spacing16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
                  child: HomeLiabilitiesSection(home: home),
                ),
                const SizedBox(height: AppSpacing.spacing16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
                  child: HomeCtaCard(
                    icon: Icons.insights_outlined,
                    title: HomeConstants.forecastTitle,
                    description: HomeConstants.forecastDescription,
                    buttonLabel: HomeConstants.forecastButtonLabel,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacing16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
                  child: HomeCtaCard(
                    icon: Icons.visibility_outlined,
                    title: HomeConstants.watchlistTitle,
                    description: HomeConstants.watchlistDescription,
                    buttonLabel: HomeConstants.watchlistButtonLabel,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacing16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
                  child: const HomeServicesVaultCards(),
                ),
                const SizedBox(height: AppSpacing.spacing16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
                  child: HomeNewsCard(home: home),
                ),
              ],
            ),
          ),
        ),
        const HomeBottomNav(),
      ],
    );
  }
}
