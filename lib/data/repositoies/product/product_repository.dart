import 'package:brothers_creative/features/shop/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<ProductModel>> getFeaturesProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeature', isEqualTo: true)
          .limit(4)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<List<ProductModel>> getAllFeaturesProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeature', isEqualTo: true)
          // .limit(4)
          .get();

      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<List<ProductModel>> getAllProductsByIds(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<List<ProductModel>> getProductsbyIds(List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<List<ProductModel>> gstProductsForBrand(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .get()
          : await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .limit(limit)
              .get();
      final products =
          querySnapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
      return products;
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = 4}) async {
    try {
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db
              .collection('ProductCategory')
              .where('CategoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('ProductCategory')
              .where('CategoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['ProductId'] as String)
          .toList();
      if (productIds.isEmpty) return [];
      final productQuery = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      List<ProductModel> products = productQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      return products;
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<bool> addProducts(ProductModel product) async {
    try {
      final currentproduct =
          await _db.collection('Products').add(product.toJson());
      if (kDebugMode) {
        print('currentproduct $currentproduct.id');
      }
      product.id = currentproduct.id;
      _db
          .collection("Products")
          .doc(currentproduct.id)
          .update(product.toJson());
      return true;
    } catch (e) {
      throw 'Some thing wrong while saving product';
    }
  }
  // getFavoritesProducts(List<String> list) {

  //       try {
  //     final snapshot = _db
  //         .collection('Products')
  //         .where(FieldPath.documentId, whereIn: list)
  //         .get();
  //     final t = snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
  //     return t;
  //   } on FirebaseException catch (e) {
  //     throw e.code;
  //   }
  // }
}
