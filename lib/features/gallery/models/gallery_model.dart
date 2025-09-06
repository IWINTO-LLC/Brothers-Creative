import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class GalleryModel {
  String image;
  final String albumId;
  final bool isFeature;
  final String? description;
  final String? arabicDescription;
  final String? name;
  final String? arabicName;

  GalleryModel(
      {required this.image,
      required this.albumId,
      required this.isFeature,
      this.name,
      this.arabicName,
      this.description,
      this.arabicDescription});
  static GalleryModel empty() =>
      GalleryModel(albumId: '', image: '', isFeature: false);

  Map<String, dynamic> toJson() {
    return {
      'Image': image,
      'Album': albumId,
      'IsFeature': isFeature,
      'Name': name,
      'ArabicName': arabicName,
      'Description': description,
      'ArabicDescription': arabicDescription
    };
  }

  factory GalleryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    if (kDebugMode) {
      print(data);
    }
    return GalleryModel(
      image: data['Image'] ?? '',
      albumId: data['Album'] ?? '',
      name: data['Name'] ?? '',
      arabicName: data['ArabicName'] ?? '',
      description: data['Description'],
      arabicDescription: data['ArabicDescription'] ?? '',
      isFeature: data['IsFeature'] ?? false,
    );
  }
}
