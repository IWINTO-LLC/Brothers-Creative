// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/features/shop/controllers/address_controller.dart';
import 'package:brothers_creative/features/shop/models/address_model.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({super.key, required this.address, required this.onTap});
  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;
      return InkWell(
        onTap: onTap,
        child: TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          width: double.infinity,
          showBorder: true,
          backgroundColor: selectedAddress
              ? TColors.primary.withValues(alpha: 0.5)
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : THelperFunctions.isDarkMode(context)
                  ? TColors.darkerGray
                  : TColors.grey,
          margin: const EdgeInsets.only(bottom: TSizes.spaceBtWItems),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: Get.locale?.languageCode == 'en' ? 5 : null,
                left: Get.locale?.languageCode == 'en' ? null : 5,
                child: Icon(
                  selectedAddress ? Iconsax.tick_circle5 : null,
                  color: selectedAddress
                      ? THelperFunctions.isDarkMode(context)
                          ? TColors.light
                          : TColors.dark
                      : null,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: TSizes.sm / 2,
                  ),
                  Text(
                    address.phoneNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: TSizes.sm / 2,
                  ),
                  Text(
                    address.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
