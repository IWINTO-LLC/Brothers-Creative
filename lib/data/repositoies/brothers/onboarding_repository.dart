import 'package:brothers_creative/features/general/models/onboarding_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OnBoardingRepository extends GetxController {
  static OnBoardingRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<OnBoardingModel>> getAlldata() async {
    try {
      final snapshot = await _db.collection('OnBoarding').get();
      final list = snapshot.docs
          .map((document) => OnBoardingModel.fromSnapshot(document))
          .toList();

      return list;
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }
}
