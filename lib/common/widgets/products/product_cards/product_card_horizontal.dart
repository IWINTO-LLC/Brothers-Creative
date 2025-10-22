import 'package:brothers_creative/common/widgets/products/product_cards/add_to_cart_button.dart';
import 'package:brothers_creative/common/widgets/texts/product_price_text.dart';
import 'package:brothers_creative/features/shop/controllers/product/product_controller.dart';
import 'package:brothers_creative/features/shop/models/product_model.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(TSizes.sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: dark ? TColors.dark : TColors.light,
        border: Border.all(color: dark ? TColors.dark : TColors.grey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة المنتج
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSizes.sm),
              color: dark ? TColors.dark : TColors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(TSizes.sm),
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image, size: 50);
                },
              ),
            ),
          ),

          const SizedBox(width: TSizes.sm),

          // تفاصيل المنتج
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // اسم المنتج
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: TSizes.xs),

                  // الماركة
                  if (product.brand != null)
                    Text(
                      product.brand!.name,
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),

                  const SizedBox(height: TSizes.sm),

                  // السعر
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // السعر
                      Expanded(
                        child: TProductPriceText(
                          price: ProductController.instance.getProductPrice(
                            product,
                          ),
                        ),
                      ),

                      const SizedBox(width: TSizes.xs),

                      // زر الإضافة للسلة
                      ProductAddToCartButton(product: product),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
