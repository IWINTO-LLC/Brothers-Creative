// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:brothers_creative/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:brothers_creative/common/widgets/texts/section_heading.dart';
import 'package:brothers_creative/features/shop/controllers/category_controller.dart';
import 'package:brothers_creative/features/shop/models/category_model.dart';
import 'package:brothers_creative/features/shop/screens/all_products/all_products.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    Get.put(CategoryController());
    final controller = CategoryController.instance;
    final isEg = Get.locale?.languageCode == 'en';
    //  WidgetsBinding.instance.addPostFrameCallback((_) {
    //       searchController.searchProducts(initialQuery!);
    //     });
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          isEg ? category.name : category.arabicName,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: FutureBuilder(
              future: controller.getSubCategories(category.id),
              builder: (context, snapshot) {
                const loader = TVerticalProductShummer();

                final stateWidget =
                    TCloudHelperFunctions.checkMuiltiRecordState(
                      snapshot: snapshot,
                      loader: loader,
                    );
                if (stateWidget != null) return stateWidget;

                final subCategories = snapshot.data ?? [];
                if (subCategories.isEmpty) return const SizedBox();

                return Directionality(
                  textDirection: isEg ? TextDirection.ltr : TextDirection.rtl,

                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: subCategories.length,
                    itemBuilder: (_, index) {
                      final subCategory = subCategories[index];

                      return FutureBuilder(
                        future: controller.getCategoryProduct(
                          categoryId: subCategory.id,
                        ),
                        builder: (context, snapshot) {
                          final stateWidget =
                              TCloudHelperFunctions.checkMuiltiRecordState(
                                snapshot: snapshot,
                                loader: loader,
                              );
                          if (stateWidget != null) return stateWidget;

                          final products = snapshot.data ?? [];
                          if (products.isEmpty) return const SizedBox();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TSectionHeading(
                                title:
                                    isEg
                                        ? subCategory.name
                                        : subCategory.arabicName,
                                showActionButton: true,
                                onPress:
                                    () => Get.to(
                                      () => AllProducts(
                                        title:
                                            isEg
                                                ? subCategory.name
                                                : subCategory.arabicName,
                                        futureMethode: controller
                                            .getCategoryProduct(
                                              categoryId: subCategory.id,
                                              limit: -1,
                                            ),
                                      ),
                                    ),
                              ),
                              const SizedBox(height: TSizes.spaceBtWsections),
                              SizedBox(
                                height: 150,
                                child: ListView.separated(
                                  itemCount: products.length,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder:
                                      (_, __) => const SizedBox(
                                        width: TSizes.spaceBtWItems,
                                      ),
                                  itemBuilder:
                                      (_, index) => TProductCardHorizontal(
                                        product: products[index],
                                      ),
                                ),
                              ),
                              const SizedBox(height: TSizes.spaceBtWsections),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
