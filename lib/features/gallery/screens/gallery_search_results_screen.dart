import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:brothers_creative/common/widgets/loaders/animation_loading.dart';
import 'package:brothers_creative/common/widgets/images/custom_cache_image.dart';
import 'package:brothers_creative/features/gallery/controllers/gallery_search_controller.dart';
import 'package:brothers_creative/features/general/screens/gallery_widget.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class GallerySearchResultsScreen extends StatelessWidget {
  const GallerySearchResultsScreen({super.key, this.initialQuery});

  final String? initialQuery;

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(GallerySearchController());
    final isDark = THelperFunctions.isDarkMode(context);
    final isArabic = Get.locale?.languageCode == 'ar';

    // بدء البحث إذا كان هناك نص أولي
    if (initialQuery != null && initialQuery!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        searchController.searchGallery(initialQuery!);
      });
    } else {
      // اختبار وجود صور في قاعدة البيانات
      WidgetsBinding.instance.addPostFrameCallback((_) {
        searchController.testGalleryItemsExist();
      });
    }

    return Scaffold(
      appBar: TAppBar(
        title: Text(
          AppLocalizations.of(context)?.searchResults ?? 'Search Results',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
        actions: [
          // زر اختبار البحث (للتصحيح فقط)
          if (kDebugMode)
            IconButton(
              onPressed: () {
                searchController.testSearch('test');
              },
              icon: const Icon(Iconsax.search_status),
              tooltip: 'Test Search',
            ),
          IconButton(
            onPressed: () {
              searchController.clearSearch();
              Get.back();
            },
            icon: const Icon(Iconsax.close_circle),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // شريط البحث
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: TSearchContainer(
                text:
                    AppLocalizations.of(context)?.searchinGallery ??
                    'Search gallery...',
                icon: Iconsax.search_normal,
                showBorder: true,
                padding: EdgeInsets.zero,
                showBackground: false,
                isSearchField: true,
                onChanged: searchController.searchOnChanged,
              ),
            ),

            // عرض عدد النتائج تحت مربع البحث
            Obx(() {
              if (searchController.hasSearched.value &&
                  !searchController.isLoading.value) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.defaultSpace,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: TSizes.sm,
                      horizontal: TSizes.md,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isDark
                              ? TColors.darkGrey.withValues(alpha: 0.1)
                              : TColors.lightgrey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textDirection:
                          isArabic ? TextDirection.rtl : TextDirection.ltr,
                      children: [
                        Icon(
                          Iconsax.search_status,
                          size: 16,
                          color: isDark ? TColors.white : TColors.darkGrey,
                        ),
                        const SizedBox(width: TSizes.xs),
                        Expanded(
                          child: Text(
                            searchController.searchResults.isEmpty
                                ? (AppLocalizations.of(
                                      context,
                                    )?.noResultsFound ??
                                    'No results found')
                                : (AppLocalizations.of(context)?.resultsFound(
                                      searchController.searchResults.length,
                                    ) ??
                                    '${searchController.searchResults.length} result${searchController.searchResults.length == 1 ? '' : 's'} found'),
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              color: isDark ? TColors.white : TColors.darkGrey,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                            textDirection:
                                isArabic
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                          ),
                        ),
                        if (searchController.searchQuery.value.isNotEmpty) ...[
                          const SizedBox(width: TSizes.xs),
                          Flexible(
                            child: Text(
                              isArabic
                                  ? ' لـ "${searchController.searchQuery.value}"'
                                  : ' for "${searchController.searchQuery.value}"',
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color:
                                    isDark
                                        ? TColors.lightgrey
                                        : TColors.darkGrey,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                              textDirection:
                                  isArabic
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            // نتائج البحث
            Obx(() {
              if (searchController.isLoading.value) {
                return Center(
                  child: TAnimationLoaderWidget(
                    text:
                        AppLocalizations.of(context)?.searching ??
                        'Searching...',
                    animation: 'assets/images/lottie/processing.json',
                    color: TColors.primary,
                  ),
                );
              }

              if (!searchController.hasSearched.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.search_normal,
                        size: 64,
                        color: isDark ? TColors.white : TColors.darkGrey,
                      ),
                      const SizedBox(height: TSizes.spaceBtWItems),
                      Text(
                        AppLocalizations.of(context)?.searchinGallery ??
                            'Search for gallery items',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: TSizes.spaceBtWItems),
                      Text(
                        AppLocalizations.of(context)?.searchFieldHint ??
                            'Type in the search field above to find gallery items',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                        textDirection:
                            isArabic ? TextDirection.rtl : TextDirection.ltr,
                      ),
                    ],
                  ),
                );
              }

              if (searchController.searchResults.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.search_status,
                        size: 64,
                        color: isDark ? TColors.white : TColors.darkGrey,
                      ),
                      const SizedBox(height: TSizes.spaceBtWItems),
                      Text(
                        AppLocalizations.of(context)?.noData ??
                            'No gallery items found',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: TSizes.spaceBtWItems / 2),
                      Text(
                        AppLocalizations.of(context)?.tryDifferentKeywords ??
                            'Try different keywords',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                        textDirection:
                            isArabic ? TextDirection.rtl : TextDirection.ltr,
                      ),
                      const SizedBox(height: TSizes.spaceBtWItems),
                      Text(
                        AppLocalizations.of(context)?.searchedFor(
                              searchController.searchQuery.value,
                            ) ??
                            'Searched for: "${searchController.searchQuery.value}"',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.only(
                  top: TSizes.spaceBtWsections,
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.spaceBtWsections,
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: TSizes.gridViewSpacing,
                    crossAxisSpacing: TSizes.gridViewSpacing,
                    mainAxisExtent: 200,
                  ),
                  itemCount: searchController.searchResults.length,
                  itemBuilder: (_, index) {
                    final galleryItem = searchController.searchResults[index];
                    return GestureDetector(
                      onTap: () {
                        // عرض الصورة في معرض كامل
                        Get.to(
                          () => GalleryWidget(
                            urlImage:
                                searchController.searchResults
                                    .map((e) => e.image)
                                    .toList(),
                            index: index,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            TSizes.cardRadiusMd,
                          ),
                          border: Border.all(
                            color:
                                isDark ? TColors.darkGrey : TColors.lightgrey,
                            width: 0.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // الصورة
                            Expanded(
                              flex: 3,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(TSizes.cardRadiusMd),
                                  topRight: Radius.circular(
                                    TSizes.cardRadiusMd,
                                  ),
                                ),
                                child: CustomCaChedNetworkImage(
                                  url: galleryItem.image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  raduis: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                            // النص
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(TSizes.sm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isArabic
                                          ? (galleryItem.arabicName ??
                                              galleryItem.name ??
                                              '')
                                          : (galleryItem.name ??
                                              galleryItem.arabicName ??
                                              ''),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textDirection:
                                          isArabic
                                              ? TextDirection.rtl
                                              : TextDirection.ltr,
                                    ),
                                    if (galleryItem
                                            .arabicDescription
                                            ?.isNotEmpty ==
                                        true)
                                      Text(
                                        galleryItem.arabicDescription!,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.copyWith(
                                          color:
                                              isDark
                                                  ? TColors.lightgrey
                                                  : TColors.darkGrey,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textDirection: TextDirection.rtl,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
