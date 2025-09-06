import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/common/widgets/products/sortable/sortable_products.dart';
import 'package:brothers_creative/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:brothers_creative/features/shop/controllers/all_product_controller.dart';
import 'package:brothers_creative/features/shop/models/product_model.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';

class AllProducts extends StatelessWidget {
  const AllProducts(
      {super.key, required this.title, this.query, this.futureMethode});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethode;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return Directionality(
      textDirection: Get.locale?.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            title,
          ),
          showBackArrow: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: FutureBuilder(
                  future:
                      futureMethode ?? controller.fetchProductsByQuery(query),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const TVerticalProductShummer();
                    }
                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.noData,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.somethingWentWrong,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }
                    final products = snapshot.data!;

                    if (products == []) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)!.noData,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }
                    return TSortableProducts(products: products);
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
