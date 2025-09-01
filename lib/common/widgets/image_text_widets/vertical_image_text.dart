import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/common/widgets/images/custom_cache_image.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.borderColor,
    this.isNetworkImage = false,
    this.textColor,
    this.backgroundColor,
    this.onTap,
  });
  final String image, title;
  final Color? textColor;
  final bool isNetworkImage;

  final Color? backgroundColor;
  final Color? borderColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          right: TSizes.spaceBtWItems / 2.5,
          left: TSizes.spaceBtWItems / 2.5,
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TRoundedContainer(
                width: 80,
                height: 80,
                showBorder: true,
                borderColor:
                    THelperFunctions.isDarkMode(context)
                        ? Colors.black
                        : TColors.lightgrey,
                enableShadow:
                    THelperFunctions.isDarkMode(context) ? false : true,
                padding: const EdgeInsets.all(10),
                radius: BorderRadius.circular(100),
                child: CustomCaChedNetworkImage(
                  width: 65,
                  height: 65,
                  url: image,
                  fit: BoxFit.contain,
                  enableShadow: false,
                  raduis: BorderRadius.circular(0),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtWItems / 2),
            Wrap(
              children: [
                SizedBox(
                  width: 92,
                  child: Center(
                    child: Text(
                      title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!
                          .apply(color: textColor)
                          .copyWith(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
