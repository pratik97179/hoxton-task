import 'package:hoxton_task/features/home/home_constants.dart';

class HomeModel {
  const HomeModel({
    this.netWorth,
    this.netWorthChange,
    this.lastUpdated,
    this.assetsTotal,
    this.liabilitiesTotal,
    this.assets = const [],
    this.liabilities = const [],
    this.news = const [],
  });

  final String? netWorth;
  final String? netWorthChange;
  final String? lastUpdated;
  final String? assetsTotal;
  final String? liabilitiesTotal;
  final List<HomeAssetItem> assets;
  final List<HomeLiabilityItem> liabilities;
  final List<HomeNewsItem> news;

  String get netWorthDisplay => netWorth ?? HomeConstants.netWorthValue;
  String get netWorthChangeDisplay =>
      netWorthChange ?? HomeConstants.netWorthChange;
  String get lastUpdatedDisplay => lastUpdated ?? HomeConstants.lastUpdated;
  String get assetsTotalDisplay => assetsTotal ?? HomeConstants.assetsValue;
  String get liabilitiesTotalDisplay =>
      liabilitiesTotal ?? HomeConstants.liabilitiesValue;

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    final rawAssets = json['assets'];
    final List<HomeAssetItem> assetList = rawAssets is List
        ? (rawAssets)
            .whereType<Map<String, dynamic>>()
            .map(HomeAssetItem.fromJson)
            .toList()
        : <HomeAssetItem>[];

    final rawLiabilities = json['liabilities'];
    final List<HomeLiabilityItem> liabilityList = rawLiabilities is List
        ? (rawLiabilities)
            .whereType<Map<String, dynamic>>()
            .map(HomeLiabilityItem.fromJson)
            .toList()
        : <HomeLiabilityItem>[];

    final rawNews = json['news'];
    final List<HomeNewsItem> newsList = rawNews is List
        ? (rawNews)
            .whereType<Map<String, dynamic>>()
            .map(HomeNewsItem.fromJson)
            .toList()
        : <HomeNewsItem>[];

    return HomeModel(
      netWorth: _stringFromAny(json['net_worth'] ?? json['netWorth']),
      netWorthChange:
          _stringFromAny(json['net_worth_change'] ?? json['netWorthChange']),
      lastUpdated:
          _stringFromAny(json['last_updated'] ?? json['lastUpdated']),
      assetsTotal:
          _stringFromAny(json['assets_total'] ?? json['assetsTotal']),
      liabilitiesTotal: _stringFromAny(
          json['liabilities_total'] ?? json['liabilitiesTotal']),
      assets: assetList,
      liabilities: liabilityList,
      news: newsList,
    );
  }

  static String? _stringFromAny(dynamic v) {
    if (v == null) return null;
    if (v is String) return v;
    if (v is num) return v.toString();
    return null;
  }
}

class HomeAssetItem {
  const HomeAssetItem({
    required this.title,
    required this.value,
    this.type,
    this.showAddButton = false,
  });

  final String title;
  final String value;
  final String? type;
  final bool showAddButton;

  factory HomeAssetItem.fromJson(Map<String, dynamic> json) {
    return HomeAssetItem(
      title: _stringFromAny(json['title'] ?? json['name'] ?? json['label']) ??
          '',
      value: _stringFromAny(json['value'] ?? json['amount']) ?? '£0',
      type: _stringFromAny(json['type']),
      showAddButton: json['show_add_button'] == true,
    );
  }

  static String? _stringFromAny(dynamic v) {
    if (v == null) return null;
    if (v is String) return v;
    if (v is num) return v.toString();
    return null;
  }
}

class HomeLiabilityItem {
  const HomeLiabilityItem({required this.title, required this.value});

  final String title;
  final String value;

  factory HomeLiabilityItem.fromJson(Map<String, dynamic> json) {
    return HomeLiabilityItem(
      title: _stringFromAny(json['title'] ?? json['name']) ?? '',
      value: _stringFromAny(json['value'] ?? json['amount']) ?? '£0',
    );
  }

  static String? _stringFromAny(dynamic v) {
    if (v == null) return null;
    if (v is String) return v;
    if (v is num) return v.toString();
    return null;
  }
}

class HomeNewsItem {
  const HomeNewsItem({
    required this.title,
    required this.description,
    this.imageUrl,
  });

  final String title;
  final String description;
  final String? imageUrl;

  factory HomeNewsItem.fromJson(Map<String, dynamic> json) {
    return HomeNewsItem(
      title: _stringFromAny(json['title'] ?? json['headline']) ?? '',
      description: _stringFromAny(json['description'] ?? json['summary']) ?? '',
      imageUrl: _stringFromAny(json['image_url'] ?? json['imageUrl']),
    );
  }

  static String? _stringFromAny(dynamic v) {
    if (v == null) return null;
    if (v is String) return v;
    if (v is num) return v.toString();
    return null;
  }
}
