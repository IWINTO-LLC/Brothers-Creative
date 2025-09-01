import 'package:brothers_creative/features/shop/models/clients_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ClientsRepository extends GetxController {
  static ClientsRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<ClientModel>> getAllClients() async {
    try {
      final snapshot = await _db.collection('Clients').get();

      if (kDebugMode) {
        print("=======data=== clients===========");
        print(snapshot.docs.toString());
      }

      final list = snapshot.docs
          .map((document) => ClientModel.fromSnapshot(document))
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
}
