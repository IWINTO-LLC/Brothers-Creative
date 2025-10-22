import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/features/personlization/screens/address/widgets/map_screen.dart';
import 'package:brothers_creative/features/shop/controllers/address_controller.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:brothers_creative/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Directionality(
      textDirection:
          Get.locale?.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            AppLocalizations.of(context)!.addNewAddress,
            //  style: Theme.of(context).textTheme.headlineSmall,
          ),
          showBackArrow: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Form(
                key: controller.addressFormKey,
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
                        prefixIcon: const Icon(Iconsax.user),
                        labelText: AppLocalizations.of(context)!.name,
                      ),
                    ), //phoneNumber
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: controller.phoneNumber,
                      validator:
                          (value) => TValidator.validatePhoneNumber(value),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.mobile),
                        labelText: AppLocalizations.of(context)!.phoneNumber,
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.street,
                            validator:
                                (value) => TValidator.validateEmptyText(
                                  AppLocalizations.of(context)!.street,
                                  value,
                                ),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Iconsax.building_31),
                              labelText: AppLocalizations.of(context)!.street,
                            ),
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceBtwInputFields),
                        Expanded(
                          child: TextFormField(
                            controller: controller.postalCode,
                            validator:
                                (value) => TValidator.validateEmptyText(
                                  AppLocalizations.of(context)!.buildNum,
                                  value,
                                ),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Iconsax.code_1),
                              labelText: AppLocalizations.of(context)!.buildNum,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.city,
                            validator:
                                (value) => TValidator.validateEmptyText(
                                  AppLocalizations.of(context)!.city,
                                  value,
                                ),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Iconsax.building),
                              labelText: AppLocalizations.of(context)!.city,
                            ),
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceBtwInputFields),
                        Expanded(
                          child: TextFormField(
                            controller: controller.country,
                            validator:
                                (value) => TValidator.validateEmptyText(
                                  AppLocalizations.of(context)!.floor,
                                  value,
                                ),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Iconsax.activity),
                              labelText: AppLocalizations.of(context)!.floor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: controller.details,
                      maxLines: 3,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.document),
                        labelText: AppLocalizations.of(context)!.details,
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    Obx(
                      () => CheckboxListTile(
                        //checkColor: Colors.black,
                        activeColor: Colors.black,
                        title: const Text("استخدام موقعي الحالي"),
                        value: controller.useCurrentLocation.value,
                        onChanged: (value) async {
                          controller.useCurrentLocation.value = value!;
                          if (value) await controller.setCurrentLocation();
                        },
                      ),
                    ),

                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    GestureDetector(
                      onTap: () async {
                        await Get.to(
                          () => MapScreen(
                            onLocationSelected: (lat, lng) {
                              controller.latitude.value = lat;
                              controller.longitude.value = lng;
                              controller.useCurrentLocation.value = false;
                            },
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.map, size: 20, color: Colors.blue),
                          const SizedBox(width: 4),
                          Text(
                            'اختيار الموقع من الخريطة',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),
                    // ElevatedButton.icon(
                    //   icon: const Icon(Icons.map),
                    //   label: const Text("اختيار من الخريطة"),
                    //   onPressed: () async {
                    //     await Get.to(() => MapScreen(
                    //           onLocationSelected: (lat, lng) {
                    //             controller.latitude.value = lat;
                    //             controller.longitude.value = lng;
                    //             controller.useCurrentLocation.value = false;
                    //           },
                    //         ));
                    //   },
                    //  ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    Obx(() {
                      if (controller.currentAddress.isEmpty) {
                        return const SizedBox();
                      }
                      return Row(
                        children: [
                          Icon(Icons.my_location),
                          SizedBox(width: 10),
                          SizedBox(
                            width: THelperFunctions.screenwidth() - 70,
                            child: Text(
                              controller.currentAddress.value,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: TColors.darkerGray,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      );
                    }),

                    // Obx(() {
                    //   if (controller.latitude.value == 0.0 &&
                    //       controller.longitude.value == 0.0) {
                    //     return const SizedBox(); // لا شيء يظهر قبل اختيار الموقع
                    //   }
                    //   return Text(
                    //     '📍 الموقع الحالي: ${controller.latitude.value.toStringAsFixed(6)}, ${controller.longitude.value.toStringAsFixed(6)}',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w500,
                    //       color: Colors.green[800],
                    //     ),
                    //   );
                    // }),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    SizedBox(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        ),
                        onPressed: () => controller.addNewAddress(),
                        child: Text(
                          AppLocalizations.of(context)!.save,
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
