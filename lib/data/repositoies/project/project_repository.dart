import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/features/project/models/project_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProjectRepository extends GetxController {
  static ProjectRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<String> addProject(ProjectModel project) async {
    try {
      project.uId == AuthenticationRepository.instance.authUser!.uid;

      await _db.collection('Projects').add(project.toJson());

      return 'added succesfully';
    } catch (e) {
      throw 'Some thing wrong while saving project';
    }
  }

  Future<List<ProjectModel>> fetchUserProjects() async {
    try {
      var userId = //'w0xDf8Cau2aqJrcH8vaaRYASY4I2';
          AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information. try again later';
      }
      final snapshot = await _db
          .collection("Projects")
          .where('UId', isEqualTo: userId)
          .get();
      return snapshot.docs.map((e) => ProjectModel.fromSnapshot(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw 'Something wrong while get Project data';
    }
  }
}
