import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';

import 'package:brothers_creative/common/widgets/shimmers/shimmer.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';

import 'package:flutter/material.dart';

class THomeAlbumShimmer extends StatelessWidget {
  const THomeAlbumShimmer({super.key, this.itemCount = 4});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: itemCount,
        itemBuilder: (_, __) => TRoundedContainer(
              width: THelperFunctions.screenwidth() - 100,
              child: TShimmerEffect(
                width: THelperFunctions.screenwidth() - TSizes.defaultSpace * 2,
                height: THelperFunctions.screenwidth() / 1.7,
              ),
            ));
  }
}
