// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:brothers_creative/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/common/widgets/layout/grid_layout.dart';
import 'package:brothers_creative/common/widgets/list_tiles/setting_menu_tile.dart';
import 'package:brothers_creative/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:brothers_creative/common/widgets/texts/section_heading.dart';
import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/features/gallery/screen/gallery.dart';
import 'package:brothers_creative/features/personlization/screens/blog/blog.dart';
import 'package:brothers_creative/features/personlization/screens/profile/brothers.dart';
import 'package:brothers_creative/features/project/screens/prices/add_new_price_request.dart';
import 'package:brothers_creative/features/project/screens/projects/add_new_project.dart';
import 'package:brothers_creative/features/shop/controllers/banner_controller.dart';
import 'package:brothers_creative/features/shop/controllers/product/product_controller.dart';
import 'package:brothers_creative/features/shop/screens/all_products/all_products.dart';
import 'package:brothers_creative/features/shop/screens/home/widgets/album_list.dart';
import 'package:brothers_creative/features/shop/screens/home/widgets/gallery_slider.dart';
import 'package:brothers_creative/features/shop/screens/sale_product/sale_product.dart';
import 'package:brothers_creative/features/shop/screens/store/clients/all_clients.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:brothers_creative/utils/helpers/system_ui_helper.dart';
import 'package:brothers_creative/utils/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'widgets/home_appbar.dart';
import 'widgets/home_categories.dart';
import 'widgets/home_clients.dart';
import 'widgets/promo_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    //Get.updateLocale(const Locale('en'));

    final dark = THelperFunctions.isDarkMode(context);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarIconBrightness: dark ? Brightness.light : Brightness.dark,
    //   statusBarColor: dark ? TColors.black : TColors.white, // status bar color
    // ));
    Color iconColor = dark ? TColors.white : Colors.black;
    return Scaffold(
      // appBar: AppBar(
      //     systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarIconBrightness:
      //       Brightness.dark, // For Android (dark icons)
      //   statusBarBrightness: Brightness.light,
      //   // Status bar color
      //   statusBarColor: Colors.red,
      // )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      endDrawer: TDrawer(iconColor: iconColor),
      drawer: TDrawer(iconColor: iconColor),
      floatingActionButton: GestureDetector(
        onTap: () => selectAddMethode(context),
        child: TRoundedContainer(
          width: 45,
          height: 45,

          radius: BorderRadius.circular(40),
          child: const Icon(
            Iconsax.add_circle,
            color: Colors.black,
            fill: 1,
            size: 40,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TPrimaryHeaderContainer(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 18.0),
                      child: THomeAppbar(),
                    ),
                    const SizedBox(height: TSizes.spaceBtWsections / 2),
                    //   Text(Get.locale!.languageCode),
                    TPromoSlider(
                      images:
                          BannerController.instance.banners
                              .map((e) => e.image)
                              .toList(),
                    ),
                    // TSearchContainer(
                    //   text: 'Whats in your mind',
                    //   icon: Iconsax.information,
                    //   onTap: () {},
                    // ),
                    const SizedBox(height: TSizes.spaceBtWsections),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: TSizes.defaultSpace,
                        right: TSizes.defaultSpace,
                      ),
                      child: TSectionHeading(
                        textColor:
                            THelperFunctions.isDarkMode(context)
                                ? Colors.white
                                : Colors.black,
                        //popularCategory
                        title: AppLocalizations.of(context)!.popularCategory,
                        showActionButton: false,
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtWItems),
                    const THomeCategories(),
                    const SizedBox(height: TSizes.spaceBtWsections),
                  ],
                ),
              ),
              //body from here
              Padding(
                padding: const EdgeInsets.only(
                  left: TSizes.defaultSpace,
                  right: TSizes.defaultSpace,
                ),
                child: TSectionHeading(
                  title: AppLocalizations.of(context)!.gallery,
                  buttonTitle: AppLocalizations.of(context)!.viewAll,
                  showActionButton: true,
                  onPress: () => Get.to(() => const TGalleryScreen()),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtWItems),
              const TGallerySlider(autoPlay: false),
              const SizedBox(height: TSizes.spaceBtWsections),
              const TAlbumList(),
              const SizedBox(height: TSizes.spaceBtWsections),
              Padding(
                padding: const EdgeInsets.only(
                  left: TSizes.defaultSpace,
                  right: TSizes.defaultSpace,
                ),
                child: Column(
                  children: [
                    TSectionHeading(
                      title: AppLocalizations.of(context)!.popularProduct,
                      onPress:
                          () => Get.to(
                            () => AllProducts(
                              title:
                                  AppLocalizations.of(context)!.popularProduct,
                              query: FirebaseFirestore.instance
                                  .collection('Products')
                                  .where('IsFeature', isEqualTo: true)
                                  .limit(6),
                              futureMethode:
                                  controller.fetchAllFeatureProducts(),
                            ),
                          ),
                      showActionButton: true,
                      buttonTitle: AppLocalizations.of(context)!.viewAll,
                    ),
                    const SizedBox(height: TSizes.spaceBtWItems),
                    Obx(() {
                      if (controller.featuredProducts.isEmpty) {
                        return Center(
                          child: Text(
                            AppLocalizations.of(context)!.noData,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }
                      return TGridLayout(
                        maxAxisExtent: 300,
                        itemCount: controller.featuredProducts.length,
                        itemBuilder:
                            (_, index) => TProductCardVertical(
                              product: controller.featuredProducts[index],
                            ),
                      );
                    }),
                  ],
                ),
              ),

              //const TMovingText(),

              //show albums here
              //  const TAlbumTitle(),
              const SizedBox(height: TSizes.spaceBtWsections),

              Padding(
                padding: const EdgeInsets.only(
                  left: TSizes.defaultSpace,
                  right: TSizes.defaultSpace,
                ),
                child: TSectionHeading(
                  title: AppLocalizations.of(context)!.clients,
                  showActionButton: true,
                  onPress: () => Get.to(() => const AllClientsScreen()),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtWItems / 2),
              const THomeClient(),
              const SizedBox(height: TSizes.spaceBtWsections * 1.2),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> selectAddMethode(BuildContext context) {
  Color iconColor =
      THelperFunctions.isDarkMode(context) ? TColors.white : TColors.black;
  return showModalBottomSheet(
    context: context,
    builder:
        (_) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(TSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TSettingMenuTile(
                  onTap: () => Get.to(() => const AddNewProjectScreen()),
                  icon: Iconsax.element_plus,
                  iconColor: iconColor,
                  title: AppLocalizations.of(context)!.addProject,
                  subTitle: AppLocalizations.of(context)!.addProjectMessage,
                ),
                TSettingMenuTile(
                  onTap: () => Get.to(() => const AddNewPriceRequestScreen()),
                  icon: Iconsax.discount_shape4,
                  iconColor: iconColor,
                  title: AppLocalizations.of(context)!.priceRequest,
                  subTitle: AppLocalizations.of(context)!.priceRequestMessage,
                ),
              ],
            ),
          ),
        ),
  );
}

class TDrawer extends StatelessWidget {
  const TDrawer({super.key, required this.iconColor});

  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Drawer(
        width: THelperFunctions.screenwidth() / 1.3,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: TSizes.appBarHeight / 2),
              GestureDetector(
                onTap: () => Get.to(() => const BrotherScreen()),
                child: const Image(
                  image: AssetImage(TImages.wordWhite),
                  width: 100,
                  height: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
                child: Column(
                  children: [
                    // TSettingMenuTile(
                    //     onTap: () => Get.to(() => const AddNewProjectScreen()),
                    //     icon: Iconsax.element_plus,
                    //     iconColor: iconColor,
                    //     title: AppLocalizations.of(context)!.addProject,
                    //     subTitle:
                    //         AppLocalizations.of(context)!.addProjectMessage),
                    // TSettingMenuTile(
                    //     onTap: () =>
                    //         Get.to(() => const AddNewPriceRequestScreen()),
                    //     icon: Iconsax.discount_shape4,
                    //     iconColor: iconColor,
                    //     title: AppLocalizations.of(context)!.priceRequest,
                    //     subTitle:
                    //         AppLocalizations.of(context)!.priceRequestMessage),
                    TSettingMenuTile(
                      onTap:
                          () => // TLoader.warningSnackBar(title: 'comming soon'),
                              Get.to(() => const BlogScreen()),
                      icon: Icons.menu_book_outlined,
                      iconColor: iconColor,
                      title: AppLocalizations.of(context)!.lookNews,
                      subTitle: AppLocalizations.of(context)!.blogMessage,
                    ),
                    TSettingMenuTile(
                      onTap: () => Get.to(const SaleProducts()),
                      icon: Icons.discount_outlined,
                      iconColor: iconColor,
                      title: AppLocalizations.of(context)!.offersChick,
                      subTitle: AppLocalizations.of(context)!.offersMessage,
                    ),

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

                    //     // تحديث SystemUI بعد تغيير اللغة والنمط
                    //     // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //     //   TSystemUIHelper.updateSystemUI(context);
                    //     // });
                    //     TSystemUIHelper.forceUpdateSystemUI(
                    //       context,
                    //       THelperFunctions.isDarkMode(context),
                    //     );

                    //     Get.reload();
                    //   },
                    //   icon: Icons.language,
                    //   iconColor: iconColor,
                    //   title: AppLocalizations.of(context)!.changedTo,
                    //   subTitle:
                    //       AppLocalizations.of(context)!.chooseYourLanguage,
                    // ),
                    TSettingMenuTile(
                      icon: Iconsax.moon5,
                      iconColor: iconColor,
                      title: AppLocalizations.of(context)!.darkMode,
                      subTitle:
                          AppLocalizations.of(context)!.chooseYourPrightness,
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
                            TSystemUIHelper.forceUpdateSystemUI(context, true);
                          }
                        },
                      ),
                    ),

                    TSettingMenuTile(
                      onTap: () => AuthenticationRepository.instance.logOut(),
                      icon: Icons.logout,
                      iconColor: iconColor,
                      title: AppLocalizations.of(context)!.logout,
                      subTitle: AppLocalizations.of(context)!.logout,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
