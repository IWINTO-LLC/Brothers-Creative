// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brothers_creative/features/shop/controllers/product/cart_controller.dart';
import 'package:brothers_creative/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';

class ProductAddToCartButton extends StatelessWidget {
  const ProductAddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    //final  = Get.locale?.languageCode == 'en';
    final controller = CartController.instance;
    return InkWell(
      onTap: () {
        final cartItem = controller.convertToCartItem(product, 1);
        controller.addOneToCart(cartItem);
      },
      child: Obx(() {
        final productQuantityInCart = controller.getProductQuantityInCart(
          product.id,
        );
        return Container(
          decoration: BoxDecoration(
            border:
                productQuantityInCart > 0
                    ? null
                    : Border.all(color: TColors.lightgrey),
            boxShadow: productQuantityInCart > 0 ? TColors.tboxShadow : null,
            color: productQuantityInCart > 0 ? Colors.black : TColors.white,
            borderRadius: BorderRadius.circular(50),
            // isEg
            //     ? const BorderRadius.only(
            //       topLeft: Radius.circular(TSizes.productImageRadius),
            //       bottomRight: Radius.circular(TSizes.productImageRadius),
            //     )
            //     : const BorderRadius.only(
            //       topRight: Radius.circular(TSizes.productImageRadius),
            //       bottomLeft: Radius.circular(TSizes.productImageRadius),
            //     ),
          ),
          child: SizedBox(
            width: TSizes.iconLg * 1.2,
            height: TSizes.iconLg * 1.2,
            child: Center(
              child:
                  productQuantityInCart > 0
                      ? Text(
                        productQuantityInCart.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color:
                              productQuantityInCart > 0
                                  ? TColors.white
                                  : Colors.black,
                        ),
                      )
                      : const Icon(Iconsax.add, color: Colors.black),
            ),
          ),
        );
      }),
    );
  }
}
