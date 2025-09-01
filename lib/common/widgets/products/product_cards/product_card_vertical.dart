// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brothers_creative/common/styles/shadows.dart';
import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/common/widgets/products/product_cards/add_to_cart_button.dart';
import 'package:brothers_creative/common/widgets/texts/product_price_text.dart';
import 'package:brothers_creative/common/widgets/texts/product_title_text.dart';
import 'package:brothers_creative/features/shop/controllers/product/product_controller.dart';
import 'package:brothers_creative/features/shop/models/product_model.dart';
import 'package:brothers_creative/features/shop/screens/product_details/product_detail.dart';
import 'package:brothers_creative/features/shop/screens/product_details/widgets/product_image_slider_mini.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final isEg = Get.locale?.languageCode == 'en';
    final controller = ProductController.instance;

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          color: dark ? TColors.dark.withValues(alpha: 0.5) : TColors.white,
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        ),
        child: SizedBox(
          height: 210,
          child: Column(
            children: [
              TRoundedContainer(
                enableShadow: true,

                radius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
                height: THelperFunctions.screenwidth() / 2,
                child: TProductImageSliderMini(product: product),
              ),

              //details section
              const SizedBox(height: TSizes.sm),

              Padding(
                padding: const EdgeInsets.only(
                  left: TSizes.sm,
                  right: TSizes.sm,
                ),
                child: Column(
                  children: [
                    TProductTitleText(
                      title: isEg ? product.title : product.arabicTitle,
                      txtAlign: isEg ? TextAlign.left : TextAlign.right,
                      smalSize: true,
                    ),
                  ],
                ),
              ),
              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              isEg
                                  ? const EdgeInsets.only(left: TSizes.sm)
                                  : const EdgeInsets.only(right: TSizes.sm),
                          child: TProductPriceText(
                            price: controller.getProductPrice(product),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ProductAddToCartButton(product: product),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
