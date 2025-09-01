import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'path/to/your/controllers/images_controller.dart';
import 'path/to/your/models/category_model.dart';
import 'path/to/your/models/sub_category_model.dart';
import 'path/to/your/models/product_model.dart';
import 'path/to/your/widgets/t_vertical_product_shimmer.dart';
import 'path/to/your/widgets/t_section_heading.dart';
import 'path/to/your/widgets/t_product_card_horizontal.dart';

class SubCategoriesSection extends StatelessWidget {
  final CategoryModel category;
  const SubCategoriesSection({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ImagesController>();
    const loader = TVerticalProductShimmer();

    return FutureBuilder<List<SubCategoryModel>>(
      future: controller.getSubCategories(category.id),
      builder: (context, snapshot) {
        // 1. While loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loader;
        }
        // 2. If error
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        // 3. Data ready (or empty)
        final subCategories = snapshot.data ?? [];
        if (subCategories.isEmpty) {
          return const SizedBox();
        }

        return Column(
          children: subCategories.map((subCategory) {
            return _SubCategoryProducts(
              subCategory: subCategory,
              controller: controller,
            );
          }).toList(),
        );
      },
    );
  }
}

class _SubCategoryProducts extends StatelessWidget {
  final SubCategoryModel subCategory;
  final ImagesController controller;

  const _SubCategoryProducts({
    Key? key,
    required this.subCategory,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const loader = TVerticalProductShimmer();
    final isEg = true; // replace with your locale check

    return FutureBuilder<List<ProductModel>>(
      future: controller.getCategoryProduct(
        categoryId: subCategory.id,
      ),
      builder: (context, snapshot) {
        // 1. While loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loader;
        }
        // 2. If error
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        // 3. Data ready (or empty)
        final products = snapshot.data ?? [];
        if (products.isEmpty) {
          return const SizedBox();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(
              title: isEg
                  ? subCategory.name
                  : subCategory.arabicName,
              showActionButton: true,
              onPress: () => Get.to(
                () => AllProducts(
                  title: isEg
                      ? subCategory.name
                      : subCategory.arabicName,
                  futureMethod: controller.getCategoryProduct(
                    categoryId: subCategory.id,
                    limit: -1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: 12),
                itemBuilder: (_, index) {
                  return TProductCardHorizontal(
                    product: products[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}