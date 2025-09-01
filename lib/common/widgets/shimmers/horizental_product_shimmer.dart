import 'package:brothers_creative/common/widgets/shimmers/shimmer.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class THorizentalProductShummer extends StatelessWidget {
  const THorizentalProductShummer({super.key, this.itemCount = 4});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: itemCount,
        scrollDirection: Axis.vertical,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 320,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TShimmerEffect(width: 120, height: 120),
                SizedBox(
                  width: TSizes.spaceBtWItems,
                ),

                ///text
                Column(
                  children: [
                    TShimmerEffect(width: 110, height: 15),
                    SizedBox(height: TSizes.spaceBtWItems),
                    TShimmerEffect(width: 140, height: 15),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
