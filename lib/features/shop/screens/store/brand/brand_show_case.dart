import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/common/widgets/images/custom_cache_image.dart';
import 'package:brothers_creative/common/widgets/shimmers/shimmer.dart';
import 'package:brothers_creative/features/shop/models/brand_model.dart';
import 'package:brothers_creative/features/shop/screens/store/brand/brand_card.dart';
import 'package:brothers_creative/features/shop/screens/store/brand/brand_product.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TBrandShowCase extends StatelessWidget {
  const TBrandShowCase({super.key, required this.images, required this.brand});
  final List<String> images;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: TRoundedContainer(
        showBorder: true,
        radius: BorderRadius.circular(15),
        // borderColor: TColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(TSizes.md),
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtWItems),
        child: Column(
          children: [
            //--Brand with product count
            TBrandCard(showBorder: false, brand: brand),
            const SizedBox(height: TSizes.spaceBtWItems),

            //--brand Top 3 Product Images
            Row(
              children:
                  images
                      .map(
                        (image) => brandTopProductImageWidget(image, context),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
      child: TRoundedContainer(
        radius: BorderRadius.circular(15),
        height: 100,
        backgroundColor:
            THelperFunctions.isDarkMode(context)
                ? TColors.darkGrey
                : TColors.light,
        margin: const EdgeInsets.only(right: TSizes.sm),
        padding: const EdgeInsets.all(TSizes.md),
        child: CustomCaChedNetworkImage(
          height: double.infinity,

          width: double.infinity,
          url: image,
          raduis: BorderRadius.circular(15),
          enableShadow: false,
          enableborder: false,
          fit: BoxFit.contain,
        ),

        // CachedNetworkImage(
        //   fit: BoxFit.contain,

        //   imageUrl: image,
        //   progressIndicatorBuilder:
        //       (context, url, downloadProgress) =>
        //           const TShimmerEffect(width: 100, height: 100),
        //   errorWidget: (context, url, error) => const Icon(Icons.error),
        // ),
      ),
    );
  }
}
