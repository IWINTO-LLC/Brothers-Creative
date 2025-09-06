import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  ///variables

  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Future<void> signup() async {
    if (!signupFormKey.currentState!.validate()) return;
  }

  void phoneAuthentication(String phoneNum) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNum);
  }
}
