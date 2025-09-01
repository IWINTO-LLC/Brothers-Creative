import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TPaymentScreen extends StatelessWidget {
  const TPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);

    return Directionality(
        textDirection: Get.locale?.languageCode == 'en'
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Scaffold(
          appBar: TAppBar(
            title: Text(
              'Payment For Project',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: TColors.primary),
            ),
            showBackArrow: true,
          ),
          body: SafeArea(
            child: const SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TbillingPaymentSection(),
                      ],
                    ))),
          ),
        ));
  }
}
