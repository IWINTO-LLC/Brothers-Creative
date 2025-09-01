import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/common/widgets/texts/section_heading.dart';
import 'package:brothers_creative/features/shop/controllers/product/checkout_controller.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';

class TbillingPaymentSection extends StatelessWidget {
  const TbillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TSectionHeading(
          title: AppLocalizations.of(context)!.paymentMethod,
          buttonTitle: AppLocalizations.of(context)!.change,
          showActionButton: true,
          onPress: () {
            controller.selectPaymentMethode(context);
          },
        ),
        const SizedBox(
          height: TSizes.spaceBtWItems / 2,
        ),
        Obx(
          () => Row(
            children: [
              TRoundedContainer(
                width: 75,
                // height: 135,
                backgroundColor: dark ? TColors.light : TColors.white,
                padding: const EdgeInsets.all(TSizes.sm),
                child: Image(
                  image:
                      AssetImage(controller.selectedPaymentMethode.value.image),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtWItems / 2,
              ),
              Text(controller.selectedPaymentMethode.value.name,
                  style: Theme.of(context).textTheme.bodyLarge)
            ],
          ),
        )
      ],
    );
  }
}
