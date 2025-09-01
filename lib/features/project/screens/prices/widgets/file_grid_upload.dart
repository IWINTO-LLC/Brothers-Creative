import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/features/project/controllers/ask_price_controller.dart';
import 'package:brothers_creative/utils/constants/color.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';

class UploadFilesWidget extends StatelessWidget {
  UploadFilesWidget({
    super.key,
  });

  final controller = AskPriceController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          SizedBox(
            // height: controller.choozenFiles != []
            //     ? (controller.choozenFiles.length /
            //             2) *
            //         100
            //     : TSizes.spaceBtWItems,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.choozenFiles.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Iconsax.attach_square4,
                                size: 70,
                                color: TColors.grey,
                              )
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () =>
                                  controller.choozenFiles.removeAt(index),
                              icon: const Icon(
                                Icons.delete_rounded,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(controller.choozenFiles[index].name)
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Row(
                  children: [
                    const Icon(
                      Iconsax.attach_square4,
                      size: 30,
                      //color: TColors.primary,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.attachFile,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                onPressed: () {
                  controller.selectFiles();
                },
              ),
              Visibility(
                visible: controller.choozenFiles.isNotEmpty,
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.totalFiles,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: TColors.darkerGray),
                    ),
                    TRoundedContainer(
                      showBorder: true,
                      radius: BorderRadius.circular(5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Center(
                          child: Text(
                            " ${controller.choozenFiles.length}",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: TColors.primary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
