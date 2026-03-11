import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/components/app_card.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/features/home/data/models/home_model.dart';
import 'package:hoxton_task/features/home/home_constants.dart';

class HomeNewsCard extends StatefulWidget {
  const HomeNewsCard({super.key, this.home});

  final HomeModel? home;

  @override
  State<HomeNewsCard> createState() => _HomeNewsCardState();
}

class _HomeNewsCardState extends State<HomeNewsCard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final news = widget.home?.news ?? [];
    final hasNews = news.isNotEmpty;
    final index = hasNews
        ? _selectedIndex.clamp(0, news.length - 1)
        : 0;
    final item = hasNews ? news[index] : null;
    final title = item?.title ?? HomeConstants.newsArticleTitle;
    final description =
        item?.description ?? HomeConstants.newsArticleDescription;
    final dotCount = hasNews ? news.length : HomeConstants.newsCarouselDotCount;

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Thumbnail(imageUrl: item?.imageUrl),
              const SizedBox(width: AppSpacing.spacing12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.coolGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 24 / 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: AppColors.captionGrey,
                        fontSize: 14,
                        height: 20 / 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spacing12),
          _PaginationDots(
            count: dotCount,
            selectedIndex: _selectedIndex,
            onTap: dotCount > 1
                ? (i) => setState(() => _selectedIndex = i)
                : null,
          ),
        ],
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: AppColors.greyGreenTint2,
        borderRadius: BorderRadius.circular(AppSpacing.spacing8),
      ),
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.spacing8),
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                width: 88,
                height: 88,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.article_outlined,
                  size: 40,
                  color: AppColors.captionGrey,
                ),
              ),
            )
          : Icon(
              Icons.article_outlined,
              size: 40,
              color: AppColors.captionGrey,
            ),
    );
  }
}

class _PaginationDots extends StatelessWidget {
  const _PaginationDots({
    required this.count,
    required this.selectedIndex,
    this.onTap,
  });

  final int count;
  final int selectedIndex;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final isSelected = i == selectedIndex;
        return GestureDetector(
          onTap: onTap != null ? () => onTap!(i) : null,
          child: Padding(
            padding:
                EdgeInsets.only(right: i < count - 1 ? AppSpacing.spacing8 : 0),
            child: Container(
              width: isSelected ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color:
                    isSelected ? AppColors.primaryBg : AppColors.greyGreenTint2,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        );
      }),
    );
  }
}
