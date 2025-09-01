import 'package:brothers_creative/common/widgets/texts/section_heading.dart';
import 'package:brothers_creative/features/shop/models/payment_method_model.dart';
import 'package:brothers_creative/features/shop/screens/checkout/widgets/payment_tile.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();
  final Rx<PaymentMethodModel> selectedPaymentMethode =
      PaymentMethodModel.empty().obs;

// Variables
  // final favorites = <String, bool>{}.obs;
  @override
  void onInit() {
    //screnSelect();
    selectedPaymentMethode.value =
        PaymentMethodModel(image: TImages.visaLogo, name: 'Visa');
    super.onInit();
  }

  Future<dynamic> selectPaymentMethode(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(TSizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TSectionHeading(
                        showActionButton: false,
                        title:
                            AppLocalizations.of(context)!.selectPaymentMethode),
                    const SizedBox(
                      height: TSizes.spaceBtWsections,
                    ),
                    TPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: TImages.visaLogo, name: 'Visa')),
                    const SizedBox(
                      height: TSizes.spaceBtWsections,
                    ),
                    TPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: TImages.masterLogo, name: 'Master')),
                    const SizedBox(
                      height: TSizes.spaceBtWsections,
                    ),
                    TPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: TImages.paypalLogo, name: 'Paypal'))
                  ],
                ),
              ),
            ));
  }
}
