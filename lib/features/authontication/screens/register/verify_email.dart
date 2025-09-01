import 'package:brothers_creative/features/authontication/controllers/register/verify_email_controller.dart';
import 'package:brothers_creative/features/authontication/screens/login/login.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});
  final String? email;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Directionality(
      textDirection:
          Get.locale?.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => Get.offAll(() => const LoginScreen()),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Image(
                    image: const AssetImage(TImages.verifyIcon),
                    width: THelperFunctions.screenwidth() * 0.6,
                  ),
                  const SizedBox(height: TSizes.spaceBtWsections),

                  ///title and sub Title
                  Text(
                    "Verify your email address",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtWItems),
                  Text(
                    email ?? '',
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtWItems),
                  Text(
                    "Congratulations! .. your account await for verify your email address to start shopping and Experiance a word of Brother Creative and make your own orders",
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtWsections),
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      ),
                      onPressed:
                          () => controller.checkEmailVerificationStatus(),
                      child: Text(
                        AppLocalizations.of(context)!.continu,
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
                  const SizedBox(height: TSizes.spaceBtWItems),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => controller.sendEmailVerification(),
                      child: Text(AppLocalizations.of(context)!.resendEmail),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
