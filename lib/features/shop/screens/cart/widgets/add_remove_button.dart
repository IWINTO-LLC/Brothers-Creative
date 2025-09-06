// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:brothers_creative/common/widgets/icons/circuler_icon.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';

class TProductQuantityWithAddRemoveButtons extends StatelessWidget {
  const TProductQuantityWithAddRemoveButtons({
    super.key,
    required this.quantity,
    this.remove,
    this.add,
  });
  final int quantity;
  final VoidCallback? add, remove;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TCircularIcon(
          icon: Iconsax.minus,
          width: 35,
          height: 35,
          size: 20,
          onPressed: remove,
          color:
              THelperFunctions.isDarkMode(context)
                  ? TColors.white
                  : Colors.black,
          backgroundColor:
              THelperFunctions.isDarkMode(context)
                  ? TColors.darkerGray
                  : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtWItems),
        Text(
          quantity.toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(width: TSizes.spaceBtWItems),
        TCircularIcon(
          icon: Iconsax.add,
          width: 35,
          height: 35,
          size: 20,
          color:
              THelperFunctions.isDarkMode(context)
                  ? TColors.white
                  : Colors.black,
          backgroundColor:
              THelperFunctions.isDarkMode(context)
                  ? TColors.darkerGray
                  : TColors.light,
          onPressed: add,
        ),
      ],
    );
  }
}
