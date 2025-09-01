import 'package:brothers_creative/features/authontication/screens/login/login.dart';
import 'package:brothers_creative/features/authontication/screens/register/register.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';

//import 'package:flutterfire_ui/auth.dart';

class WellcomeWidget extends StatelessWidget {
  const WellcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(
                //   height: TSizes.spaceBtWsections,
                // ),
                Image(
                  height: 85,
                  color: TColors.primary,
                  image: AssetImage(
                    THelperFunctions.isDarkMode(Get.context!)
                        ? TImages.bwhite
                        : TImages.bBlack,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtWItems),
                Text(
                  AppLocalizations.of(context)!.wellcomtoBrother,
                  style: Theme.of(Get.context!).textTheme.headlineSmall,
                ),
                const SizedBox(height: TSizes.spaceBtWsections),
                Text(
                  AppLocalizations.of(
                    context,
                  )!.ifyouwanttoAddOrdersOrProjectMessage,
                  textAlign: TextAlign.justify,
                  style: Theme.of(Get.context!).textTheme.bodyLarge,
                ),
                const SizedBox(height: TSizes.spaceBtWsections),
                SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    ),
                    onPressed: () {
                      Get.to(
                        const LoginScreen(
                          // providerConfigs: [
                          //   EmailProviderConfiguration(),
                          // ],
                        ),
                      );
                    },
                    child: Text(
                      'login',
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

                const SizedBox(height: TSizes.spaceBtWsections),
                SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    ),
                    onPressed: () => Get.to(() => const RegisterScreen()),
                    child: Text(
                      AppLocalizations.of(Get.context!)!.createAccount,
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
                const SizedBox(height: TSizes.spaceBtWsections / 2),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Text(
                    "continue as gust",
                    style: Theme.of(
                      Get.context!,
                    ).textTheme.headlineSmall!.apply(color: TColors.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
