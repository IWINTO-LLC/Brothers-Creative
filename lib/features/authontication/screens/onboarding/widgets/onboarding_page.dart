import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle});
  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            SizedBox(
              width: THelperFunctions.screenwidth(),
              height: THelperFunctions.screenHeight(),
              //color: TColors.black.withValues(alpha:0.8),
              child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: image,
                  progressIndicatorBuilder: (_, __, downloadProgress) =>
                      Transform.scale(
                          scale: 0.1,
                          child: CircularProgressIndicator(
                            color: TColors.darkGrey.withValues(alpha: 0.3),
                          ))),
            ),

            // image != ''
            //     ? NetworkImage(image) as ImageProvider
            //     : const AssetImage(TImages.bBlack),

            TRoundedContainer(
             
              width: THelperFunctions.screenwidth(),
              height: THelperFunctions.screenHeight(),
              backgroundColor: TColors.black.withValues(alpha: 0.3),
            ),
          ],
        ),
        // TRoundedContainer(
        //   child: Stack(
        //     children: [
        //       Image(
        //         fit: BoxFit.cover,
        //         width: THelperFunctions.screenwidth(),
        //         height: THelperFunctions.screenHeight(),
        //         image: image != ''
        //             ? NetworkImage(image) as ImageProvider
        //             : const AssetImage(TImages.bBlack),
        //       ),
        //       TRoundedContainer(
        //         width: THelperFunctions.screenwidth(),
        //         height: THelperFunctions.screenHeight(),
        //         backgroundColor: TColors.black.withValues(alpha:0.2),
        //       )
        //     ],
        //   ),
        // ),
        Positioned(
          bottom: 140,
          child:  SizedBox(
                  width: THelperFunctions.screenwidth()-10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtWItems,
                  ),
                  Text(
                    subTitle,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
               
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
