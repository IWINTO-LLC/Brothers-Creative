import 'package:brothers_creative/common/widgets/appbar/tabbar.dart';
import 'package:brothers_creative/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:brothers_creative/common/widgets/image_text_widets/vertical_image_text.dart';
import 'package:brothers_creative/common/widgets/product.cart/cart_menu_icon.dart';
import 'package:brothers_creative/common/widgets/shimmers/brand_shimmer.dart';
import 'package:brothers_creative/common/widgets/texts/section_heading.dart';
import 'package:brothers_creative/features/shop/controllers/brand_controller.dart';
import 'package:brothers_creative/features/shop/controllers/category_controller.dart';
import 'package:brothers_creative/features/shop/screens/store/category/category_tab.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'brand/all_brand.dart';
import 'brand/brand_product.dart';
import 'search_results_screen.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final isEg = Get.locale?.languageCode == 'en';
    final categories = CategoryController.instance.featureCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  floating: false,
                  pinned: true,
                  backgroundColor:
                      THelperFunctions.isDarkMode(context)
                          ? TColors.black
                          : TColors.white,
                  expandedHeight: 390,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.store,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            TCartCounterIcon(
                              iconColor:
                                  THelperFunctions.isDarkMode(context)
                                      ? TColors.white
                                      : TColors.black,
                              onPress: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtWItems),
                        // بحث المنتجات
                        TSearchContainer(
                          text: AppLocalizations.of(context)!.searchProducts,
                          showBorder: true,
                          padding: EdgeInsets.zero,
                          icon: Iconsax.search_normal,
                          showBackground: false,
                          isSearchField: true,
                          onChanged: (query) {
                            if (query.trim().isNotEmpty) {
                              Get.to(
                                () => SearchResultsScreen(initialQuery: query),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: TSizes.spaceBtWsections),
                        TSectionHeading(
                          title: AppLocalizations.of(context)!.featureBrands,
                          showActionButton: true,
                          buttonTitle: AppLocalizations.of(context)!.viewAll,
                          onPress: () => Get.to(() => const AllBrandScreen()),
                        ),
                        const SizedBox(height: TSizes.spaceBtWItems / 1.5),
                        Obx(() {
                          if (brandController.isLoading.value) {
                            return TBrandShummer(
                              itemCount: brandController.featureBrands.length,
                            );
                          }
                          if (brandController.featureBrands.isEmpty) {
                            return const SizedBox();
                          }
                          return SizedBox(
                            height: 150,
                            child: ListView.builder(
                              // gridDelegate:
                              //     const SliverGridDelegateWithFixedCrossAxisCount(
                              //         crossAxisCount: 2,
                              //         mainAxisSpacing: TSizes.gridViewSpacing,
                              //         crossAxisSpacing: TSizes.gridViewSpacing,
                              //         mainAxisExtent: 100),
                              itemCount: brandController.featureBrands.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                var brand =
                                    brandController.featureBrands[index];
                                return TVerticalImageText(
                                  textColor: TColors.black,
                                  onTap:
                                      () => Get.to(
                                        () => BrandProducts(brand: brand),
                                      ),
                                  image:
                                      brand.image == ''
                                          ? TImages.bwhite
                                          : brand.image,
                                  title: brand.name,
                                  isNetworkImage:
                                      brand.image == '' ? false : true,
                                )
                                // TBrandCard(
                                //   showBorder: false,
                                //   brand: brandController.featureBrands[index],
                                //   onTap: () => Get.to(() => BrandProducts(
                                //         brand:
                                //             brandController.featureBrands[index],
                                //       )),
                                // )
                                ;
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  bottom: TTabbar(
                    tabs:
                        isEg
                            ? categories
                                .map(
                                  (category) => Tab(child: Text(category.name)),
                                )
                                .toList()
                            : categories
                                .map(
                                  (category) =>
                                      Tab(child: Text(category.arabicName)),
                                )
                                .toList(),
                  ),
                ),
              ];
            },
            // ignore: prefer_const_constructors
            body: SafeArea(
              child: TabBarView(
                children:
                    categories
                        .map((category) => TCategoryTab(category: category))
                        .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
