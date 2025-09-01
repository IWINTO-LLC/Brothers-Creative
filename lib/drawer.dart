import 'package:brothers_creative/features/personlization/screens/profile/brothers.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';


import 'utils/constants/color.dart';
import 'utils/constants/image_strings.dart';
import 'package:get/get.dart';
class TDrawer extends StatelessWidget {
  const TDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: SizedBox(
            width: THelperFunctions.screenwidth() * 0.8,
            child: Drawer(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: Column(children: [
                const SizedBox(
                  height: TSizes.spaceBtWsections,
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const BrotherScreen()),
                  child: Positioned(
                    left: 0,
                    child: Image(
                      image: AssetImage(Get.locale?.languageCode == 'en'
                          ? TImages.wordWhite
                          : TImages.arWord),
                      width: 125,
                      height: 50,
                      color: TColors.primary,
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(TSizes.defaultSpace),
                //   child: Column(
                //     children: [
                //       TSettingMenuTile(
                //           onTap: () => Get.to(() => const AddNewProjectScreen()),
                //           icon: Iconsax.element_plus,
                //           iconColor: iconColor,
                //           title: AppLocalizations.of(context)!.addProject,
                //           subTitle:
                //               'you can Request for new Project or decoration'),
                //       TSettingMenuTile(
                //           onTap: () =>
                //               Get.to(() => const AddNewPriceRequestScreen()),
                //           icon: Iconsax.discount_shape4,
                //           iconColor: iconColor,
                //           title: AppLocalizations.of(context)!.priceRequest,
                //           subTitle: 'sunt laboris commodo in.'),
                //       TSettingMenuTile(
                //           onTap: () =>
                //               TLoader.warningSnackBar(title: 'comming soon'),
                //           icon: Iconsax.video,
                //           iconColor: iconColor,
                //           title: AppLocalizations.of(context)!.interviewRequest,
                //           subTitle:
                //               'Officia adipisicing culpa nulla magna incididunt velit consectetur irure.'),
                //       TSettingMenuTile(
                //           onTap:
                //               () => // TLoader.warningSnackBar(title: 'comming soon'),
                //                   Get.to(() => const BlogScreen()),
                //           icon: Icons.menu_book_outlined,
                //           iconColor: iconColor,
                //           title: AppLocalizations.of(context)!.lookNews,
                //           subTitle: 'sunt laboris commodo in.'),
                //       TSettingMenuTile(
                //           onTap: () =>
                //               TLoader.warningSnackBar(title: 'comming soon'),
                //           icon: Icons.discount_outlined,
                //           iconColor: iconColor,
                //           title: AppLocalizations.of(context)!.offersChick,
                //           subTitle:
                //               'Officia adipisicing culpa nulla magna incididunt velit consectetur irure.'),
                //     ],
                //   ),
                // ),
              ]),
            )));
  }
}
