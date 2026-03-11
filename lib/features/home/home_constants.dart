abstract final class HomeConstants {
  HomeConstants._();

  static const String netWorthTitle = 'Net worth';
  static const String netWorthValue = '£0';
  static const String netWorthChange = '+0%';
  static const String lastUpdated = 'Last updated: --';

  static const List<String> timeRangeLabels = ['1W', '1M', '6M', '1Y', 'YTD', 'Max'];
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
  static const String homeWatchlistSvg =
      'assets/images/svg/home_watchlist.svg';
  static const String homeVaultSvg = 'assets/images/svg/home_vault.svg';

  static const String liabilitiesEmptyMessage = 'No liabilities yet';

  static const String forecastTitle = 'Forecast';
  static const String forecastDescription = 'See how your wealth could grow';
  static const String forecastButtonLabel = 'View forecast';
  static const String watchlistTitle = 'Watchlist';
  static const String watchlistDescription = 'Track your favourite assets';
  static const String watchlistButtonLabel = 'View watchlist';

  static const String newsArticleTitle = 'Market update';
  static const String newsArticleDescription =
      'Latest market news and insights.';
  static const int newsCarouselDotCount = 3;
  static const int newsCarouselSelectedIndex = 0;

  static const String servicesTitle = 'Services';
  static const String servicesDescription = 'Get support';
  static const String vaultTitle = 'Vault';
  static const String vaultDescription = 'Secure documents';

  static const String navHome = 'Home';
  static const String navAssetsLiabilities = 'Assets & Liabilities';
  static const String navWealthFlow = 'WealthFlow';
  static const String navMyHoxton = 'My Hoxton';

  static const String navHomeSvg = 'assets/images/svg/nav_home.svg';
  static const String navAssetsSvg = 'assets/images/svg/nav_assets.svg';
  static const String navWealthflowSvg =
      'assets/images/svg/nav_wealthflow.svg';
  static const String navMyhoxtonSvg = 'assets/images/svg/nav_myhoxton.svg';
}
