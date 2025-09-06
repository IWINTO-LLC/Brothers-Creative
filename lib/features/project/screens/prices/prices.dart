import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/features/project/screens/prices/add_new_price_request.dart';
import 'package:brothers_creative/utils/constants/color.dart';

import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';

import 'package:iconsax/iconsax.dart';

import 'widgets/prices_list.dart';

class TPricesRequestScreen extends StatelessWidget {
  const TPricesRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Directionality(
      textDirection: Get.locale?.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: !AuthenticationRepository.instance.isGust.value
            ? FloatingActionButton.extended(
                backgroundColor: dark ? TColors.dark : TColors.light,
                onPressed: () => Get.to(() => const AddNewPriceRequestScreen()),
                label: Text(
                  AppLocalizations.of(context)!.addPriceRequest,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                icon: const Icon(
                  Iconsax.discount_shape4,
                  color: TColors.primary,
                ),
              )
            : null,
        appBar: TAppBar(
          title: Text(AppLocalizations.of(context)!.priceRequests,
              style: Theme.of(context).textTheme.headlineSmall),
          showBackArrow: true,
        ),
        body: SafeArea(
          child: const Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: TPricesList(),
          ),
        ),
      ),
    );
  }
}
