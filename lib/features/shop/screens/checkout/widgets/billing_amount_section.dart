import 'package:brothers_creative/common/widgets/texts/product_price_text.dart';
import 'package:brothers_creative/features/shop/controllers/product/cart_controller.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalOfCartPrice.value;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('subtotal', style: Theme.of(context).textTheme.bodyMedium),
            TProductPriceText(price: subTotal.toString()),
            //Text('\$', style: Theme.of(context).textTheme.bodyLarge)
          ],
        ),
        const SizedBox(height: TSizes.spaceBtWItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shipping free',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TProductPriceText(price: 0.toString()),
            //Text('\$6.0', style: Theme.of(context).textTheme.bodyLarge)
          ],
        ),
        const SizedBox(height: TSizes.spaceBtWItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
            TProductPriceText(price: subTotal.toString()),
            // Text('\$230.0', style: Theme.of(context).textTheme.bodyLarge)
          ],
        ),
      ],
    );
  }
}
