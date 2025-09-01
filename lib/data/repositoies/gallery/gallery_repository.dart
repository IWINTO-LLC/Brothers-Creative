import 'package:brothers_creative/features/gallery/models/gallery_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GalleryRepository extends GetxController {
  static GalleryRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<GalleryModel>> fetchgalleryPhoto() async {
    try {
      final result = await _db
          .collection('Gallery')
          .where('IsFeature', isEqualTo: true)
          .get();

      return result.docs
          .map(
              (documentSnapshot) => GalleryModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<List<GalleryModel>> getPhotoForAlbum(
      {required String albumId, int limit = -1}) async {
    try {
      QuerySnapshot galleryAlbumQuery = limit == -1
          ? await _db
              .collection('GalleryAlbum')
              .where('AlbumId', isEqualTo: albumId)
              .get()
          : await _db
              .collection('GalleryAlbum')
              .where('AlbumId', isEqualTo: albumId)
              .limit(limit)
              .get();

      List<String> galleryIds = galleryAlbumQuery.docs
          .map((doc) => doc['GalleryId'] as String)
          .toList();
      if (galleryIds.isEmpty) return [];
      final galleryQuery = await _db
          .collection('Gallery')
          .where(FieldPath.documentId, whereIn: galleryIds)
          .get();
      List<GalleryModel> gallery = galleryQuery.docs
          .map((doc) => GalleryModel.fromSnapshot(doc))
          .toList();
      return gallery;
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }
}
