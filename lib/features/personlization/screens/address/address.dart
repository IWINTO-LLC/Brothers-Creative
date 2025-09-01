import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/features/shop/controllers/address_controller.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';

import 'add_new_address.dart';
import 'widgets/single_address.dart';

class UserAdressScreen extends StatelessWidget {
  const UserAdressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Directionality(
      textDirection: Get.locale?.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: TColors.primary,
          onPressed: () => Get.to(() => const AddNewAddressScreen()),
          child: const Icon(
            Iconsax.add,
            color: TColors.white,
          ),
        ),
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            AppLocalizations.of(context)!.myAddresses,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Obx(
                () => FutureBuilder(
                    key: Key(controller.refreshData.value.toString()),
                    future: controller.getAllUserAddresses(),
                    builder: (context, snapshot) {
                      final response =
                          TCloudHelperFunctions.checkMuiltiRecordState(
                              snapshot: snapshot);
                      if (response != null) return response;

                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) {
                            final addresses = snapshot.data!;
                            return TSingleAddress(
                              onTap: () =>
                                  controller.selectAddress(addresses[index]),
                              address: addresses[index],
                            );
                          });
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
