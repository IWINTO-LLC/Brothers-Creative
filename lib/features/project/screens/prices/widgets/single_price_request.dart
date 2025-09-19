import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/features/project/models/ask_request_model.dart';
import 'package:brothers_creative/features/project/screens/projects/widgets/payment_screen.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TSinglePriceScreen extends StatelessWidget {
  const TSinglePriceScreen({super.key, required this.price});
  final AskRequestModel price;
  @override
  Widget build(BuildContext context) {
    //final controller = BrandController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    // RxInt activeStep = 0.obs;
    return Directionality(
      textDirection:
          Get.locale?.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            AppLocalizations.of(context)!.project,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: TColors.primary),
          ),
          showBackArrow: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        Text(AppLocalizations.of(context)!.complationRate),
                        const SizedBox(width: TSizes.spaceBtWItems),
                        LinearPercentIndicator(
                          width: 140.0,
                          animation: true,
                          lineHeight: 15.0,
                          animationDuration: 2000,
                          barRadius: const Radius.circular(20),
                          progressColor: TColors.primary,
                          percent: 0.9,
                          center: const Text(
                            "90.0%",
                            style: TextStyle(fontSize: 12.0),
                          ),
                          trailing: const Icon(Icons.mood),
                          backgroundColor: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtWItems),
                  TRoundedContainer(
                    showBorder: true,
                    padding: const EdgeInsets.all(TSizes.md),
                    backgroundColor: dark ? TColors.dark : TColors.light,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.projectTitle,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Text(
                              price.title,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .apply(color: TColors.primary),
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtWItems),
                        Text(price.description ?? ''),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtWItems),
                  TRoundedContainer(
                    showBorder: true,
                    padding: const EdgeInsets.all(TSizes.md),
                    backgroundColor: dark ? TColors.dark : TColors.light,
                    child: Column(
                      children: [
                        //completion Percentage
                        Column(
                          children: [
                            CircularPercentIndicator(
                              radius: 45.0,
                              animation: true,
                              animationDuration: 2000,
                              lineWidth: 10.0,
                              percent: 0.90,
                              center: const Text("90%"),
                              progressColor: Colors.green,
                            ),
                            const SizedBox(height: TSizes.spaceBtWItems),
                            const Center(child: Text('Payment rate')),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtWItems),
                        const Center(
                          child: Text(
                            'You almost will finish the payment amounts',
                          ),
                        ),
                        // TbillingPaymentSection(),
                        const SizedBox(height: TSizes.spaceBtWItems),
                        SizedBox(
                          width: 500,
                          child: Center(
                            child: ElevatedButton(
                              onPressed:
                                  () => Get.to(() => const TPaymentScreen()),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.addPayAmount,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        THelperFunctions.isDarkMode(context)
                                            ? Colors.black
                                            : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtWItems),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
