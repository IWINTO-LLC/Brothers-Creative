import 'package:brothers_creative/common/widgets/custom_shapes/containers/circuler_container.dart';
import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/common/widgets/product.cart/favorite_icon.dart';
import 'package:brothers_creative/common/widgets/shimmers/shimmer.dart';
import 'package:brothers_creative/features/shop/controllers/product/images_controller.dart';
import 'package:brothers_creative/features/shop/controllers/product/product_controller.dart';
import 'package:brothers_creative/features/shop/models/product_model.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TProductImageSliderMini extends StatelessWidget {
  const TProductImageSliderMini({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagesController());
    //RxInt selectdindex = 0.obs;
    final images = controller.getAllProductImage(product);
    //final dark = THelperFunctions.isDarkMode(context);
    final salePrecentage = ProductController.instance.calculateSalePresentage(
      product.price,
      product.salePrice,
    );
    final s = double.parse(salePrecentage!);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero,
          ),
          child: CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, _) {
                controller.selectdindex.value = index;
              },

              height: (THelperFunctions.screenwidth() / 2) * (4 / 3) + 5,
              viewportFraction: 1,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              // enlargeCenterPage: true,
            ),
            items:
                images
                    .map(
                      (item) => CachedNetworkImage(
                        imageUrl: item,
                        imageBuilder:
                            (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero,
                                ),
                                color: TColors.light,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => ClipRRect(
                              //  borderRadius: BorderRadius.circular(0),
                              child: TShimmerEffect(
                                raduis: BorderRadius.circular(20),
                                width: THelperFunctions.screenwidth() / 2,
                                height:
                                    (THelperFunctions.screenwidth() / 2) *
                                    (4 / 3),
                              ),
                            ),
                        errorWidget:
                            (context, url, error) =>
                                const Icon(Icons.error, size: 50),
                      ),
                    )
                    .toList(),
          ),
        ),
        if (product.images!.isNotEmpty)
          Positioned(
            bottom: 12,
            left: 4,
            right: 4,
            child: SizedBox(
              height: 8,
              child: Center(
                child: ListView.separated(
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder:
                      (_, index) => Obx(
                        () => TCirculerContainer(
                          width: 8,
                          height: 8,
                          // margin: const EdgeInsets.only(right: 2, left: 2),
                          backgroundColor:
                              index == controller.selectdindex.value
                                  ? TColors.primary
                                  : TColors.darkGrey,
                        ),
                      ),
                  separatorBuilder:
                      (_, __) =>
                          const SizedBox(width: TSizes.spaceBtWItems / 3),
                ),
              ),
            ),
          ),
        if (s > 0)
          Positioned(
            top: 8, // تقليل المسافة من الأعلى
            left: 8,
            child: TRoundedContainer(
              radius: BorderRadius.circular(TSizes.sm),
              backgroundColor: TColors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.sm,
                vertical: TSizes.xs,
              ),
              child: Text(
                '${s.toInt()}%', // تحسين عرض النسبة المئوية
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.apply(color: TColors.white),
              ),
            ),
          ),

        //favorite icon button
        Positioned(
          top: 0,
          right: 0,
          child: TFavoriteIcon(productId: product.id),
        ),
      ],
    );
  }
}
