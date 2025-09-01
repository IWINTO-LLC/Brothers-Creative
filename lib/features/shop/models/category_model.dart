import 'package:brothers_creative/utils/logging/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String arabicName;
  String image;
  bool isFeature;
  String parentId;
  CategoryModel(
      {required this.id,
      required this.name,
      required this.arabicName,
      required this.image,
      required this.isFeature,
      this.parentId = ''});

  static CategoryModel empty() => CategoryModel(
      id: '', name: '', arabicName: '', image: '', isFeature: false);

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'ArabicName': arabicName,
      'Image': image,
      'ParentId': parentId,
      'IsFeature': isFeature
    };
  }

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      TLoggerHelper.info(data['Name']);

      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        arabicName: data['ArabicName'] ?? '',
        parentId: data['ParentId'] ?? '',
        image: data['Image'] ?? '',
        isFeature: data['IsFeature'] ?? false,
      );
    }
    return CategoryModel.empty();
  }
}
