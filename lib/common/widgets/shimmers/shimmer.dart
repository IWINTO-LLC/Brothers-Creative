import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TShimmerEffect extends StatelessWidget {
  const TShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.raduis,
    this.color,
  });

  final double width, height;
  final BorderRadius? raduis;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);

    return Shimmer.fromColors(
      baseColor:
          THelperFunctions.isDarkMode(context)
              ? TColors.darkerGray
              : TColors.lightgrey,
      highlightColor:
          THelperFunctions.isDarkMode(context)
              ? TColors.darkGrey
              : TColors.lightgrey.withValues(alpha: .3),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (TColors.white),
          borderRadius: raduis ?? BorderRadius.circular(15),
        ),
      ),
    );
  }
}
