import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/common/widgets/loaders/animation_loading.dart';
import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/features/project/controllers/project_controller.dart';
import 'package:brothers_creative/features/project/screens/projects/add_new_project.dart';
import 'package:brothers_creative/features/shop/screens/wellcome_widget.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/cloud_helper_function.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';

import 'single_project.dart';

class TProjectsListItem extends StatelessWidget {
  const TProjectsListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ProjectController());

    return !AuthenticationRepository.instance.isGust.value
        ? FutureBuilder(
            future: controller.fetchUserProject(),
            builder: (_, snapshot) {
              final emptyWidget = TAnimationLoaderWidget(
                text: AppLocalizations.of(context)!.noProjectyet,
                animation: TImages.cartEmptyLottie,
                showAction: false,
                actionText:
                    AppLocalizations.of(context)!.letusRequestForNewProject,
                onActionPressed: () =>
                    Get.off(() => const AddNewProjectScreen()),
              );
              final response = TCloudHelperFunctions.checkMuiltiRecordState(
                  snapshot: snapshot, nothingFound: emptyWidget);
              if (response != null) return response;
              final projects = snapshot.data!;
              return ListView.separated(
                  shrinkWrap: true,
                  itemCount: projects.length,
                  separatorBuilder: (_, __) => const SizedBox(
                        height: TSizes.spaceBtWItems,
                      ),
                  itemBuilder: (_, index) {
                    String state = projects[index].state!;
                    return TRoundedContainer(
                        showBorder: true,
                        padding: const EdgeInsets.all(TSizes.md),
                        backgroundColor: dark ? TColors.dark : TColors.light,
                        child: InkWell(
                          onTap: () => Get.to(() => TSingleProjectScreen(
                                project: projects[index],
                              )),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Iconsax.status),
                                const SizedBox(width: TSizes.spaceBtWItems / 2),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      state,
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
                                    onPressed: () =>
                                        Get.to(() => TSingleProjectScreen(
                                              project: projects[index],
                                            )),
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
                                      const Icon(Icons.build_outlined),
                                      const SizedBox(
                                          width: TSizes.spaceBtWItems / 2),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(projects[index].id,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium),
                                          Text(
                                            projects[index].name,
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
                        ));
                  });
            },
          )
        : const WellcomeWidget();
  }
}
