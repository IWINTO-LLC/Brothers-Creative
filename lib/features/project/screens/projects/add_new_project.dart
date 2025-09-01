import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/features/project/controllers/project_controller.dart';
import 'package:brothers_creative/features/project/screens/prices/widgets/file_grid_upload.dart';
import 'package:brothers_creative/features/project/screens/prices/widgets/photo_grid_upload.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:brothers_creative/utils/validators/validator.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddNewProjectScreen extends StatelessWidget {
  const AddNewProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProjectController.instance;
    return Directionality(
      textDirection:
          Get.locale?.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(AppLocalizations.of(context)!.addProject),
          showBackArrow: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Form(
                key: controller.projectFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.name,
                      validator:
                          (value) => TValidator.validateEmptyText(
                            AppLocalizations.of(context)!.name,
                            value,
                          ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.building),
                        labelText: AppLocalizations.of(context)!.projectName,
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    TextFormField(
                      maxLines: 3,
                      controller: controller.description,
                      validator:
                          (value) => TValidator.validateEmptyText(
                            AppLocalizations.of(context)!.descriptions,
                            value,
                          ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.description),
                        labelText: AppLocalizations.of(context)!.descriptions,
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    TextFormField(
                      maxLines: 1,
                      controller: controller.quantity,
                      // validator: (value) => TValidator.validateEmptyText(
                      //     AppLocalizations.of(context)!.quantity, value),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.numbers),
                        labelText: AppLocalizations.of(context)!.quantity,
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    GestureDetector(
                      onTap:
                          () => showCountryPicker(
                            context: context,

                            //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                            // exclude: <String>['KN', 'MF'],
                            favorite: <String>['SA'],
                            //Optional. Shows phone code before the country name.
                            showPhoneCode: false,

                            onSelect: (Country country) {
                              controller.country.text = country.displayName;
                              if (kDebugMode) {
                                print('Select country: ${country.displayName}');
                              }
                            },

                            // Optional. Sets the theme for the country list picker.
                            countryListTheme: CountryListThemeData(
                              // Optional. Sets the border radius for the bottomsheet.
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                              ),
                              // Optional. Styles the search field.
                              inputDecoration: InputDecoration(
                                labelText: 'Search',
                                hintText: 'Start typing to search',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color(
                                      0xFF8C98A8,
                                    ).withValues(alpha: 0.2),
                                  ),
                                ),
                              ),
                              // Optional. Styles the text in the search field
                              searchTextStyle: const TextStyle(
                                color: TColors.primary,
                                fontSize: 18,
                              ),
                            ),
                          ),
                      child: TextFormField(
                        onTap:
                            () => showCountryPicker(
                              context: context,

                              //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                              // exclude: <String>['KN', 'MF'],
                              favorite: <String>['SA'],
                              //Optional. Shows phone code before the country name.
                              showPhoneCode: false,

                              onSelect: (Country country) {
                                controller.country.text = country.displayName;
                                if (kDebugMode) {
                                  print(
                                    'Select country: ${country.displayName}',
                                  );
                                }
                              },

                              // Optional. Sets the theme for the country list picker.
                              countryListTheme: CountryListThemeData(
                                // Optional. Sets the border radius for the bottomsheet.
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0),
                                ),
                                // Optional. Styles the search field.
                                inputDecoration: InputDecoration(
                                  labelText: 'Search',
                                  hintText: 'Start typing to search',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: const Color(
                                        0xFF8C98A8,
                                      ).withValues(alpha: 0.2),
                                    ),
                                  ),
                                ),
                                // Optional. Styles the text in the search field
                                searchTextStyle: const TextStyle(
                                  color: TColors.primary,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                        controller: controller.country,
                        validator:
                            (value) => TValidator.validateEmptyText(
                              AppLocalizations.of(context)!.city,
                              value,
                            ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.activity),
                          labelText: AppLocalizations.of(context)!.city,
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    UploadPhotosWidget(),
                    UploadFilesWidget(),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    SizedBox(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        ),
                        onPressed: () {
                          controller.addNewProject();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.send,
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color:
                                THelperFunctions.isDarkMode(context)
                                    ? Colors.black
                                    : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    //   AudioRecorder(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
