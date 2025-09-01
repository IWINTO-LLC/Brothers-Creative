import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/features/authontication/controllers/network_manager.dart';
import 'package:brothers_creative/features/authontication/screens/register/reset_password.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:brothers_creative/utils/loader/loaders.dart';
import 'package:brothers_creative/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendPasswordResetEmail() async {
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
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(
        email.text.trim(),
      );

      TFullScreenLoader.stopLoading();
      TLoader.successSnackBar(
        title: 'Email Send',
        message: 'Email Link Sent to Reset your Password',
      );
      Get.to(ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.erroreSnackBar(title: 'oh Snap', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
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

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      TFullScreenLoader.stopLoading();

      TLoader.successSnackBar(
        title: 'Email Send',
        message: 'Email Link Sent to Reset your Password',
      );
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.erroreSnackBar(title: 'oh Snap', message: e.toString());
    }
  }
}
