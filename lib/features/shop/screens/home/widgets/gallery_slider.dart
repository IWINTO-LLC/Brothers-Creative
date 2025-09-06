import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/common/widgets/custom_shapes/containers/circuler_container.dart';
import 'package:brothers_creative/common/widgets/images/rounded_image.dart';
import 'package:brothers_creative/common/widgets/shimmers/shimmer.dart';
import 'package:brothers_creative/features/gallery/controller/gallery_controller.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';

class TGallerySlider extends StatelessWidget {
  const TGallerySlider({
    Key? key,
    this.autoPlay = true,
  }) : super(key: key);

  final bool autoPlay;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GalleryController());
    return Obx(() {
      if (controller.isLoading.value) {
        return Padding(
          padding: EdgeInsets.only(bottom: TSizes.defaultSpace / 2),
          child: TShimmerEffect(
              width: double.infinity,
              raduis: BorderRadius.circular(0),
              height: 190),
        );
      }
      if (controller.banners.isEmpty) {
        return Center(
          child: Text(AppLocalizations.of(context)!.noData),
        );
      }
      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: autoPlay,
                autoPlayCurve: Curves.linear,
                viewportFraction: 1,
                animateToClosest: true,
                onPageChanged: (index, _) =>
                    controller.updatePageIndicator(index)),
            items: controller.banners
                .map((banner) => TRoundedImage(
                      borderRaduis: BorderRadius.circular(0),
                      fit: BoxFit.fill,
                      width: THelperFunctions.screenwidth(),
                      imageUrl:
                          banner.image == "" ? TImages.bBlack : banner.image,
                      isNetworkImage: banner.image == "" ? false : true,
                    ))
                .toList(),
          ),
          const SizedBox(
            height: TSizes.spaceBtWItems,
          ),
          Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < controller.banners.length; i++)
                  TCirculerContainer(
                    width: 20,
                    height: 5,
                    margin: const EdgeInsets.only(right: 5, left: 5),
                    backgroundColor: controller.carousalCurrentIndex.value == i
                        ? TColors.black
                        : TColors.grey,
                  )
              ],
            ),
          )
        ],
      );
    });
  }
}
