import 'package:brothers_creative/common/widgets/texts/section_heading.dart';
import 'package:brothers_creative/features/shop/controllers/address_controller.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());
    //final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
            title: AppLocalizations.of(context)!.shippingAddress,
            buttonTitle: AppLocalizations.of(context)!.change,
            showActionButton: true,
            onPress: () => addressController.selectNewAddressPopup(context)),
        //  addressController.selectedAddress.value != null
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(addressController.selectedAddress.value.name,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(
                height: TSizes.spaceBtWItems / 2,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.phone,
                    size: 20,
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtWItems,
                  ),
                  Text(addressController.selectedAddress.value.phoneNumber,
                      style: Theme.of(context).textTheme.bodyLarge)
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtWItems / 2,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_history,
                    size: 20,
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtWItems,
                  ),
                  Expanded(
                      child: Text(
                    addressController.selectedAddress.value.details,
                    style: Theme.of(context).textTheme.bodyMedium,
                    softWrap: true,
                  ))
                ],
              ),
            ],
          ),
        )
        // : Text(AppLocalizations.of(context)!.selectAddress,
        //     style: Theme.of(context).textTheme.bodyMedium)
      ],
    );
  }
}
