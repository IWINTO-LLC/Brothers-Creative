import 'package:brothers_creative/features/general/models/brother_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class BrotherRepository extends GetxController {
  static BrotherRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<BrotherModel>> getAlldata() async {
    try {
      final snapshot = await _db.collection('BrothersCreative').get();
      final list = snapshot.docs
          .map((document) => BrotherModel.fromSnapshot(document))
          .toList();
      if (kDebugMode) {
        print("=======data==============");
        print(list.toString());
      }
      return list;
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }
}
