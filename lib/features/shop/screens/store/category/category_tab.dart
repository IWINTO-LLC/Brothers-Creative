import 'package:brothers_creative/common/widgets/layout/grid_layout.dart';
import 'package:brothers_creative/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:brothers_creative/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:brothers_creative/common/widgets/texts/section_heading.dart';
import 'package:brothers_creative/features/shop/controllers/category_controller.dart';
import 'package:brothers_creative/features/shop/models/category_model.dart';
import 'package:brothers_creative/features/shop/screens/store/category/category_brand.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
    required this.category,
  });
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //-- Brands
              CategoryBrand(category: category),
              const SizedBox(
                height: TSizes.spaceBtWItems,
              ),

              FutureBuilder(
                  future:
                      controller.getCategoryProduct(categoryId: category.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const TVerticalProductShummer();
                    }
                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return const SizedBox();
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)!.somethingWentWrong,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }
                    final products = snapshot.data!;
                    if (products.isEmpty) {
                      return const SizedBox(
                          // child: Text(
                          //   AppLocalizations.of(context)!.noData,
                          //   style: Theme.of(context).textTheme.bodyMedium,
                          // ),
                          );
                    }

                    return Column(
                      children: [
                        TSectionHeading(
                          title: AppLocalizations.of(context)!.youMightLike,
                          showActionButton: true,
                          buttonTitle: AppLocalizations.of(context)!.viewAll,
                          onPress: () {},
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtWItems,
                        ),
                        TGridLayout(
                            itemCount: products.length,
                            itemBuilder: (_, index) => TProductCardVertical(
                                  product: products[index],
                                )),
                      ],
                    );

                    //return TSortableProducts(products: products);
                  }),

              // TGridLayout(
              //     itemCount: products.length,
              //     itemBuilder: (_, index) => TProductCardVertical(
              //           product: ProductModel.empty(),
              //         )),
              const SizedBox(
                height: TSizes.spaceBtWsections,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
