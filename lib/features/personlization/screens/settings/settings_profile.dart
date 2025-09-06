import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/common/widgets/list_tiles/setting_menu_tile.dart';
import 'package:brothers_creative/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:brothers_creative/common/widgets/texts/section_heading.dart';
import 'package:brothers_creative/features/project/screens/prices/prices.dart';
import 'package:brothers_creative/features/project/screens/projects/projects.dart';
import 'package:brothers_creative/features/shop/screens/cart/cart.dart';
import 'package:brothers_creative/features/shop/screens/orders/widgets/order.dart';
import 'package:brothers_creative/features/shop/screens/wishlist/wishlist.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/navigation_menu.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../address/address.dart';

class SettingProfileScreen extends StatelessWidget {
  const SettingProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final termController = BrothersController.instance;
    // final brotherData = termController.allData;
    // bool isEg = Get.locale?.languageCode == 'en';
    var iconColor =
        THelperFunctions.isDarkMode(context) ? TColors.white : TColors.black;
    return Directionality(
      textDirection:
          Get.locale?.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            AppLocalizations.of(context)!.account,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.apply(color: TColors.white),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TUserProfileTile(),
                const SizedBox(height: TSizes.spaceBtWsections),

                ///body
                Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    children: [
                      //-- acount settings
                      TSectionHeading(
                        title: AppLocalizations.of(context)!.accountSettings,
                        showActionButton: false,
                      ),
                      const SizedBox(height: TSizes.spaceBtWItems),
                      TSettingMenuTile(
                        iconColor: iconColor,
                        onTap: () => Get.to(() => const ProjectsScreen()),
                        icon: Iconsax.buildings_2,
                        title: AppLocalizations.of(context)!.myProjects,
                        subTitle: 'track processing projects ',
                      ),

                      TSettingMenuTile(
                        iconColor: iconColor,
                        onTap: () => Get.to(() => const TPricesRequestScreen()),
                        icon: Iconsax.discount_shape,
                        title: AppLocalizations.of(context)!.priceRequest,
                        subTitle:
                            'you can Request for Price or decoration price',
                      ),
                      TSettingMenuTile(
                        iconColor: iconColor,
                        icon: Iconsax.location,
                        onTap: () => Get.to(() => const UserAdressScreen()),
                        subTitle: AppLocalizations.of(context)!.addressSubtile,
                        title: AppLocalizations.of(context)!.myAddresses,
                      ),

                      TSettingMenuTile(
                        onTap: () => Get.to(() => const CartScreen()),
                        icon: Iconsax.shopping_bag,
                        title: AppLocalizations.of(context)!.myCart,
                        subTitle: AppLocalizations.of(context)!.cartSubtitle,
                        iconColor: iconColor,
                      ),
                      TSettingMenuTile(
                        onTap: () => Get.to(() => const OrderScreen()),
                        icon: Iconsax.printer,
                        title: AppLocalizations.of(context)!.myOrders,
                        subTitle: AppLocalizations.of(context)!.ordersSubtitle,
                        iconColor: iconColor,
                      ),
                      TSettingMenuTile(
                        iconColor: iconColor,
                        onTap: () {
                          final controller = Get.put(NavigationController());
                          controller.updateSelectedIndex(1);
                          Get.to(() => const FavoriteScreen());
                        },
                        icon: Iconsax.heart,
                        title: AppLocalizations.of(context)!.wishList,
                        subTitle:
                            AppLocalizations.of(context)!.wishlistSubTitle,
                      ),

                      //  ),
                      // TSettingMenuTile(
                      //   onTap: () => Get.to(() => const NotificationScreen()),
                      //   icon: Iconsax.notification,
                      //   title: AppLocalizations.of(context)!.notifications,
                      //   subTitle: 'Do culpa reprehenderit ullamco fugiat.',
                      // ),

                      // TSettingMenuTile(
                      //   icon: Iconsax.security_card,
                      //   title: AppLocalizations.of(context)!.accountPrivacy,
                      //   subTitle: 'manage data usage',
                      // ),
                      // const SizedBox(
                      //   height: TSizes.spaceBtWsections,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
