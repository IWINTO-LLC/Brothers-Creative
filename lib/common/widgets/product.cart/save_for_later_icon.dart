// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brothers_creative/common/widgets/icons/circuler_icon.dart';
import 'package:brothers_creative/features/shop/controllers/product/cart_controller.dart';
import 'package:brothers_creative/features/shop/controllers/product/later_list_controller.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
//
import 'package:get/get.dart';

//TFavoriteIcon
class TSaveForLaterIcon extends StatelessWidget {
  const TSaveForLaterIcon({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LaterListController());
    var id = CartController.instance.cartItems.indexOf(productId);
    final iconColor =
        THelperFunctions.isDarkMode(context) ? Colors.white : Colors.black;
    return Obx(
      () => Row(
        children: [
          //Text(AppLocalizations.of(context)!.saveForLater),
          TCircularIcon(
            backgroundColor: Colors.transparent,
            size: 25,
            icon:
                controller.isLaterShoping(productId)
                    ? Icons.bookmark_outlined
                    : Icons.bookmark_border,
            color:
                controller.isLaterShoping(productId)
                    ? TColors.primary
                    : iconColor,
            onPressed: () {
              controller.toggleLaterShopingProduct(productId);
              CartController.instance.cartItems.removeAt(id);
              CartController.instance.updateCart();
            },
          ),
        ],
      ),
    );
  }
}
