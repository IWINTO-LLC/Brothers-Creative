import 'package:brothers_creative/common/widgets/layout/grid_layout.dart';
import 'package:brothers_creative/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:brothers_creative/features/shop/controllers/all_product_controller.dart';
import 'package:brothers_creative/features/shop/models/product_model.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({super.key, required this.products});

  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    //final isEg = Get.locale?.languageCode == 'en';
    final controller = Get.put(AllProductController());
    controller.assignProducts(products);
    return Column(
      children: [
        DropdownButtonFormField(
            value: controller.selectedSortOption.value,
            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
            items: [
              'Name',
              //AppLocalizations.of(Get.context!)!.name,
              'Higher price',
              'Lower price',
              'Sale'
            ]
                .map((option) =>
                    DropdownMenuItem(value: option, child: Text(option)))
                .toList(),
            onChanged: (value) {
              controller.sortProducts(value!);
            }),
        const SizedBox(
          height: TSizes.spaceBtWsections,
        ),
        Obx(() => TGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) =>
                TProductCardVertical(product: controller.products[index])))
      ],
    );
  }
}
