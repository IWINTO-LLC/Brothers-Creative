import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/features/authontication/controllers/forget_password/forget_passwprd_controller.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:brothers_creative/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    final isEn = Get.locale?.languageCode == 'en';
    return Directionality(
      textDirection: isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: const TAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.forgetPassword,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtWsections),
                  Text(
                    isEn
                        ? "Your account security is our priority. We'll send you a secure link to safely change your password and keep your account protected."
                        : "أمان حسابك هو أولويتنا. سنرسل لك رابطًا آمنًا لتغيير كلمة المرور بأمان والحفاظ على حماية حسابك.",
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtWsections * 2),
                  Form(
                    key: controller.forgetPasswordFormKey,
                    child: TextFormField(
                      controller: controller.email,
                      validator: (value) => TValidator.validateEmail(value),
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.email,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtWsections),
                  Center(
                    child: SizedBox(
                      // width: THelperFunctions.screenwidth() * 0.6,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        ),
                        onPressed: () => controller.sendPasswordResetEmail(),
                        child: Text(AppLocalizations.of(context)!.submit),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtWItems),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed:
                          () => controller.resendPasswordResetEmail(
                            controller.email.text.trim(),
                          ),
                      child: Text(
                        AppLocalizations.of(context)!.resendEmail,

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
      ),
    );
  }
}
