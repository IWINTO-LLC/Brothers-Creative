import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/common/widgets/loaders/animation_loading.dart';
import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';

import 'package:brothers_creative/features/shop/controllers/product/order_controller.dart';
import 'package:brothers_creative/features/shop/screens/wellcome_widget.dart';
import 'package:brothers_creative/navigation_menu.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/cloud_helper_function.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';

class TOrderListItem extends StatelessWidget {
  const TOrderListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(OrderController());

    return !AuthenticationRepository.instance.isGust.value
        ? FutureBuilder(
            future: controller.fetchUserOrders(),
            builder: (_, snapshot) {
              final emptyWidget = TAnimationLoaderWidget(
                text: 'no order yet ',
                animation: TImages.proccessLottie,
                showAction: true,
                actionText: 'let us fill it',
                onActionPressed: () => Get.off(() => const NavigationMenu()),
              );
              final response = TCloudHelperFunctions.checkMuiltiRecordState(
                  snapshot: snapshot, nothingFound: emptyWidget);
              if (response != null) return response;
              final orders = snapshot.data!;
              return ListView.separated(
                shrinkWrap: true,
                itemCount: orders.length,
                separatorBuilder: (_, __) => const SizedBox(
                  height: TSizes.spaceBtWItems,
                ),
                itemBuilder: (_, index) => TRoundedContainer(
                    showBorder: true,
                    padding: const EdgeInsets.all(TSizes.md),
                    backgroundColor: dark ? TColors.dark : TColors.light,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Iconsax.ship),
                          const SizedBox(width: TSizes.spaceBtWItems / 2),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                orders[index].orderStatusText,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .apply(
                                        color: TColors.primary,
                                        fontWeightDelta: 1),
                              ),
                              Text(orders[index].formattedOrderDate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                            ],
                          )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Get.locale?.languageCode == 'en'
                                    ? Icons.keyboard_arrow_right
                                    : Icons.keyboard_arrow_left,
                                size: TSizes.iconMd,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtWItems,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Iconsax.tag),
                                const SizedBox(width: TSizes.spaceBtWItems / 2),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.order,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .apply(fontWeightDelta: 1),
                                    ),
                                    Text(orders[index].id,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Iconsax.tag),
                                const SizedBox(width: TSizes.spaceBtWItems / 2),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .shippingDate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .apply(fontWeightDelta: 1),
                                    ),
                                    Text(orders[index].formattedDeliveryDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ])),
              );
            })
        : const WellcomeWidget();
  }
}
