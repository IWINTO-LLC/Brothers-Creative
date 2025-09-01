import 'package:brothers_creative/app.dart';
import 'package:brothers_creative/bindings/general_binding.dart';
import 'package:brothers_creative/common/styles/spacing_style.dart';

import 'package:brothers_creative/features/authontication/screens/login/login.dart';
import 'package:brothers_creative/features/authontication/screens/register/register.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class WellcomScreen extends StatelessWidget {
  const WellcomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Directionality(
      textDirection:
          Get.locale?.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: TSpacingStyle.paddingWithAppbarHeight,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: TSizes.spaceBtWsections),
                      Image(
                        height: 100,
                        color: TColors.primary,
                        image: AssetImage(
                          dark ? TImages.bwhite : TImages.bBlack,
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtWItems),
                      Text(
                        AppLocalizations.of(context)!.welcomeToBro,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: TSizes.spaceBtWsections),
                      Text(
                        AppLocalizations.of(context)!.welcomeMessage,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: TSizes.spaceBtWsections),
                      SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                            ),
                          ),
                          onPressed: () {
                            Get.to(
                              const LoginScreen(),
                              binding: GeneralBindings(),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.apply(
                              color:
                                  THelperFunctions.isDarkMode(context)
                                      ? Colors.black
                                      : Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtWsections),
                      SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                            ),
                          ),
                          onPressed: () => Get.to(() => const RegisterScreen()),
                          child: Text(
                            AppLocalizations.of(context)!.createAccount,
                          ),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtWsections),
                      GestureDetector(
                        onTap: () => Get.to(() => const App()),
                        child: Text(
                          AppLocalizations.of(context)!.continuAsGuest,
                          style: Theme.of(context).textTheme.headlineSmall!
                              .apply(color: TColors.primary),
                        ),
                      ),
                    ],
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
