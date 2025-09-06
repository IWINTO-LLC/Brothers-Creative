import 'package:brothers_creative/features/gallery/models/album_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AlbumRepository extends GetxController {
  static AlbumRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<AlbumModel>> getAllAlbums() async {
    try {
      if (kDebugMode) {
        print("=======before Album data==========");
      }

      final snapshot = await _db.collection('Album').get();

      final list = snapshot.docs
          .map((document) => AlbumModel.fromSnapshot(document))
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
