import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/common/widgets/loaders/animation_loading.dart';
import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/features/project/controllers/ask_price_controller.dart';
import 'package:brothers_creative/features/project/screens/prices/add_new_price_request.dart';
import 'package:brothers_creative/features/shop/screens/wellcome_widget.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/cloud_helper_function.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TPricesList extends StatelessWidget {
  const TPricesList({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(AskPriceController());

    return !AuthenticationRepository.instance.isGust.value
        ? FutureBuilder(
            future: controller.fetchUserRequest(),
            builder: (_, snapshot) {
              final emptyWidget = TAnimationLoaderWidget(
                text: 'No Request yet ',
                animation: TImages.cartEmptyLottie,
                showAction: false,
                actionText: 'Here you can request for price',
                onActionPressed: () =>
                    Get.off(() => const AddNewPriceRequestScreen()),
              );
              final response = TCloudHelperFunctions.checkMuiltiRecordState(
                  snapshot: snapshot, nothingFound: emptyWidget);
              if (response != null) return response;
              final requests = snapshot.data!;
              return ListView.separated(
                shrinkWrap: true,
                itemCount: requests.length,
                separatorBuilder: (_, __) => const SizedBox(
                  height: TSizes.spaceBtWItems,
                ),
                itemBuilder: (_, index) => TRoundedContainer(
                    showBorder: true,
                    padding: const EdgeInsets.all(TSizes.md),
                    backgroundColor: dark ? TColors.dark : TColors.light,
                    child: InkWell(
                      onTap: () {}
                      // => Get.to(() => TSinglePriceRequestScreen(
                      //       project: requests[index],
                      ,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Iconsax.status),
                            const SizedBox(width: TSizes.spaceBtWItems / 2),
                            Expanded(
                                child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  requests[index].state ?? 'un complete',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                          color: TColors.primary,
                                          fontWeightDelta: 1),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  '${requests[index].proposedPrice}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                          color: TColors.primary,
                                          fontWeightDelta: 1),
                                ),

                                // Text(projects[index].formattedStartDate,
                                //     style: Theme.of(context).textTheme.headlineSmall),
                              ],
                            )),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Get.locale?.languageCode == 'en'
                                      ? Icons.keyboard_arrow_right
                                      : Icons.keyboard_arrow_left,
                                  size: TSizes.iconMd,
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.build_outlined,
                                  ),
                                  const SizedBox(
                                      width: TSizes.spaceBtWItems / 2),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(requests[index].id,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                      Text(
                                        requests[index].title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .apply(fontWeightDelta: 1),
                                      ),
                                      Text(
                                        requests[index].description!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .apply(fontWeightDelta: 1),
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
                    )),
              );
            })
        : const WellcomeWidget();
  }
}
