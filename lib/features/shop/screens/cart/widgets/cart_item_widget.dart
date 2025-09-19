// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brothers_creative/common/widgets/images/rounded_image.dart';
import 'package:brothers_creative/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:brothers_creative/common/widgets/texts/product_price_text.dart';
import 'package:brothers_creative/common/widgets/texts/product_title_text.dart';
import 'package:brothers_creative/features/shop/controllers/product/cart_controller.dart';
import 'package:brothers_creative/features/shop/models/cart_item_model.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import 'add_remove_button.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    Key? key,
    required this.cartItem,
    this.showAddRemoveButtons = false,
  }) : super(key: key);
  final CartItemModel cartItem;
  final bool? showAddRemoveButtons;
  @override
  Widget build(BuildContext context) {
    bool dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        TRoundedImage(
          borderRaduis: BorderRadius.circular(20),
          imageUrl: cartItem.image ?? TImages.bBlack,

          isNetworkImage: cartItem.image != null ? true : false,
          fit: BoxFit.cover,
          backgroundColor: dark ? TColors.darkerGray : TColors.light,
          // border: Border.all(color: TColors.primary),
          width: 100,
          height: 120,
          padding: const EdgeInsets.all(0),
        ),
        const SizedBox(width: TSizes.spaceBtWItems),
        Expanded(
          child: SizedBox(
            height: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TBrandTitleWithVerifiedIcon(title: cartItem.brandName ?? ''),
                Flexible(
                  child: TProductTitleText(
                    title: cartItem.title,
                    maxLines: 1,
                    smalSize: true,
                  ),
                ),
                // TSaveForLaterIcon(productId: cartItem.productId),
                if (showAddRemoveButtons!) const Spacer(),
                if (showAddRemoveButtons!)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          //
                          // // ),
                          TProductQuantityWithAddRemoveButtons(
                            quantity: cartItem.quantity,
                            add:
                                () => CartController.instance.addOneToCart(
                                  cartItem,
                                ),
                            remove:
                                () => CartController.instance.removeOneFromCart(
                                  cartItem,
                                ),
                          ),
                        ],
                      ),
                      TProductPriceText(
                        color:
                            THelperFunctions.isDarkMode(context)
                                ? Colors.white
                                : Colors.black,
                        isLarg: false,
                        price: (cartItem.price * cartItem.quantity)
                            .toStringAsFixed(1),
                      ),
                    ],
                  ),

                ///Atributes
              ],
            ),
          ),
        ),
      ],
    );
  }
}
