import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/common/widgets/texts/form_divider.dart';
import 'package:brothers_creative/common/widgets/texts/social_buttons.dart';
import 'package:brothers_creative/features/authontication/screens/register/widgets/register_form.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(Controller());
    //final dark = THelperFunctions.isDarkMode(context);

    return Directionality(
      textDirection: Get.locale?.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        appBar: const TAppBar(
          showBackArrow: true,
        ),
        // appBar: TAppBar(
        //   title: Text(AppLocalizations.of(context)!.register),
        //   showBackArrow: true,
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.letsCompliteYourAccount,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtWsections,
                  ),
                  //Form

                  const TRegisterForm(),
                  const SizedBox(
                    height: TSizes.spaceBtWsections,
                  ),
                  TFormDivider(
                    dividerText: AppLocalizations.of(context)!.orSignUpWith,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtWsections,
                  ),
                  const TSocialButtons()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
