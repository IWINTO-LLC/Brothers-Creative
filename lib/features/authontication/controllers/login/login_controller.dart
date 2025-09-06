import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';

import 'package:brothers_creative/features/personlization/controllers/user_controller.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/navigation_menu.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:brothers_creative/utils/loader/loaders.dart';
import 'package:brothers_creative/utils/popups/full_screen_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final privacyPolicy = true.obs;
  final localStorage = GetStorage();
  final userController = Get.put(UserController());
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    try {
      super.onInit();

      // تهيئة آمنة للنصوص
      final savedEmail = localStorage.read('REMEMBER_ME_EMAIL');
      final savedPassword = localStorage.read('REMEMBER_ME_PASSWORD');

      if (savedEmail != null && savedEmail.toString().isNotEmpty) {
        email.text = savedEmail.toString();
      }

      if (savedPassword != null && savedPassword.toString().isNotEmpty) {
        password.text = savedPassword.toString();
      }

      if (kDebugMode) {
        print('LoginController initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing LoginController: $e');
      }
      // نستمر حتى لو فشلت التهيئة
    }
  }

  Future<void> emailAndPasswordSignin() async {
    try {
      // التحقق من صحة النموذج أولاً
      if (!loginFormKey.currentState!.validate()) {
        return;
      }

      TFullScreenLoader.openloadingDialog(
        AppLocalizations.of(Get.context!)!.processing,
        TImages.proccessLottie,
        color:
            THelperFunctions.isDarkMode(Get.context!)
                ? Colors.white
                : Colors.black,
      );

      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      if (userCredential != null) {
        AuthenticationRepository.instance.isGust.value = false;
        TFullScreenLoader.stopLoading();
        // انتقال مباشر للواجهة الرئيسية
        Get.offAll(() => const NavigationMenu());
      } else {
        TFullScreenLoader.stopLoading();
        TLoader.erroreSnackBar(
          title: 'Login Failed',
          message: 'Invalid email or password',
        );
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      if (kDebugMode) {
        print('Login error: $e');
      }
      TLoader.erroreSnackBar(title: 'Login Error', message: e.toString());
    }
  }

  Future<void> googleSignIn() async {
    try {
      TFullScreenLoader.openloadingDialog(
        'Logging you in with Gmail ...',
        TImages.proccessLottie,
        color:
            THelperFunctions.isDarkMode(Get.context!)
                ? Colors.white
                : Colors.black,
      );

      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      if (userCredentials != null) {
        await userController.saveUserRecord(userCredentials);
        TFullScreenLoader.stopLoading();
        // يمكن إضافة رسالة نجاح هنا

        // انتقال مباشر للواجهة الرئيسية كضمان إضافي
        Get.offAll(() => const NavigationMenu());
      } else {
        TFullScreenLoader.stopLoading();
        TLoader.erroreSnackBar(
          title: 'Sign In Failed',
          message: 'Google sign in was cancelled or failed',
        );
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      if (kDebugMode) {
        print('Google Sign In error: $e');
      }
      TLoader.erroreSnackBar(title: 'Sign In Error', message: e.toString());
    }
  }
}
