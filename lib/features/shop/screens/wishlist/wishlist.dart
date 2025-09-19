import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/common/widgets/icons/circuler_icon.dart';
import 'package:brothers_creative/common/widgets/layout/grid_layout.dart';
import 'package:brothers_creative/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:brothers_creative/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:brothers_creative/features/shop/controllers/product/favorites_controller.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/navigation_menu.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/cloud_helper_function.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());
    return Directionality(
      textDirection:
          Get.locale?.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(AppLocalizations.of(context)!.wishList),
          actions: [
            TCircularIcon(
              icon: Iconsax.add,
              onPressed: () {
                NavigationController.instance.selectedIndex.value = 1;
                Get.to(const NavigationMenu());
              },
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Obx(
                () => FutureBuilder(
                  future: controller.favoritesProducts(),
                  builder: (context, snapshot) {
                    final emptyWidget = Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: TSizes.spaceBtWsections),
                          Text(
                            AppLocalizations.of(context)!.wishlistIsEmpty,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: TSizes.appBarHeight),
                          ElevatedButton(
                            onPressed: () {
                              NavigationController
                                  .instance
                                  .selectedIndex
                                  .value = 1;
                              Get.to(const NavigationMenu());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: TSizes.defaultSpace,
                                right: TSizes.defaultSpace,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.letsFillIt,
                                style: Theme.of(
                                  context,
                                ).textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      THelperFunctions.isDarkMode(context)
                                          ? Colors.black
                                          : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );

                    // TAnimationLoaderWidget(
                    //   text: AppLocalizations.of(context)!.wishlistIsEmpty,
                    //   animation: TImages.bwhite,
                    //   showAction: true,
                    //   actionText: AppLocalizations.of(context)!.letsFillIt,
                    // );
                    const loader = TVerticalProductShummer(itemCount: 6);
                    final widget = TCloudHelperFunctions.checkMuiltiRecordState(
                      snapshot: snapshot,
                      loader: loader,
                      nothingFound: emptyWidget,
                    );
                    if (widget != null) return widget;
                    final product = snapshot.data!;

                    return TGridLayout(
                      itemCount: product.length,
                      itemBuilder:
                          (_, index) =>
                              TProductCardVertical(product: product[index]),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
