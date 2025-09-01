import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/data/repositoies/user/user_repository.dart';
import 'package:brothers_creative/features/authontication/controllers/network_manager.dart';
import 'package:brothers_creative/features/authontication/screens/register/verify_email.dart';
import 'package:brothers_creative/features/personlization/models/users/user_model.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:brothers_creative/utils/loader/loaders.dart';
import 'package:brothers_creative/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();
  String? phone;

  ///variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  Future<void> register() async {
    try {
      TFullScreenLoader.openloadingDialog(
        AppLocalizations.of(Get.context!)!.processing,
        TImages.proccessLottie,
        color:
            THelperFunctions.isDarkMode(Get.context!)
                ? Colors.white
                : Colors.black,
      );

      // check the internet connectivity

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!registerFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!privacyPolicy.value) {
        TLoader.warningSnackBar(
          title: AppLocalizations.of(Get.context!)!.acceptPrivacyPolicy,
          message: AppLocalizations.of(Get.context!)!.policyMessage,
        );
        return;
      }
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
            email.text.trim(),
            password.text.trim(),
          );

      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phone,
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);
      TFullScreenLoader.stopLoading();
      TLoader.successSnackBar(
        title: 'Congratulations!',
        message: 'Your account has been created! Verify email to continue',
      );
      //TFullScreenLoader.stopLoading();
      Get.to(() => const VerifyEmailScreen());
    } catch (e) {
      TLoader.erroreSnackBar(title: 'Ohh snap', message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }
}
