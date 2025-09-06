import 'package:brothers_creative/features/authontication/controllers.onboarding/onboarding_controller.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/devices/device_utility.dart';
import 'package:flutter/material.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
    required this.count,
  });
  final int count;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: TDeviceUtils.getAppbarHeight(),
        right: TSizes.defaultSpace,
        child: TextButton(
            onPressed: () {
              OnBoardingController.instance.skipPage();
            },
            child: Text(
              AppLocalizations.of(context)!.skip,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white),
            )));
  }
}
