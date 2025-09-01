import 'dart:async';

import 'package:brothers_creative/common/widgets/success_screen/success_screen.dart';
import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';

import 'package:brothers_creative/utils/loader/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoredicect();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoader.successSnackBar(
          title: 'Email Sent',
          message: 'Please check your inbox and verify your email');
    } catch (e) {
      TLoader.erroreSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  setTimerForAutoredicect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.offAll(() => SuccessScreen(
              image: TImages.successfullLottie,
              title: AppLocalizations.of(Get.context!)!.yourAccountCreateTitle,
              subTitle:
                  AppLocalizations.of(Get.context!)!.yourAccountCreateSubTitle,
              onPressed: () => Get.back(),
            ));
      }
    });
  }

  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.offAll(() => SuccessScreen(
            image: TImages.successfullLottie,
            title: AppLocalizations.of(Get.context!)!.yourAccountCreateTitle,
            subTitle:
                AppLocalizations.of(Get.context!)!.yourAccountCreateSubTitle,
            onPressed: () => Get.back(),
          ));
    }
  }
}
