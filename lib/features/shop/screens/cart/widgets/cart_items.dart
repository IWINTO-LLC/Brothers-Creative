import 'package:brothers_creative/features/shop/controllers/product/cart_controller.dart';
import 'package:brothers_creative/features/shop/controllers/product/later_list_controller.dart';
import 'package:brothers_creative/features/shop/screens/product_details/product_detail.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import 'cart_item_widget.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButtons = true});
  final bool showAddRemoveButtons;
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => const Column(
          children: [
            SizedBox(
              height: TSizes.sm,
            ),
            Divider(),
            SizedBox(
              height: TSizes.sm,
            ),
          ],
        ),
        itemCount: cartController.cartItems.length,
        itemBuilder: (_, index) => Obx(() {
          final item = cartController.cartItems[index];
          return Column(
            children: [
              Slidable(
                // Specify a key if the Slidable is dismissible.
                key: const ValueKey(0),
                endActionPane: ActionPane(
                  extentRatio: .6,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      // An action can be bigger than the others.

                      onPressed: (context) {
                        LaterListController.instance
                            .toggleLaterShopingProduct(item.productId);
                        LaterListController.instance.saveLaterShopToStorage();
                        CartController.instance.cartItems.removeAt(index);
                        CartController.instance.updateCart();
                      },
                      flex: 2,
                      borderRadius: BorderRadius.circular(10),
                      autoClose: true,
                      // backgroundColor: TColors.primary.withValues(alpha:.2),
                      foregroundColor: TColors.primary,
                      padding: const EdgeInsets.all(10),
                      spacing: 2,
                      icon: Icons.archive,
                      label: AppLocalizations.of(context)!.saveForLater,
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        CartController.instance.cartItems.removeAt(index);
                        CartController.instance.updateCart();
                      },
                      //backgroundColor: TColors.red.withValues(alpha:.3),
                      foregroundColor: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      padding: const EdgeInsets.all(3),
                      autoClose: true,
                      icon: Icons.delete,
                      label: AppLocalizations.of(context)?.delete,
                    ),
                  ],
                ),

                child: GestureDetector(
                  onTap: () =>
                      Get.to(ProductDetailsScreen(product: item.product)),
                  child: TCartItem(
                    cartItem: item,
                    showAddRemoveButtons: showAddRemoveButtons,
                  ),
                ),
              ),

              //--add & remove buttons
            ],
          );
        }),
      ),
    );
  }
}
