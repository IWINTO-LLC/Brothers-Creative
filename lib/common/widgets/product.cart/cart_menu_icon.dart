import 'package:brothers_creative/features/shop/controllers/product/cart_controller.dart';
import 'package:brothers_creative/features/shop/screens/cart/cart.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    required this.iconColor,
    required this.onPress,
  });
  final Color iconColor;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    final dark = THelperFunctions.isDarkMode(context);

    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const CartScreen()),
          icon: Icon(CupertinoIcons.shopping_cart, color: iconColor),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: dark ? TColors.white : TColors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Obx(
                () => Text(
                  controller.numOfCartItems.value.toString(),
                  style: Theme.of(context).textTheme.labelLarge!.apply(
                    color:
                        THelperFunctions.isDarkMode(context)
                            ? TColors.black
                            : TColors.white,
                    fontSizeFactor: 0.8,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
