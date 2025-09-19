import 'package:brothers_creative/common/styles/spacing_style.dart';
import 'package:brothers_creative/common/widgets/texts/form_divider.dart';
import 'package:brothers_creative/common/widgets/texts/social_buttons.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(Controller());
    final dark = THelperFunctions.isDarkMode(context);

    return Directionality(
      textDirection:
          Get.locale?.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: Scaffold(
        // appBar: AppBar(),
        // // appBar: TAppBar(
        // //   title: Text(AppLocalizations.of(context)!.register),
        // //   showBackArrow: true,
        // // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: TSpacingStyle.paddingWithAppbarHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image(
                      height: 70,
                      width: 120,
                      image: AssetImage(
                        dark ? TImages.wordWhite : TImages.wordBlack,
                      ),
                      color: dark ? Colors.white : TColors.black,
                    ),
                  ),
                  const SizedBox(height: TSizes.lg),
                  Text(
                    AppLocalizations.of(context)!.wellcomeBack,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: TSizes.sm),

                  //Form
                  const TLoginForm(),
                  const SizedBox(height: TSizes.spaceBtWItems),
                  TFormDivider(
                    dividerText: AppLocalizations.of(context)!.orSignUpWith,
                  ),
                  const SizedBox(height: TSizes.spaceBtWItems),
                  const TSocialButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
