import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/common/widgets/texts/product_price_text.dart';
import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/features/shop/controllers/product/cart_controller.dart';
import 'package:brothers_creative/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:brothers_creative/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:brothers_creative/features/shop/screens/wellcome_widget.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/billing_payment_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;
    final subtotal = cartController.totalOfCartPrice.value;
    //final orderController = Get.put(OrderController());
    return Directionality(
      textDirection:
          Get.locale?.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            'Order Review',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: SafeArea(
          child:
              !AuthenticationRepository.instance.isGust.value
                  ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: Column(
                        children: [
                          // const TCartItems(
                          //   showAddRemoveButtons: false,
                          // ),
                          // const SizedBox(
                          //   height: TSizes.spaceBtWsections,
                          // ),

                          ///Copoun code
                          //pconst TCouponCode(),
                          const SizedBox(height: TSizes.spaceBtWsections),
                          TRoundedContainer(
                            showBorder: true,
                            backgroundColor:
                                dark ? TColors.black : TColors.white,
                            padding: const EdgeInsets.all(TSizes.md),
                            child: const Column(
                              children: [
                                TBillingAmountSection(),
                                SizedBox(height: TSizes.spaceBtWItems),
                                Divider(),
                                SizedBox(height: TSizes.spaceBtWItems),
                                TbillingPaymentSection(),
                                SizedBox(height: TSizes.spaceBtWItems),
                                TBillingAddressSection(),
                                SizedBox(height: TSizes.spaceBtWItems),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  : const WellcomeWidget(),
        ),
        bottomNavigationBar:
            !AuthenticationRepository.instance.isGust.value
                ? Padding(
                  padding: EdgeInsets.only(
                    bottom: 60,
                    left: THelperFunctions.screenwidth() / 3.5,
                    right: THelperFunctions.screenwidth() / 3.5,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    ),
                    onPressed:
                        subtotal > 0
                            ? () {} // => Get.to(() => Ttransaction())
                            //orderController.processOrder(subtotal)
                            : () => Get.snackbar(
                              AppLocalizations.of(context)!.cartEmpty,
                              AppLocalizations.of(
                                context,
                              )!.addItemTotheCartForOrderProcess,
                            ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text(AppLocalizations.of(context)!.checkout),
                        // const SizedBox(
                        //   width: 15,
                        // ),
                        TProductPriceText(
                          color:
                              THelperFunctions.isDarkMode(context)
                                  ? Colors.black
                                  : Colors.white,
                          price: subtotal.toString(),
                        ),
                      ],
                    ),
                  ),
                )
                : null,
      ),
    );
  }
}
