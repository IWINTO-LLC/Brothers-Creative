import 'package:brothers_creative/features/shop/models/brand_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<BrandModel>> fetchBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();

      return snapshot.docs
          .map((documentSnapshot) => BrandModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<List<BrandModel>> getBrandForCategory(String categoryId) async {
    try {
      QuerySnapshot brandCategoryQuery = await _db
          .collection('BrandCategory')
          .where('CategoryId', isEqualTo: categoryId)
          .get();
      List<String> brandIds = brandCategoryQuery.docs
          .map((doc) => doc['BrandId'] as String)
          .toList();
      final brandQuery = await _db
          .collection('Brands')
          .where(FieldPath.documentId, whereIn: brandIds)
          .limit(4)
          .get();
      List<BrandModel> brands =
          brandQuery.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return brands;
    } on FirebaseException catch (e) {
      throw e.code;
    } catch (e) {
      throw (e.toString());
    }
  }
}
