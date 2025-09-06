import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/features/project/controllers/ask_price_controller.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:flutter_phone_number_field/flutter_phone_number_field.dart';
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import 'widgets/file_grid_upload.dart';
import 'widgets/photo_grid_upload.dart';
import 'widgets/round_checkbox.dart';

class AddNewPriceRequestScreen extends StatelessWidget {
  const AddNewPriceRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    final controller = AskPriceController.instance;
    // controller.proposedPrice.text = '0.00';

    return Directionality(
      textDirection:
          Get.locale?.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(AppLocalizations.of(context)!.addPriceRequest),
          showBackArrow: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Form(
                key: controller.askRequestFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.priceRequestText,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        const Divider(color: TColors.grey),
                        const SizedBox(height: TSizes.spaceBtwInputFields / 2),
                        TRoundedContainer(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          //borderColor: TColors.primary.withValues(alpha:0.1),
                          // showBorder: true,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.personalInformation,
                                  style: Theme.of(context).textTheme.labelLarge!
                                      .copyWith(color: TColors.primary),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: FlutterPhoneNumberField(
                                    controller: controller.phoneNumber,
                                    textAlign: TextAlign.left,
                                    focusNode: FocusNode(),
                                    initialCountryCode: "SA",
                                    pickerDialogStyle: PickerDialogStyle(
                                      countryFlagStyle: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    decoration: InputDecoration(
                                      // prefixIcon: Icon(Icons.phone),
                                      labelText:
                                          AppLocalizations.of(
                                            context,
                                          )!.phoneNumber,
                                      //alignLabelWithHint: true,
                                      // border: OutlineInputBorder(
                                      //   borderSide: BorderSide(),
                                      // ),
                                    ),
                                    languageCode:
                                        Get.locale?.languageCode ?? 'en',
                                    onChanged:
                                        (phone) =>
                                            controller.phone =
                                                phone.completeNumber,
                                  ),
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                TextFormField(
                                  controller: controller.company,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Iconsax.building),
                                    labelText:
                                        AppLocalizations.of(
                                          context,
                                        )!.yourCompany,
                                  ),
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                TextFormField(
                                  controller: controller.address,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Iconsax.location),
                                    labelText:
                                        AppLocalizations.of(
                                          context,
                                        )!.yourAddress,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwInputFields / 2),
                        const Divider(color: TColors.grey),
                        const SizedBox(height: TSizes.spaceBtwInputFields / 2),

                        TRoundedContainer(
                          //borderColor: TColors.primary.withValues(alpha:0.1),
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.projectInfo,
                                  style: Theme.of(context).textTheme.labelLarge!
                                      .copyWith(color: TColors.primary),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                Text(AppLocalizations.of(context)!.workType),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields / 2,
                                ),
                                TextFormField(
                                  controller: controller.title,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Iconsax.text),
                                    labelText:
                                        AppLocalizations.of(
                                          context,
                                        )!.projectTitle,
                                  ),
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.deliveryLocationForOffFactorySite,
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields / 2,
                                ),
                                TextFormField(
                                  controller: controller.location,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Iconsax.location4),
                                    labelText:
                                        AppLocalizations.of(
                                          context,
                                        )!.projectLocation,
                                  ),
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                DateTimeField(
                                  controller: controller.estimatedDate,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.date_range_rounded,
                                    ),
                                    labelText:
                                        AppLocalizations.of(
                                          context,
                                        )!.estimatedDate,
                                  ),
                                  format: controller.format,
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2100),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: TSizes.spaceBtwInputFields / 2),
                        const Divider(color: TColors.grey),
                        const SizedBox(height: TSizes.spaceBtwInputFields / 2),

                        TRoundedContainer(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.workDetails,
                                  style: Theme.of(context).textTheme.labelLarge!
                                      .copyWith(color: TColors.primary),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.kindlySelectTheAppropriate,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),

                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),

                                //
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.descriptionOfProject,
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields / 2,
                                ),
                                TextFormField(
                                  maxLines: 3,
                                  controller: controller.description,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.description),
                                    labelText:
                                        AppLocalizations.of(
                                          context,
                                        )!.descriptions,
                                  ),
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.provideUsWithProductionBlueprints,
                                ),

                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields / 2,
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TRounsCheckBox(
                                          onTap: (isCheck) {
                                            if (isCheck!) {
                                              controller
                                                  .productionBlueprints
                                                  .text = AppLocalizations.of(
                                                    context,
                                                  )!.providedExample;
                                            }
                                          },
                                          text:
                                              AppLocalizations.of(
                                                context,
                                              )!.providedExample,
                                        ),
                                        const SizedBox(
                                          height: TSizes.spaceBtwInputFields,
                                        ),
                                        TRounsCheckBox(
                                          onTap: (isCheck) {
                                            if (isCheck!) {
                                              controller
                                                  .productionBlueprints
                                                  .text = AppLocalizations.of(
                                                    context,
                                                  )!.both;
                                            }
                                          },
                                          text:
                                              AppLocalizations.of(
                                                context,
                                              )!.both,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TRounsCheckBox(
                                          onTap: (isCheck) {
                                            if (isCheck!) {
                                              controller
                                                  .productionBlueprints
                                                  .text = AppLocalizations.of(
                                                    context,
                                                  )!.fileViaEmail;
                                            }
                                          },
                                          // isChecked: controller
                                          //         .productionBlueprints ==
                                          //     'File via email',
                                          text:
                                              AppLocalizations.of(
                                                context,
                                              )!.fileViaEmail,
                                        ),
                                        const SizedBox(
                                          height: TSizes.spaceBtwInputFields,
                                        ),
                                        TRounsCheckBox(
                                          onTap: (isCheck) {
                                            if (isCheck!) {
                                              controller
                                                  .productionBlueprints
                                                  .text = AppLocalizations.of(
                                                    context,
                                                  )!.notPresent;
                                            }
                                          },
                                          text:
                                              AppLocalizations.of(
                                                context,
                                              )!.notPresent,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.workTypeOrProjectCategory,
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields / 2,
                                ),
                                DropdownButtonFormField2<String>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    labelText:
                                        AppLocalizations.of(
                                          context,
                                        )!.selectProjectCategory,
                                    prefixIcon: const Icon(
                                      Icons.list,
                                      color: TColors.darkGrey,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  items:
                                      controller.categoryItems
                                          .map(
                                            (item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                  // validator: (value) {
                                  //   if (value == null) {
                                  //     return 'Please select project Category';
                                  //   }
                                  //   return null;
                                  // },
                                  onChanged: (value) {
                                    controller.projectCategory.text =
                                        value.toString();
                                  },
                                  onSaved: (value) {
                                    controller.selectedValue = value.toString();
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.only(right: 8, left: 8),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 24,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),

                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.involvesAssemblyAndDismantling,
                                ),

                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields / 2,
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TRounsCheckBox(
                                      onTap: (isCheck) {
                                        controller.assembly1.text =
                                            AppLocalizations.of(
                                              context,
                                            )!.exterior;
                                      },
                                      text:
                                          AppLocalizations.of(
                                            context,
                                          )!.exterior,
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwInputFields,
                                    ),
                                    TRounsCheckBox(
                                      onTap: (isCheck) {
                                        controller.assembly1.text =
                                            AppLocalizations.of(
                                              context,
                                            )!.interior;
                                      },
                                      text:
                                          AppLocalizations.of(
                                            context,
                                          )!.interior,
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwInputFields,
                                    ),
                                    TRounsCheckBox(
                                      onTap: (isCheck) {
                                        controller.assembly1.text =
                                            AppLocalizations.of(
                                              context,
                                            )!.dontknow;
                                      },
                                      text:
                                          AppLocalizations.of(
                                            context,
                                          )!.dontknow,
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.involvesAssemblyAndDismantling,
                                ),

                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields / 2,
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TRounsCheckBox(
                                          onTap: (isCheck) {
                                            controller.assembly2.text =
                                                AppLocalizations.of(
                                                  context,
                                                )!.installation;
                                          },
                                          text:
                                              AppLocalizations.of(
                                                context,
                                              )!.installation,
                                        ),
                                        const SizedBox(
                                          height: TSizes.spaceBtwInputFields,
                                        ),
                                        TRounsCheckBox(
                                          onTap: (isCheck) {
                                            controller.assembly2.text =
                                                AppLocalizations.of(
                                                  context,
                                                )!.both;
                                          },
                                          text:
                                              AppLocalizations.of(
                                                context,
                                              )!.both,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TRounsCheckBox(
                                          onTap: (isCheck) {
                                            controller.assembly2.text =
                                                AppLocalizations.of(
                                                  context,
                                                )!.dismantling;
                                          },
                                          text:
                                              AppLocalizations.of(
                                                context,
                                              )!.dismantling,
                                        ),
                                        const SizedBox(
                                          height: TSizes.spaceBtwInputFields,
                                        ),
                                        TRounsCheckBox(
                                          onTap: (isCheck) {
                                            controller.assembly2.text =
                                                AppLocalizations.of(
                                                  context,
                                                )!.notRequired;
                                          },
                                          text:
                                              AppLocalizations.of(
                                                context,
                                              )!.notRequired,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),

                                Text(
                                  AppLocalizations.of(context)!.uniteQuantity,
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields / 2,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: controller.quantity,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.numbers),
                                    labelText:
                                        AppLocalizations.of(context)!.quantity,
                                  ),
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.proposedPriceInclvat,
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields / 2,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: controller.proposedPrice,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.money),
                                    labelText: '156.200',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwInputFields / 2),

                        const Divider(color: TColors.grey),
                        const SizedBox(height: TSizes.spaceBtwInputFields / 2),
                        TRoundedContainer(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.additionalConsiderations,
                                  style: Theme.of(context).textTheme.labelLarge!
                                      .copyWith(color: TColors.primary),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.kindlyLogistic,
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields / 2,
                                ),
                                TextFormField(
                                  maxLines: 3,
                                  controller: controller.descriptions1,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.description),
                                    labelText:
                                        AppLocalizations.of(
                                          context,
                                        )!.descriptions,
                                  ),
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields * 2,
                                ),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.uploadYourFilesEasily,
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields / 2,
                                ),
                                UploadPhotosWidget(),
                                const Divider(color: TColors.grey),
                                const SizedBox(height: TSizes.spaceBtWItems),
                                UploadFilesWidget(),
                              ],
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: TSizes.spaceBtwInputFields,
                        // ),

                        //////////////////////////
                      ],
                    ),
                    // const SizedBox(
                    //   height: TSizes.spaceBtwInputFields,
                    // ),
                    const SizedBox(height: TSizes.spaceBtWItems / 2),
                    const Divider(thickness: .7, color: TColors.grey),
                    const SizedBox(height: TSizes.spaceBtWItems / 2),

                    Row(
                      children: [
                        RoundCheckBox(
                          size: 20,
                          checkedWidget: const Icon(
                            Icons.check,
                            size: 15,
                            color: Colors.white,
                          ),
                          checkedColor: TColors.primary,
                          onTap: (selected) {
                            if (selected!) {
                              controller.confirmation.text = true.toString();
                            }
                          },
                        ),
                        const SizedBox(width: TSizes.md),
                        SizedBox(
                          width: THelperFunctions.screenwidth() - 90,
                          child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.justify,
                            AppLocalizations.of(context)!.conformationAcception,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    SizedBox(
                      // width: THelperFunctions.screenwidth() / 2.5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        ),
                        onPressed: () => controller.addNewRequest(),
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
                    const SizedBox(height: TSizes.spaceBtwInputFields),
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
