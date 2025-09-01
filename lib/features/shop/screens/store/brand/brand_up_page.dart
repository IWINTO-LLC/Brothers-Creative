// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brothers_creative/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:brothers_creative/features/shop/models/brand_model.dart';
import 'package:flutter/material.dart';

import 'package:brothers_creative/common/widgets/images/circular_image.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';

class TBrandUpPage extends StatelessWidget {
  const TBrandUpPage({
    Key? key,
    required this.showBorder,
    required this.brand,
    this.onTap,
  }) : super(key: key);
  final BrandModel brand;
  final bool showBorder;

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TPrimaryHeaderContainer(
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    opacity: 0.7,
                    image: NetworkImage(
                      brand.cover,
                    ))),
            height: THelperFunctions.screenHeight() / 3.5,
            padding: const EdgeInsets.all(TSizes.sm),
            // backgroundColor: THelperFunctions.isDarkMode(context)
            //     ? TColors.darkContainer
            //     : TColors.lightContainer,
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const Spacer(),
                  Row(
                    children: [
                      Flexible(
                        child: TCircularImage(
                            width: 70,
                            height: 70,
                            image: brand.image == ''
                                ? TImages.bBlack
                                : brand.image,
                            isNetworkImage: brand.image == '' ? false : true,
                            backgroundColor: Colors.transparent),
                      ),
                      const SizedBox(height: TSizes.spaceBtWItems / 1.5),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              brand.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: TColors.white),
                            ),
                            Text(
                              ' ${brand.productCount ?? 0} Product ',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: TColors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
