import 'package:brothers_creative/features/authontication/controllers/forget_password/forget_passwprd_controller.dart';
import 'package:brothers_creative/features/authontication/screens/login/login.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
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
              onPressed: () => Get.back(),
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
                  Text(
                    email,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtWItems),
                  Text(
                    Get.locale?.languageCode == 'en'
                        ? "Change your password"
                        : "تغيير كلمة المرور",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtWItems),
                  Text(
                    Get.locale?.languageCode == 'en'
                        ? "Your Account Security is Our Priority. We've sent you a secure link to safely change your password and keep your account protected. Please check your inbox or spam folder to get the password reset link."
                        : "أمان حسابك هو أولويتنا. لقد أرسلنا لك رابطًا آمنًا لتغيير كلمة المرور بأمان والحفاظ على حماية حسابك. يرجى فحص بريدك الوارد أو مجلد الرسائل غير المرغوب فيها للحصول على رابط إعادة تعيين كلمة المرور.",
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtWsections),
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      ),
                      onPressed: () => Get.offAll(() => const LoginScreen()),
                      child: Text(
                        AppLocalizations.of(context)!.done,
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
                      onPressed:
                          () => ForgetPasswordController.instance
                              .resendPasswordResetEmail(email),
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
