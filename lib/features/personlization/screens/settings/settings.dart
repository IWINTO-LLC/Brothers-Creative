import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:brothers_creative/common/widgets/list_tiles/setting_menu_tile.dart';
import 'package:brothers_creative/common/widgets/texts/section_heading.dart';
import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/features/personlization/screens/settings/settings_profile.dart';
import 'package:brothers_creative/features/shop/screens/cart/cart.dart';
import 'package:brothers_creative/features/shop/screens/orders/widgets/order.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:brothers_creative/utils/helpers/system_ui_helper.dart';
import 'package:brothers_creative/utils/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarIconBrightness: dark ? Brightness.light : Brightness.dark,
    //   statusBarColor: dark ? TColors.black : TColors.white, // status bar color
    // ));
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
      child: SafeArea(
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TPrimaryHeaderContainer(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TAppBar(
                          showBackArrow: true,

                          title: Text(
                            AppLocalizations.of(context)!.setting,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineMedium!.apply(
                              color:
                                  THelperFunctions.isDarkMode(context)
                                      ? TColors.white
                                      : TColors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtWsections),
                      ],
                    ),
                  ),

                  ///body
                  Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                        //const TSettingTile(),
                        // const SizedBox(
                        //   height: TSizes.spaceBtWsections,
                        // ),
                        //-- acount settings
                        TSectionHeading(
                          title: AppLocalizations.of(context)!.accountSettings,
                          showActionButton: false,
                        ),
                        const SizedBox(height: TSizes.spaceBtWItems),

                        // TSettingMenuTile(
                        //   onTap:
                        //       () => Get.to(() => const TPricesRequestScreen()),
                        //   icon: Iconsax.discount_shape,
                        //   title: AppLocalizations.of(context)!.priceRequest,
                        //   subTitle:
                        //       'you can Request for Price or decoration price',
                        //   iconColor: iconColor,
                        // ),
                        // TSettingMenuTile(
                        //   icon: Iconsax.location,
                        //   onTap: () => Get.to(() => const UserAdressScreen()),
                        //   subTitle:
                        //       AppLocalizations.of(context)!.addressSubtile,
                        //   title: AppLocalizations.of(context)!.myAddresses,
                        //   iconColor: iconColor,
                        // ),
                        TSettingMenuTile(
                          onTap:
                              () => Get.to(() => const SettingProfileScreen()),
                          icon: Icons.person_2_outlined,
                          title: AppLocalizations.of(context)!.account,
                          subTitle:
                              AppLocalizations.of(context)!.accountSettings,
                          iconColor: iconColor,
                        ),
                        TSettingMenuTile(
                          onTap: () => Get.to(() => const CartScreen()),
                          icon: CupertinoIcons.shopping_cart,
                          title: AppLocalizations.of(context)!.myCart,
                          subTitle: AppLocalizations.of(context)!.cartSubtitle,
                          iconColor: iconColor,
                        ),
                        TSettingMenuTile(
                          onTap: () => Get.to(() => const OrderScreen()),
                          icon: Iconsax.book,
                          title: AppLocalizations.of(context)!.myOrders,
                          subTitle:
                              AppLocalizations.of(context)!.ordersSubtitle,
                          iconColor: iconColor,
                        ),

                        // TSettingMenuTile(
                        //     onTap: () {
                        //       final controller = Get.put(NavigationController());
                        //       controller.updateSelectedIndex(1);
                        //       Get.to(() => const FavoriteScreen());
                        //     },
                        //     icon: Iconsax.heart,
                        //     title: AppLocalizations.of(context)!.wishList,
                        //     subTitle:
                        //         AppLocalizations.of(context)!.wishlistSubTitle),

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
                        // TSectionHeading(
                        //   title: AppLocalizations.of(context)!.appSettings,
                        //   showActionButton: false,
                        // ),
                        // const SizedBox(
                        //   height: TSizes.spaceBtWItems,
                        // ),

                        // TSettingMenuTile(
                        //   icon: Iconsax.document_upload,
                        //   title: AppLocalizations.of(context)!.loadDate,
                        //   subTitle: 'upload data to your account',
                        // ),

                        // TSettingMenuTile(
                        //   onTap: () {
                        //     if (Get.locale?.languageCode == 'ar') {
                        //       GetStorage().write('en', true);
                        //       Get.updateLocale(const Locale('en'));
                        //       THelperFunctions.isDarkMode(context)
                        //           ? Get.changeTheme(TAppTheme.darkThemeEg)
                        //           : Get.changeTheme(TAppTheme.lightThemeEg);
                        //     } else {
                        //       GetStorage().write('en', false);
                        //       Get.updateLocale(const Locale('ar'));
                        //       THelperFunctions.isDarkMode(context)
                        //           ? Get.changeTheme(TAppTheme.darkThemeAr)
                        //           : Get.changeTheme(TAppTheme.lightThemeArabic);
                        //     }

                        //     Get.reload();
                        //   },
                        //   icon: Icons.language,
                        //   title: AppLocalizations.of(context)!.changedTo,
                        //   subTitle:
                        //       AppLocalizations.of(context)!.chooseYourLanguage,
                        // ),
                        // TSettingMenuTile(
                        //   icon: Iconsax.moon5,
                        //   title: AppLocalizations.of(context)!.darkMode,
                        //   subTitle:
                        //       AppLocalizations.of(context)!.chooseYourPrightness,
                        //   trailing: Switch(
                        //       activeColor: TColors.primary,
                        //       value: THelperFunctions.isDarkMode(context),
                        //       onChanged: (value) {
                        //         if (!value) {
                        //           Get.changeTheme(Get.locale?.languageCode == 'en'
                        //               ? TAppTheme.lightThemeEg
                        //               : TAppTheme.lightThemeArabic);
                        //         } else {
                        //           Get.changeTheme(Get.locale?.languageCode == 'en'
                        //               ? TAppTheme.darkThemeEg
                        //               : TAppTheme.darkThemeAr);
                        //         }
                        //       }),
                        // ),
                        const SizedBox(height: TSizes.spaceBtWsections),

                        TSectionHeading(
                          title: AppLocalizations.of(context)!.appSettings,
                          showActionButton: false,
                        ),

                        // const SizedBox(
                        //   height: TSizes.spaceBtWItems,
                        // ),

                        // TSettingMenuTile(
                        //   icon: Iconsax.document_upload,
                        //   title: AppLocalizations.of(context)!.loadDate,
                        //   subTitle: 'upload data to your account',
                        // ),
                        TSettingMenuTile(
                          onTap: () {
                            if (Get.locale?.languageCode == 'ar') {
                              GetStorage().write('en', true);
                              Get.updateLocale(const Locale('en'));
                              THelperFunctions.isDarkMode(context)
                                  ? Get.changeTheme(TAppTheme.darkThemeEg)
                                  : Get.changeTheme(TAppTheme.lightThemeEg);
                            } else {
                              GetStorage().write('en', false);
                              Get.updateLocale(const Locale('ar'));
                              THelperFunctions.isDarkMode(context)
                                  ? Get.changeTheme(TAppTheme.darkThemeAr)
                                  : Get.changeTheme(TAppTheme.lightThemeArabic);
                            }

                            // تحديث SystemUI بعد تغيير اللغة والنمط
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              TSystemUIHelper.updateSystemUI(context);
                            });
                            TSystemUIHelper.forceUpdateSystemUI(
                              context,
                              THelperFunctions.isDarkMode(context),
                            );

                            Get.reload();
                          },
                          icon: Icons.language,
                          iconColor: iconColor,
                          title: AppLocalizations.of(context)!.changedTo,
                          subTitle:
                              AppLocalizations.of(context)!.chooseYourLanguage,
                        ),
                        TSettingMenuTile(
                          icon: Iconsax.moon5,
                          title: AppLocalizations.of(context)!.darkMode,
                          subTitle:
                              AppLocalizations.of(
                                context,
                              )!.chooseYourPrightness,
                          trailing: Switch(
                            activeColor: TColors.primary,
                            value: THelperFunctions.isDarkMode(context),
                            onChanged: (value) {
                              if (!value) {
                                Get.changeTheme(
                                  Get.locale?.languageCode == 'en'
                                      ? TAppTheme.lightThemeEg
                                      : TAppTheme.lightThemeArabic,
                                );
                                // تحديث SystemUI للنمط الفاتح مع تحسين
                                TSystemUIHelper.updateSystemUIOnThemeChangeEnhanced(
                                  context,
                                  false,
                                );
                              } else {
                                Get.changeTheme(
                                  Get.locale?.languageCode == 'en'
                                      ? TAppTheme.darkThemeEg
                                      : TAppTheme.darkThemeAr,
                                );
                                // تحديث SystemUI للنمط المظلم مع تحسين
                                TSystemUIHelper.updateSystemUIOnThemeChangeEnhanced(
                                  context,
                                  true,
                                );
                                TSystemUIHelper.forceUpdateSystemUI(
                                  context,
                                  true,
                                );

                                // TSystemUIHelper.forceDarkMode();
                              }
                              // final isDark = THelperFunctions.isDarkMode(
                              //   context,
                              // );
                              // TSystemUIHelper.forceUpdateSystemUI(
                              //   context,
                              //   isDark,
                              // );
                            },
                          ),
                          iconColor: iconColor,
                        ),
                        TSettingMenuTile(
                          onTap:
                              () => AuthenticationRepository.instance.logOut(),
                          icon: Icons.logout,
                          title: AppLocalizations.of(context)!.logout,
                          subTitle: AppLocalizations.of(context)!.logout,
                          iconColor: iconColor,
                        ),

                        // زر تشخيص SystemUI (يظهر فقط في وضع التطوير)
                      //   if (kDebugMode) ...[
                      //     const SizedBox(height: TSizes.spaceBtWsections),
                      //     TSectionHeading(
                      //       title: '🔧 SystemUI Debug',
                      //       showActionButton: false,
                      //     ),
                      //     const SizedBox(height: TSizes.spaceBtWItems),
                      //     TSettingMenuTile(
                      //       onTap: () {
                      //         TSystemUIHelper.debugCurrentMode(context);
                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //           SnackBar(
                      //             content: Text(
                      //               'تم إرسال معلومات التشخيص إلى Console',
                      //             ),
                      //             backgroundColor: TColors.primary,
                      //           ),
                      //         );
                      //       },
                      //       icon: Icons.bug_report,
                      //       title: 'Debug SystemUI',
                      //       subTitle: 'عرض معلومات SystemUI في Console',
                      //       iconColor: iconColor,
                      //     ),
                      //     TSettingMenuTile(
                      //       onTap: () {
                      //         TSystemUIHelper.forceDarkMode();
                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //           SnackBar(
                      //             content: Text('تم إجبار النمط المظلم'),
                      //             backgroundColor: TColors.dark,
                      //           ),
                      //         );
                      //       },
                      //       icon: Icons.dark_mode,
                      //       title: 'إجبار النمط المظلم',
                      //       subTitle: 'تطبيق النمط المظلم على SystemUI',
                      //       iconColor: iconColor,
                      //     ),
                      //     TSettingMenuTile(
                      //       onTap: () {
                      //         TSystemUIHelper.forceLightMode();
                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //           SnackBar(
                      //             content: Text('تم إجبار النمط الفاتح'),
                      //             backgroundColor: TColors.light,
                      //           ),
                      //         );
                      //       },
                      //       icon: Icons.light_mode,
                      //       title: 'إجبار النمط الفاتح',
                      //       subTitle: 'تطبيق النمط الفاتح على SystemUI',
                      //       iconColor: iconColor,
                      //     ),
                      //     TSettingMenuTile(
                      //       onTap: () {
                      //         final isDark = THelperFunctions.isDarkMode(
                      //           context,
                      //         );
                      //         TSystemUIHelper.forceUpdateSystemUI(
                      //           context,
                      //           isDark,
                      //         );
                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //           SnackBar(
                      //             content: Text(
                      //               'تم تطبيق التحديث القوي للنمط ${isDark ? "المظلم" : "الفاتح"}',
                      //             ),
                      //             backgroundColor: TColors.primary,
                      //           ),
                      //         );
                      //       },
                      //       icon: Icons.power_settings_new,
                      //       title: 'تحديث قوي SystemUI',
                      //       subTitle: 'تطبيق SystemUI بقوة للتأكد من التطبيق',
                      //       iconColor: iconColor,
                      //     ),
                      //   ],
                       ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
