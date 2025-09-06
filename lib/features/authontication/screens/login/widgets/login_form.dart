import 'package:brothers_creative/app.dart';
import 'package:brothers_creative/features/authontication/controllers/login/login_controller.dart';
import 'package:brothers_creative/features/authontication/screens/register/forget_password.dart';
import 'package:brothers_creative/features/authontication/screens/register/register.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
//import 'package:brothers_creative/features/general/controllers/brother_controller.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:brothers_creative/utils/validators/validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    // تهيئة آمنة للـ Controller
    LoginController controller;
    try {
      controller = Get.put(LoginController());
    } catch (e) {
      if (kDebugMode) {
        print('Error putting LoginController: $e');
      }
      // إعادة المحاولة
      controller = Get.find<LoginController>();
    }

    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.email,
            validator: (value) {
              try {
                return TValidator.validateEmail(value);
              } catch (e) {
                if (kDebugMode) {
                  print('Email validation error: $e');
                }
                return 'Invalid email format';
              }
            },
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.email,
              prefixIcon: const Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Obx(
            () => TextFormField(
              validator: (value) {
                try {
                  return TValidator.validateEmptyText(
                    AppLocalizations.of(context)!.password,
                    value,
                  );
                } catch (e) {
                  if (kDebugMode) {
                    print('Password validation error: $e');
                  }
                  return 'Password is required';
                }
              },
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () {
                    try {
                      controller.hidePassword.value =
                          !controller.hidePassword.value;
                    } catch (e) {
                      if (kDebugMode) {
                        print('Toggle password visibility error: $e');
                      }
                    }
                  },
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtWItems),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Obx(
                      () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) {
                          try {
                            controller.rememberMe.value =
                                !controller.rememberMe.value;
                          } catch (e) {
                            if (kDebugMode) {
                              print('Checkbox toggle error: $e');
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtWItems / 3),
                  Text(AppLocalizations.of(context)!.rememberMe),
                ],
              ),
              TextButton(
                onPressed: () => Get.to(() => const ForgetPassword()),
                child: Text(
                  AppLocalizations.of(context)!.forgetPassword,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: TColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtWItems),
          SizedBox(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
              ),
              onPressed: () {
                try {
                  if (controller.loginFormKey.currentState!.validate()) {
                    controller.emailAndPasswordSignin();
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print('Login button error: $e');
                  }
                  // عرض رسالة خطأ للمستخدم
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: SafeArea(child: Text('Login error: $e')),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text(
                AppLocalizations.of(context)!.login,
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
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: " ${AppLocalizations.of(context)!.iDontHaveAcount} ",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () => Get.to(() => const RegisterScreen()),
                  text: AppLocalizations.of(context)!.register,
                  style: Theme.of(context).textTheme.bodySmall!.apply(
                    color: dark ? TColors.white : TColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? TColors.white : TColors.primary,
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //     width: THelperFunctions.screenwidth() / 2.5,
          //     child: ElevatedButton(
          //         onPressed: () => Get.to(() => const RegisterScreen()),
          //         child: Text(AppLocalizations.of(context)!.createAccount))),
          const SizedBox(height: TSizes.spaceBtWsections),
          GestureDetector(
            onTap: () => Get.to(() => const App()),
            child: Text(
              AppLocalizations.of(context)!.continuAsGuest,
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.apply(color: TColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
