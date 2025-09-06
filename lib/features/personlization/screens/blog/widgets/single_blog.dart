import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/common/widgets/texts/product_title_text.dart';
import 'package:brothers_creative/features/blog/model/blog_model.dart';
import 'package:brothers_creative/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TSingleBlog extends StatelessWidget {
  const TSingleBlog({
    super.key,
    required this.blog,
  });
  final BlogModel blog;
  @override
  Widget build(BuildContext context) {
    final isEg = Get.locale?.languageCode == 'en';
    return Scaffold(
      appBar: TAppBar(
        title: Text(isEg ? blog.title : blog.arabicTitle),
        showBackArrow: true,
        actions: const [
          Image(
              width: 40,
              color: TColors.primary,
              image: AssetImage(
                TImages.bBlack,
              ))
        ],
      ),
      body: SafeArea(
        child: TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          width: double.infinity,
          // showBorder: true,
          backgroundColor: Colors.transparent,
          margin: const EdgeInsets.only(bottom: TSizes.spaceBtWItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expanded(child: Image(image: AssetImage(TImages.appleIcon))),
              TRoundedContainer(
                  radius: BorderRadius.circular(20),
                  child: TPromoSlider(images: blog.images ?? [])),
              const SizedBox(
                height: TSizes.spaceBtWsections,
              ),
              Text(
                isEg ? blog.title : blog.arabicTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: TSizes.sm / 2,
              ),
              TProductTitleText(
                title: isEg ? blog.auther : blog.arabicAuther,
                smalSize: true,
                maxLines: 2,
              ),
              const SizedBox(
                height: TSizes.sm / 2,
              ),
              Text(
                isEg ? blog.details : blog.arabicDetails,
                maxLines: 100,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
