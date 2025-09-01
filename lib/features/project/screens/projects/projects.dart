import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/features/project/screens/projects/add_new_project.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'widgets/projects_list.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.locale?.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: !AuthenticationRepository.instance.isGust.value
            ? FloatingActionButton(
                backgroundColor: TColors.primary,
                onPressed: () => Get.to(() => const AddNewProjectScreen()),
                child: const Icon(
                  Iconsax.add,
                  color: TColors.white,
                ),
              )
            : null,
        appBar: TAppBar(
          title: Text(AppLocalizations.of(context)!.myProjects,
              style: Theme.of(context).textTheme.headlineSmall),
          showBackArrow: true,
        ),
        body: SafeArea(
          child: const Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: TProjectsListItem(),
          ),
        ),
      ),
    );
  }
}
