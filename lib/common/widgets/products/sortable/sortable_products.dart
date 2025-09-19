import 'package:brothers_creative/common/widgets/layout/grid_layout.dart';
import 'package:brothers_creative/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:brothers_creative/common/widgets/products/product_cards/product_card_horizontal.dart';
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
    final controller = Get.find<AllProductController>();

    // تأكد من أن المنتجات محدثة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.assignProducts(products);
    });

    return Column(
      children: [
        // صف يحتوي على الفلترة وزر تبديل العرض
        Row(
          children: [
            // الفلترة
            Expanded(
              child: DropdownButtonFormField(
                value: controller.selectedSortOption.value,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.sort),
                ),
                items:
                    ['Name', 'Higher price', 'Lower price', 'Sale']
                        .map(
                          (option) => DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  controller.sortProducts(value!);
                },
              ),
            ),
            const SizedBox(width: TSizes.spaceBtWItems),
            // زر تبديل العرض
            Obx(
              () => Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(TSizes.sm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // زر المصفوفة
                    GestureDetector(
                      onTap: () {
                        if (!controller.isGridView.value) {
                          controller.toggleViewMode();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(TSizes.sm),
                        decoration: BoxDecoration(
                          color:
                              controller.isGridView.value
                                  ? Colors.blue.shade100
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(TSizes.xs),
                        ),
                        child: Icon(
                          Icons.grid_view,
                          color:
                              controller.isGridView.value
                                  ? Colors.blue
                                  : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                    // زر القائمة
                    GestureDetector(
                      onTap: () {
                        if (controller.isGridView.value) {
                          controller.toggleViewMode();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(TSizes.sm),
                        decoration: BoxDecoration(
                          color:
                              !controller.isGridView.value
                                  ? Colors.blue.shade100
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(TSizes.xs),
                        ),
                        child: Icon(
                          Icons.list,
                          color:
                              !controller.isGridView.value
                                  ? Colors.blue
                                  : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtWsections),
        // عرض المنتجات حسب الطريقة المختارة
        Obx(() {
          if (controller.products.isEmpty) {
            return const SizedBox.shrink();
          }

          if (controller.isGridView.value) {
            // عرض المصفوفة (الطريقة الحالية)
            return TGridLayout(
              itemCount: controller.products.length,
              itemBuilder: (_, index) {
                if (index >= controller.products.length) {
                  return const SizedBox.shrink();
                }
                return TProductCardVertical(
                  product: controller.products[index],
                );
              },
            );
          } else {
            // عرض القائمة (الطريقة الجديدة)
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.products.length,
              separatorBuilder:
                  (_, __) => const SizedBox(height: TSizes.spaceBtWItems),
              itemBuilder: (_, index) {
                if (index >= controller.products.length) {
                  return const SizedBox.shrink();
                }
                return TProductCardHorizontal(
                  product: controller.products[index],
                );
              },
            );
          }
        }),
      ],
    );
  }
}
