import 'dart:convert';

import 'package:brothers_creative/data/repositoies/product/product_repository.dart';
import 'package:brothers_creative/features/shop/models/product_model.dart';
import 'package:brothers_creative/utils/storage/storage_utility.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();

// Variables
  final favorites = <String, bool>{}.obs;
  @override
  void onInit() {
    initFavorites();
    super.onInit();
  } //init('favorites')

  Future<void> initFavorites() async {
    //('MyStorage');
    final json = TLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      if (kDebugMode) {
        print("==========favorite===========");
        print(storedFavorites);
      }

      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavorites(String productId) {
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
    } else {
      TLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
    }
    if (kDebugMode) {
      print("some add ===$productId");
    }
  }

  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    TLocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  Future<List<ProductModel>> favoritesProducts() async {
    return await ProductRepository.instance
        .getAllProductsByIds(favorites.keys.toList());
  }
}
