import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';

import 'package:brothers_creative/features/gallery/screen/gallery.dart';
import 'package:brothers_creative/features/shop/controllers/product/cart_controller.dart';
import 'package:brothers_creative/features/shop/controllers/product/later_list_controller.dart';
import 'package:brothers_creative/features/shop/screens/store/store.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:brothers_creative/utils/helpers/system_ui_helper.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';

import 'features/personlization/screens/settings/settings.dart';
import 'features/shop/screens/cart/cart.dart';
import 'features/shop/screens/home/home.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key, this.isGust});
  final bool? isGust;

  @override
  Widget build(BuildContext context) {
    Get.put(LaterListController());
    Get.put(CartController());
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Directionality(
      textDirection:
          Get.locale?.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: Scaffold(
        // floatingActionButton: const TCircularFabWidget(),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: SafeArea(
          child: WillPopScope(
            onWillPop: showExitDialog,
            child: Obx(
              () => controller.screens[controller.selectedIndex.value],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => NavigationBar(
            elevation: 0,
            height: 80,
            backgroundColor: darkMode ? TColors.black : TColors.white,
            indicatorColor: !darkMode ? TColors.white : TColors.black,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected:
                (index) => controller.selectedIndex.value = index,
            destinations: [
              NavigationDestination(
                selectedIcon: const Icon(
                  Iconsax.home_1,
                  color: TColors.primary,
                ),
                icon: const Icon(Iconsax.home_1),
                label: AppLocalizations.of(context)!.mainpage,
              ),
              NavigationDestination(
                selectedIcon: const Icon(Iconsax.shop, color: TColors.primary),
                icon: const Icon(Iconsax.shop),
                label: AppLocalizations.of(context)!.store,
              ),
              NavigationDestination(
                selectedIcon: const Icon(
                  Iconsax.gallery,
                  color: TColors.primary,
                ),
                icon: const Icon(Iconsax.gallery),
                label: AppLocalizations.of(context)!.gallery,
              ),
              NavigationDestination(
                selectedIcon: const Icon(
                  CupertinoIcons.shopping_cart,
                  color: TColors.primary,
                ),
                icon: const Icon(CupertinoIcons.shopping_cart),
                label: AppLocalizations.of(context)!.myCart,
              ),
              NavigationDestination(
                selectedIcon: const Icon(
                  Iconsax.setting_2,
                  color: TColors.primary,
                ),
                icon: const Icon(Iconsax.setting_2),
                label: AppLocalizations.of(context)!.setting,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> showExitDialog() async {
    if (NavigationController.instance.selectedIndex.value != 0) {
      NavigationController.instance.selectedIndex.value = 0;
      return false;
    } else {
      return await showDialog(
        context: Get.context!,
        builder:
            (context) => AlertDialog(
              backgroundColor:
                  THelperFunctions.isDarkMode(context)
                      ? Colors.black
                      : TColors.light,
              title: Text(
                AppLocalizations.of(context)!.exitApp,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              content: Text(
                AppLocalizations.of(context)!.doYouWantToExit,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: TRoundedContainer(
                    showBorder: true,
                    radius: BorderRadius.circular(100),
                    borderColor: TColors.primary,
                    backgroundColor: TColors.primary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 30,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.no,
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(color: TColors.white),
                      ),
                    ),
                  ),
                ),

                // Text(
                //   AppLocalizations.of(context)!.no,
                //   style: Theme.of(context)
                //       .textTheme
                //       .headlineSmall!
                //       .apply(color: TColors.white),
                // )
                // ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: TRoundedContainer(
                    showBorder: true,
                    radius: BorderRadius.circular(100),
                    borderColor: TColors.primary,
                    backgroundColor:
                        THelperFunctions.isDarkMode(context)
                            ? TColors.dark
                            : TColors.light,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.yes,
                        style: Theme.of(context).textTheme.headlineSmall!,
                      ),
                    ),
                  ),
                ),
              ],
            ),
      );
    }
  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();
  final Rx<int> selectedIndex = 0.obs;

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const TGalleryScreen(),
    const CartScreen(),
    const SettingsScreen(),
  ];
}
