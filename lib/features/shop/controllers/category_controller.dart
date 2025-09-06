import 'package:brothers_creative/data/repositoies/categories/category_repository.dart';
import 'package:brothers_creative/data/repositoies/product/product_repository.dart';
import 'package:brothers_creative/features/authontication/controllers/network_manager.dart';
import 'package:brothers_creative/features/shop/models/category_model.dart';
import 'package:brothers_creative/features/shop/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featureCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchAllCategories();
    super.onInit();
  }

  Future<void> fetchAllCategories() async {
    Get.put(NetworkManager());
    try {
      isLoading.value = true;
      final isConnected = NetworkManager.instance.isConnected();
      if (await isConnected) {
        if (kDebugMode) {
          print('connection internet is good');
        }
      } else {
        if (kDebugMode) {
          print("===========no internet=========");
        }
      }

      final categories = await _categoryRepository.getAllCategories();
      allCategories.assignAll(categories);
      featureCategories.assignAll(allCategories
          .where((cat) => cat.isFeature && cat.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      } // Get.snackbar('oh Snap!', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories =
          await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      return [];
    }
  }

  Future<List<CategoryModel>> getBrandCategorys(String brandId) async {
    try {
      final categoriesForBrand =
          await _categoryRepository.getCategoryForBrand(brandId);
      return categoriesForBrand;
    } catch (e) {
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryProduct(
      {required String categoryId, int limit = 4}) async {
    final product = await ProductRepository.instance
        .getProductsForCategory(categoryId: categoryId, limit: limit);
    return product;
  }
}
