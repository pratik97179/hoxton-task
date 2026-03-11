abstract final class HomeConstants {
  HomeConstants._();

  static const String netWorthTitle = 'Net Worth';
  static const String netWorthValue = 'USD 12,000.00';
  static const String netWorthChange = 'USD 234,567.89 (6.89%)';
  static const String lastUpdated = 'Last updated 9 hours ago';

  static const List<String> timeRangeLabels = [
    '1W',
    '1M',
    '6M',
    '1Y',
    'YTD',
    'Max',
  ];
  static const int selectedTimeRangeIndex = 0;

  static const String assetsLabel = 'Assets';
  static const String liabilitiesLabel = 'Liabilities';
  static const String assetsValue = '£0';
  static const String liabilitiesValue = '£0';

  static const String cashAccountsLabel = 'Cash accounts';
  static const String cashAccountsValue = '£0';
  static const String investmentsLabel = 'Investments';
  static const String investmentsValue = '£0';
  static const String pensionsLabel = 'Pensions';
  static const String pensionsValue = '£0';
  static const String propertiesLabel = 'Properties';
  static const String propertiesValue = '£0';
  static const String addAssetButtonLabel = 'Add';

  static const String homeCashSvg = 'assets/images/svg/home_cash.svg';
  static const String homeInvestmentsSvg =
      'assets/images/svg/home_investments.svg';
  static const String homePensionsSvg = 'assets/images/svg/home_pensions.svg';
  static const String homePropertiesSvg =
      'assets/images/svg/home_properties.svg';
  static const String homeForecastSvg = 'assets/images/svg/home_forecast.svg';
  static const String homeWatchlistSvg = 'assets/images/svg/home_watchlist.svg';
  static const String homeVaultSvg = 'assets/images/svg/home_vault.svg';

  static const String liabilitiesEmptyMessage = 'No liabilities yet';

  static const String forecastTitle = 'Forecast';
  static const String forecastDescription =
      'See how your wealth could grow over time. WealthFlow helps you forecast future projections based on your assets, growth assumptions, and inflation trends.';
  static const String forecastButtonLabel = 'Create Wealth Forecast';
  static const String watchlistTitle = 'Watchlist';
  static const String watchlistDescription =
      'Track stocks, ETFs, crypto, and currencies—all in one place. Stay updated with market shifts';
  static const String watchlistButtonLabel = 'Start Tracking';

  static const String newsArticleTitle = 'Market update';
  static const String newsArticleDescription =
      'Latest market news and insights.';
  static const int newsCarouselDotCount = 3;
  static const int newsCarouselSelectedIndex = 0;

  static const String servicesTitle = 'Services';
  static const String servicesDescription =
      'Speak with an expert to receive help in achieving your goals';
  static const String vaultTitle = 'Vault';
  static const String vaultDescription =
      'Store your documents securely, only you can access them';

  static const String navHome = 'Home';
  static const String navAssetsLiabilities = 'Assets & Liabilities';
  static const String navWealthFlow = 'WealthFlow';
  static const String navMyHoxton = 'My Hoxton';

  static const String navHomeSvg = 'assets/images/svg/nav_home.svg';
  static const String navAssetsSvg = 'assets/images/svg/nav_assets.svg';
  static const String navWealthflowSvg = 'assets/images/svg/nav_wealthflow.svg';
  static const String navMyhoxtonSvg = 'assets/images/svg/nav_myhoxton.svg';
}
