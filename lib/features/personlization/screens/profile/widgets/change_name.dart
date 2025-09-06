import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/features/personlization/controllers/update_name_controller.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:brothers_creative/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Directionality(
      textDirection:
          Get.locale?.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            AppLocalizations.of(context)!.changeName,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          showBackArrow: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.changeNameMessage,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: TSizes.spaceBtWsections),
                Form(
                  key: controller.updateUseNameFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.firstName,
                        validator:
                            (value) => TValidator.validateEmptyText(
                              AppLocalizations.of(context)!.firstName,
                              value,
                            ),
                        expands: false,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.user),
                          labelText: AppLocalizations.of(context)!.firstName,
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: controller.lastName,
                        validator:
                            (value) => TValidator.validateEmptyText(
                              AppLocalizations.of(context)!.lastName,
                              value,
                            ),
                        expands: false,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.user),
                          labelText: AppLocalizations.of(context)!.lastName,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtWsections),
                SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    ),
                    onPressed: () => controller.updateUserName(),
                    child: Text(
                      AppLocalizations.of(context)!.save,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            THelperFunctions.isDarkMode(context)
                                ? Colors.black
                                : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//////////////
