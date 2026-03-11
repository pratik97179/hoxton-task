/// Static copy and default values for the home screen.
abstract final class HomeConstants {
  HomeConstants._();

  // Net worth
  static const String netWorthTitle = 'Net worth';
  static const String netWorthValue = '£0';
  static const String netWorthChange = '+0%';
  static const String lastUpdated = 'Last updated: --';

  static const List<String> timeRangeLabels = ['1M', '3M', '6M', '1Y', 'All'];
  static const int selectedTimeRangeIndex = 0;

  // Assets & liabilities summary
  static const String assetsLabel = 'Assets';
  static const String liabilitiesLabel = 'Liabilities';
  static const String assetsValue = '£0';
  static const String liabilitiesValue = '£0';

  // Asset list
  static const String cashAccountsLabel = 'Cash accounts';
  static const String cashAccountsValue = '£0';
  static const String investmentsLabel = 'Investments';
  static const String investmentsValue = '£0';
  static const String pensionsLabel = 'Pensions';
  static const String pensionsValue = '£0';
  static const String propertiesLabel = 'Properties';
  static const String propertiesValue = '£0';
  static const String addAssetButtonLabel = 'Add';

  // Liabilities
  static const String liabilitiesEmptyMessage = 'No liabilities yet';

  // CTA cards
  static const String forecastTitle = 'Forecast';
  static const String forecastDescription = 'See how your wealth could grow';
  static const String forecastButtonLabel = 'View forecast';
  static const String watchlistTitle = 'Watchlist';
  static const String watchlistDescription = 'Track your favourite assets';
  static const String watchlistButtonLabel = 'View watchlist';

  // News
  static const String newsArticleTitle = 'Market update';
  static const String newsArticleDescription = 'Latest market news and insights.';
  static const int newsCarouselDotCount = 3;
  static const int newsCarouselSelectedIndex = 0;

  // Services & Vault
  static const String servicesTitle = 'Services';
  static const String servicesDescription = 'Get support';
  static const String vaultTitle = 'Vault';
  static const String vaultDescription = 'Secure documents';

  // Bottom nav
  static const String navHome = 'Home';
  static const String navAssetsLiabilities = 'Assets & Liabilities';
  static const String navWealthFlow = 'WealthFlow';
  static const String navMyHoxton = 'My Hoxton';
}
