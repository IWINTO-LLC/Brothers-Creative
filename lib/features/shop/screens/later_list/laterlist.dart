import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:brothers_creative/common/widgets/shimmers/horizental_product_shimmer.dart';
import 'package:brothers_creative/features/shop/controllers/product/later_list_controller.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/navigation_menu.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/cloud_helper_function.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class LaterListScreen extends StatelessWidget {
  const LaterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LaterListController.instance;
    return Directionality(
      textDirection:
          Get.locale?.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: Scaffold(
        appBar: TAppBar(
          actions: [
            IconButton(
              icon: const Text('Delete all List'), // Icon(Icons.delete),
              onPressed: () => controller.deleteLaterList(),
            ),
          ],
          showBackArrow: true,
          title: Text(AppLocalizations.of(context)!.laterList),
          // actions: [
          //   TCircularIcon(
          //     icon: Iconsax.add,
          //     onPressed: () {
          //       NavigationController.instance.selectedIndex.value = 1;
          //       Get.to(const NavigationMenu());
          //     },
          //   )
          // ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Obx(
              () => FutureBuilder(
                future: controller.laterListProducts(),
                builder: (context, snapshot) {
                  final emptyWidget = Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: TSizes.spaceBtWsections),
                        const Image(image: AssetImage(TImages.cartEmpty)),
                        Text(
                          AppLocalizations.of(context)!.noData,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: TSizes.appBarHeight),
                        ElevatedButton(
                          onPressed: () {
                            NavigationController.instance.selectedIndex.value =
                                1;
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
                  const loader = THorizentalProductShummer(itemCount: 6);
                  final widget = TCloudHelperFunctions.checkMuiltiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                    nothingFound: emptyWidget,
                  );
                  if (widget != null) return widget;
                  final product = snapshot.data!;

                  return SizedBox(
                    child: ListView.separated(
                      itemCount: product.length,
                      scrollDirection: Axis.vertical,
                      separatorBuilder:
                          (BuildContext context, int index) => const Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          // Specify a key if the Slidable is dismissible.
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            extentRatio: .4,
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  LaterListController.instance
                                      .toggleLaterShopingProduct(
                                        product[index].id,
                                      );
                                  // CartController.instance.updateCart();
                                },
                                backgroundColor:
                                    THelperFunctions.isDarkMode(context)
                                        ? TColors.black
                                        : TColors.textWhite,
                                foregroundColor: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                                padding: const EdgeInsets.all(3),
                                autoClose: true,
                                icon: Icons.delete,
                                label: AppLocalizations.of(context)?.delete,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: SizedBox(
                                height: 130,
                                child: TProductCardHorizontal(
                                  product: product[index],
                                ),
                              ),
                            ),
                          ),
                        );

                        // ListTile(
                        //   leading: Image(
                        //       image: NetworkImage(product[index].thumbnail)),
                        //   title: Text(product[index].arabicTitle),
                        // );
                      },
                    ),
                  );

                  // return ListView.builder(
                  //     shrinkWrap: true,
                  //     padding: EdgeInsets.zero,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     itemCount: product.length,
                  //     itemBuilder: (_, index) => TProductCardHorizontal(
                  //           product: product[index],
                  //         ));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
