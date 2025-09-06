import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BlogModel {
  final String id;
  final String title;
  final String arabicTitle;
  final String auther;
  final String arabicAuther;
  final String details;
  final String arabicDetails;
  final bool active;
  final List<String>? images;
  final DateTime? editTime;

  BlogModel(
      this.id,
      this.title,
      this.arabicTitle,
      this.auther,
      this.arabicAuther,
      this.details,
      this.arabicDetails,
      this.active,
      this.images,
      this.editTime);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'arabicTitle': arabicTitle,
      'auther': auther,
      'arabicAuther': arabicAuther,
      'details': details,
      'arabicDetails': arabicDetails,
      'Active': active,
      'images': images,
      'editTime': editTime?.millisecondsSinceEpoch,
    };
  }

  factory BlogModel.fromSnapshot(DocumentSnapshot snapshot) {
    final map = snapshot.data() as Map<String, dynamic>;
    return BlogModel(
      map['id'] as String,
      map['title'] as String,
      map['arabicTitle'] as String,
      map['auther'] as String,
      map['arabicAuther'] as String,
      map['details'] as String,
      map['arabicDetails'] as String,
      map['Active'] as bool,
      map['images'] != null ? List<String>.from(map['images']) : [],
      map['DeliveryDate'] == null
          ? null
          : (map['DeliveryDate'] as Timestamp).toDate(),
    );
  }
}
