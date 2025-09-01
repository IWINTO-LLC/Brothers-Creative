import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/common/widgets/images/circular_image.dart';
import 'package:brothers_creative/common/widgets/product.cart/save_for_later_icon.dart';
import 'package:brothers_creative/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:brothers_creative/common/widgets/texts/product_price_text.dart';
import 'package:brothers_creative/common/widgets/texts/product_title_text.dart';
import 'package:brothers_creative/features/shop/controllers/product/product_controller.dart';
import 'package:brothers_creative/features/shop/models/product_model.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

import 'bottom_add_to_cart_widget.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePrecentage =
        controller.calculateSalePresentage(product.price, product.salePrice);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Price and sale price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (salePrecentage != null && double.parse(salePrecentage) > 0)
                  TRoundedContainer(
                    radius: BorderRadius.circular(TSizes.sm),
                    backgroundColor: TColors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.sm, vertical: TSizes.xs),
                    child: Text(
                      '$salePrecentage%',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: TColors.white),
                    ),
                  ),

                if (salePrecentage != null && double.parse(salePrecentage) > 0)
                  const SizedBox(
                    width: TSizes.spaceBtWItems / 2,
                  ),

                ///price
                if (product.price > 0)
                  TProductPriceText(
                      price: '${product.price}',
                      isLarg: false,
                      linethrough: true,
                      color: TColors.darkerGray),
                // Text(
                //   'SAR ${product.price}',
                //   style: Theme.of(context).textTheme.titleSmall!.apply(
                //       decoration: TextDecoration.lineThrough, color: Colors.red),
                // ),
                const SizedBox(width: TSizes.spaceBtWItems / 2),
                if (product.salePrice > 0)
                  TProductPriceText(
                      price: '${product.salePrice}', isLarg: true),
              ],
            ),
            Row(
              children: [
                TSaveForLaterIcon(productId: product.id),
                IconButton(
                    onPressed: () async {
                      final url = Uri.parse(product.thumbnail);
                      final response = await http.get(url);
                      final contentType = response.headers['content-type'];
                      final image = XFile.fromData(
                        response.bodyBytes,
                        mimeType: contentType,
                        name: 'Look what I like!',
                      );
                      await Share.shareXFiles([image],
                          text:
                              'Look what I like!  ${product.title} cost ${product.price} you can se the full image here ${product.thumbnail}');
                      // Share.share('check out my product \n\n $urlPreview',
                      //     subject:
                      //         'Look what I like! ${product.title} cost ${product.price}');

// }
//                       Share.share('check out my product ${product.thumbnail}',
//                           subject: 'Look what I like!')
                    },
                    icon:
                        const Icon(Icons.share_outlined, size: TSizes.iconMd)),
              ],
            )
          ],
        ),

        const SizedBox(
          height: TSizes.spaceBtWItems / 1.5,
        ),

        ///title
        TProductTitleText(
          title: Get.locale?.languageCode == 'en'
              ? product.title
              : product.arabicTitle,
        ),
        const SizedBox(
          height: TSizes.spaceBtWItems / 1.5,
        ),

        Row(
          children: [
            const TProductTitleText(
              title: 'Status',
              smalSize: true,
            ),
            const SizedBox(
              width: TSizes.spaceBtWItems,
            ),
            Text(
              controller.getProductStockStatus(product.stock),
              // style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtWItems / 1.5,
        ),

        ///Brand

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TCircularImage(
                  image: product.brand!.image != ''
                      ? product.brand!.image
                      : TImages.bBlack,
                  isNetworkImage: product.brand!.image != '' ? true : false,
                  width: 32,
                  height: 32,
                ),
                const SizedBox(
                  width: TSizes.spaceBtWItems / 1.5,
                ),
                TBrandTitleWithVerifiedIcon(
                    title: product.brand != null ? product.brand!.name : ''),
              ],
            ),
            TBottomAddToCart(
              product: product,
            ),
          ],
        ),
      ],
    );
  }
}
