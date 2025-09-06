import 'package:brothers_creative/app.dart';
import 'package:brothers_creative/features/authontication/controllers/register/register_controller.dart';
import 'package:brothers_creative/features/authontication/screens/login/login.dart';
import 'package:brothers_creative/features/general/controllers/brother_controller.dart';
import 'package:brothers_creative/features/personlization/screens/settings/terms.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:brothers_creative/utils/validators/validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_number_field/flutter_phone_number_field.dart';
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';

import 'package:iconsax/iconsax.dart';

class TRegisterForm extends StatelessWidget {
  const TRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final isEg = Get.locale?.languageCode == 'en';
    final brotherData = BrothersController.instance.allData;
    final controller = Get.put(RegisterController());
    final dark = THelperFunctions.isDarkMode(context);
    return Form(
      key: controller.registerFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator:
                      (value) => TValidator.validateEmptyText(
                        AppLocalizations.of(context)!.firstName,
                        value,
                      ),
                  expands: false,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.firstName,
                    prefixIcon: const Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator:
                      (value) => TValidator.validateEmptyText(
                        AppLocalizations.of(context)!.lastName,
                        value,
                      ),
                  expands: false,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.lastName,
                    prefixIcon: const Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.email,
              prefixIcon: const Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Directionality(
            textDirection: TextDirection.ltr,
            child: FlutterPhoneNumberField(
              controller: controller.phoneNumber,
              textAlign: TextAlign.left,
              focusNode: FocusNode(),
              initialCountryCode: "SA",
              pickerDialogStyle: PickerDialogStyle(
                countryFlagStyle: const TextStyle(fontSize: 17),
              ),
              decoration: const InputDecoration(
                // prefixIcon: Icon(Icons.phone),
                labelText: 'Phone Number',
                //alignLabelWithHint: true,
                // border: OutlineInputBorder(
                //   borderSide: BorderSide(),
                // ),
              ),
              languageCode: Get.locale?.languageCode ?? 'en',
              onChanged: (phone) => controller.phone = phone.completeNumber,
            ),
          ),
          // TextFormField(
          //   validator: (value) => TValidator.validatePhoneNumber(value),
          //   controller: controller.phoneNumber,
          //   decoration: const InputDecoration(
          //     prefixIcon: Icon(Iconsax.call),
          //   ),
          // ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Obx(
            () => TextFormField(
              validator:
                  (value) => TValidator.validateEmptyText(
                    AppLocalizations.of(context)!.password,
                    value,
                  ),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed:
                      () =>
                          controller.hidePassword.value =
                              !controller.hidePassword.value,
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtWsections),
          Wrap(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Obx(
                  () => Checkbox(
                    value: controller.privacyPolicy.value,
                    onChanged:
                        (value) =>
                            controller.privacyPolicy.value =
                                !controller.privacyPolicy.value,
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtWItems / 3),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.iAgreeTo,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap =
                                () => Get.to(
                                  () => TermsScreen(
                                    data:
                                        isEg
                                            ? brotherData[0].privacyPolicy
                                            : brotherData[0]
                                                .arabicPrivacyPolicy,
                                    title:
                                        AppLocalizations.of(
                                          context,
                                        )!.privacyPolicy,
                                  ),
                                ),
                      text: AppLocalizations.of(context)!.privacyPolicy,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.white : TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: dark ? TColors.white : TColors.primary,
                      ),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.and,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    TextSpan(
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap =
                                () => Get.to(
                                  () => TermsScreen(
                                    data:
                                        isEg
                                            ? brotherData[0].termsCondition
                                            : brotherData[0]
                                                .arabicTermsCondition,
                                    title:
                                        AppLocalizations.of(
                                          context,
                                        )!.termsCondition,
                                  ),
                                ),
                      text: AppLocalizations.of(context)!.termsCondition,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.white : TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: dark ? TColors.white : TColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          SizedBox(
            // width: THelperFunctions.screenwidth() * .4,
            // height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
              ),

              onPressed: () {
                if (controller.registerFormKey.currentState!.validate()) {
                  controller.register();
                  // controller.phoneAuthentication(
                  //     controller.phoneNumber.text.trim());
                }
              },
              child: Text(
                AppLocalizations.of(context)!.register,
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
          const SizedBox(height: TSizes.spaceBtwInputFields),
          GestureDetector(
            onTap: () => Get.to(() => const App()),
            child: Text(
              AppLocalizations.of(context)!.continuAsGuest,
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.apply(color: TColors.primary),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtWsections),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: " ${AppLocalizations.of(context)!.iHaveAcount} ",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () => Get.to(() => const LoginScreen()),
                  text: AppLocalizations.of(context)!.login,
                  style: Theme.of(context).textTheme.bodySmall!.apply(
                    color: dark ? TColors.white : TColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? TColors.white : TColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
