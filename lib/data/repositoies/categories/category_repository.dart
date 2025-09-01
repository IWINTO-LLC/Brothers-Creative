import 'package:brothers_creative/features/shop/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      if (kDebugMode) {
        print("=======beforedata==========");
      }

      final snapshot = await _db.collection('Categories').get();
      if (kDebugMode) {
        print("=======data==============");
        print(snapshot.docs.toString());
      }
// STORE

      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      if (kDebugMode) {
        print("=======data==============");
        print(list);
      }
      return list;
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    if (kDebugMode) {
      print("=======category id=========");
      print(categoryId);
    }

    try {
      final snapshot = await _db
          .collection("Categories")
          .where('ParentId', isEqualTo: categoryId)
          .get();
      final result =
          snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      if (kDebugMode) {
        print("=======data= subcategory=============");
        print(result);
      }
      return result;
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<List<CategoryModel>> getCategoryForBrand(String brandId) async {
    try {
      QuerySnapshot brandCategoryQuery = await _db
          .collection('BrandCategory')
          .where('BrandId', isEqualTo: brandId)
          .get();
      List<String> brandIds = brandCategoryQuery.docs
          .map((doc) => doc['CategoryId'] as String)
          .toList();
      final brandQuery = await _db
          .collection('Categories')
          .where(FieldPath.documentId, whereIn: brandIds)
          .limit(4)
          .get();
      List<CategoryModel> brands =
          brandQuery.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return brands;
    } on FirebaseException catch (e) {
      throw e.code;
    } catch (e) {
      throw (e.toString());
    }
  }
}
