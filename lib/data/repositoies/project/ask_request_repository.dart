import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/features/project/models/ask_request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AskRequestRepository extends GetxController {
  static AskRequestRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<String> addAskRequest(AskRequestModel askRequest) async {
    try {
      askRequest.uId == AuthenticationRepository.instance.authUser!.uid;

      await _db.collection('AskPrices').add(askRequest.toJson());

      return 'added succesfully';
    } catch (e) {
      throw 'Some thing wrong while requst for price';
    }
  }

  Future<List<AskRequestModel>> fetchUserRequsts() async {
    try {
      var userId = //'w0xDf8Cau2aqJrcH8vaaRYASY4I2';
          AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information. try again later';
      }
      final snapshot = await _db
          .collection("AskPrices")
          .where('UId', isEqualTo: userId)
          .get();
      return snapshot.docs.map((e) => AskRequestModel.fromSnapshot(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw 'Something wrong while fetch Request data';
    }
  }
}
