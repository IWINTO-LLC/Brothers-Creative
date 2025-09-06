import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/common/widgets/texts/product_price_text.dart';
import 'package:brothers_creative/features/shop/controllers/product/cart_controller.dart';
import 'package:brothers_creative/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:brothers_creative/features/shop/screens/checkout/checkout.dart';
import 'package:brothers_creative/navigation_menu.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // bool dark = THelperFunctions.isDarkMode(context);
    final controller = CartController.instance;
    return Directionality(
      textDirection:
          Get.locale?.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            AppLocalizations.of(context)!.myCart,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          showBackArrow: true,
        ),
        bottomNavigationBar:
            controller.cartItems.isEmpty
                ? const SizedBox()
                : SizedBox(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 60,
                      left: THelperFunctions.screenwidth() / 3.5,
                      right: THelperFunctions.screenwidth() / 3.5,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      ),
                      onPressed: () => Get.to(() => const CheckoutScreen()),
                      child: Obx(
                        () => TProductPriceText(
                          color:
                              THelperFunctions.isDarkMode(context)
                                  ? Colors.black
                                  : Colors.white,
                          price: controller.totalOfCartPrice.toString(),
                        ), //Text('${controller.totalOfCartPrice.value}'),
                      ),
                    ),
                  ),
                ),
        body: SafeArea(
          child: Obx(() {
            return controller.cartItems.isEmpty
                ? SingleChildScrollView(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    children: [
                      const SizedBox(height: TSizes.spaceBtWItems),
                      Icon(
                        Icons.add_shopping_cart_outlined,
                        size: 100,
                        color:
                            THelperFunctions.isDarkMode(context)
                                ? TColors.darkGrey
                                : TColors.darkerGray,
                      ),
                      // Image(
                      //   image: const AssetImage(TImages.cartEmpty),
                      //   width: THelperFunctions.screenwidth() / 2,
                      // ),
                      const SizedBox(height: TSizes.spaceBtWItems),
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.cartIsEmpty,
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: TSizes.appBarHeight),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                            ),
                          ),
                          onPressed: () {
                            NavigationController.instance.selectedIndex.value =
                                1;
                            Get.to(() => const NavigationMenu());
                          },
                          child: Text(
                            AppLocalizations.of(context)!.letsFillIt,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall!.apply(
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
                )
                : const SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: TCartItems(),
                  ),
                );
          }),
        ),
      ),
    );
  }
}
