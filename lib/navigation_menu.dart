import 'dart:async';
import 'package:brothers_creative/features/gallery/screen/gallery.dart';
import 'package:brothers_creative/features/shop/controllers/product/cart_controller.dart';
import 'package:brothers_creative/features/shop/controllers/product/later_list_controller.dart';
import 'package:brothers_creative/features/shop/screens/store/store.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
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
            child: Stack(
              children: [
                Obx(() => controller.screens[controller.selectedIndex.value]),
                // رسالة الخروج الناعمة
                Obx(
                  () =>
                      controller._showExitMessage.value
                          ? Positioned(
                            bottom: 50,
                            left: 20,
                            right: 20,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  Get.locale?.languageCode == 'en'
                                      ? 'Press back again to exit'
                                      : 'اضغط مرة أخرى للخروج',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                          : const SizedBox.shrink(),
                ),
              ],
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
      return NavigationController.instance.handleBackPress();
    }
  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();
  final Rx<int> selectedIndex = 0.obs;

  // متغيرات للضغط المزدوج
  DateTime? _lastBackPressed;
  final RxBool _showExitMessage = false.obs;
  Timer? _exitMessageTimer;

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  // دالة للتعامل مع الضغط المزدوج
  bool handleBackPress() {
    if (_showExitMessage.value) {
      return true; // الخروج من التطبيق
    }

    final now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > const Duration(seconds: 1)) {
      _lastBackPressed = now;
      _showExitMessage.value = true;
      _showExitMessageTimer();
      return false; // عدم الخروج
    }

    return true; // الخروج من التطبيق
  }

  void _showExitMessageTimer() {
    _exitMessageTimer?.cancel();
    _exitMessageTimer = Timer(const Duration(seconds: 2), () {
      _showExitMessage.value = false;
    });
  }

  @override
  void onClose() {
    _exitMessageTimer?.cancel();
    super.onClose();
  }

  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const TGalleryScreen(),
    const CartScreen(),
    const SettingsScreen(),
  ];
}
