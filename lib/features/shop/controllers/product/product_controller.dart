import 'package:brothers_creative/data/repositoies/product/product_repository.dart';
import 'package:brothers_creative/features/shop/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  //Variables
  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  List<ProductModel> saleProduct = [];
  final RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  @override
  void onInit() {
    // productRepository.addProducts(ProductModel(
    //     id: '04',
    //     title: 'Product for test 4',
    //     arabicTitle: 'منتج اختباري 4',
    //     description: 'this is product long description in english',
    //     arabicDescription: 'هذا هو الوصف الطويل باللغة العربية',
    //     isFeature: true,
    //     sku: '3456',
    //     price: 280,
    //     salePrice: 280,
    //     categoryId: '1',
    //     brand: BrandModel(
    //         id: '1',
    //         cover: '',
    //         image:
    //             'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/Brands%2Famazone.png?alt=media',
    //         name: 'Amazone'),
    //     images: [
    //       'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/product%2F4%2051.png?alt=media&token=3d9a3ec9-af2f-48f9-b04e-899cc5055f76',
    //       'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/product%2F4%2051.png?alt=media&token=3d9a3ec9-af2f-48f9-b04e-899cc5055f76',
    //       'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/product%2F4%2051.png?alt=media&token=3d9a3ec9-af2f-48f9-b04e-899cc5055f76'
    //     ],
    //     thumbnail:
    //         'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/product%2F4%2051.png?alt=media&token=3d9a3ec9-af2f-48f9-b04e-899cc5055f76',
    //     productType: 'ProductType.variable',
    //     stock: 20));
    fetchFeatureProducts();
    super.onInit();
  }

  void fetchFeatureProducts() async {
    // productRepository.addProducts(ProductModel(
    //     id: '',
    //     title: 'Product for test 1',
    //     arabicTitle: 'منتج اختباري 1',
    //     price: 230,
    //     images: [
    //       'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/product%2F4%2051.png?alt=media&token=3d9a3ec9-af2f-48f9-b04e-899cc5055f76',
    //       'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/product%2F4%2051.png?alt=media&token=3d9a3ec9-af2f-48f9-b04e-899cc5055f76',
    //       'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/product%2F4%2051.png?alt=media&token=3d9a3ec9-af2f-48f9-b04e-899cc5055f76'
    //     ],
    //     thumbnail:
    //         'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/product%2F4%2051.png?alt=media&token=3d9a3ec9-af2f-48f9-b04e-899cc5055f76',
    //     productType: 'ProductType.variable',
    //     stock: 20));
    try {
      isLoading.value = true;
      final products = await productRepository.getFeaturesProducts();
      featuredProducts.assignAll(products);

      if (kDebugMode) {
        print('============ product length==========');
        print(featuredProducts.length);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeatureProducts() async {
    productRepository.addProducts(ProductModel(
        id: '',
        title: 'Product for test 1',
        arabicTitle: 'منتج اختباري 1',
        price: 230,
        images: [
          'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/product%2F4%2051.png?alt=media&token=3d9a3ec9-af2f-48f9-b04e-899cc5055f76',
          'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/product%2F4%2051.png?alt=media&token=3d9a3ec9-af2f-48f9-b04e-899cc5055f76',
          'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/product%2F4%2051.png?alt=media&token=3d9a3ec9-af2f-48f9-b04e-899cc5055f76'
        ],
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/product%2F4%2051.png?alt=media&token=3d9a3ec9-af2f-48f9-b04e-899cc5055f76',
        productType: 'ProductType.variable',
        stock: 20));
    try {
      final products = await productRepository.getAllFeaturesProducts();

      if (kDebugMode) {
        print('============ product length==========');
        print(featuredProducts.length);
      }
      return products;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  String getProductPrice(ProductModel product) {
    return "${product.salePrice > 0 ? product.salePrice : product.price}";
  }

  String? calculateSalePresentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0 || originalPrice <= 0.0) {
      return null;
    }
    double precentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return precentage.toStringAsFixed(0);
  }

  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  double? getSaleNumber(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0 || originalPrice <= 0.0) {
      return 0;
    }
    double precentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return precentage;
  }

  Future<List<ProductModel>> getSaleProduct() async {
    saleProduct = [];
    if (featuredProducts == []) {
      return [];
    }

    for (final product in featuredProducts) {
      if (getSaleNumber(product.price, product.salePrice)! > 0) {
        saleProduct.add(product);
      }
    }
    return saleProduct;
  }
}
