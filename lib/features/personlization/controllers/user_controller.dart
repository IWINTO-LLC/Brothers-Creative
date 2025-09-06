import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/data/repositoies/user/user_repository.dart';
import 'package:brothers_creative/features/authontication/controllers/network_manager.dart';
import 'package:brothers_creative/features/authontication/screens/authenticate/re_authenticate.dart';
import 'package:brothers_creative/features/authontication/screens/login/login.dart';
import 'package:brothers_creative/features/personlization/models/users/user_model.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/loader/loaders.dart';
import 'package:brothers_creative/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;
  final hidePassword = true.obs;
  final userRepository = Get.put(UserRepository());
  final imageUploading = false.obs;

  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();

  GlobalKey<FormState> reauthenticateFormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    fetchUserRecord();
    super.onInit();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
      this.user.value = user;
    } catch (e) {
      user(UserModel.empty());
      TLoader.erroreSnackBar(title: 'oh Snap!', message: e.toString());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        final uid = userCredentials.user!.uid;
        final displayName = userCredentials.user!.displayName ?? '';
        final parts = UserModel.nameParts(displayName);
        final derivedFirst = parts.isNotEmpty ? parts.first : '';
        final derivedLast = parts.length > 1 ? parts[1] : '';
        final derivedEmail = userCredentials.user!.email ?? '';
        final derivedPhone = userCredentials.user!.phoneNumber ?? '';
        final derivedPhoto = userCredentials.user!.photoURL ?? '';

        // اجلب السجل الحالي للمستخدم
        final existing = await userRepository.fetchUserDetails();

        // إذا لم يكن للمستخدم سجل سابق، أنشئ سجلًا كاملًا
        if ((existing.id ?? '').isEmpty) {
          final user = UserModel(
            id: uid,
            firstName: derivedFirst,
            lastName: derivedLast,
            userName: UserModel.generateUsername(displayName),
            email: derivedEmail,
            phoneNumber: derivedPhone,
            profilePicture: derivedPhoto,
          );
          await userRepository.saveUserRecord(user);
          return;
        }

        // إذا كان هناك سجل موجود، حدّث الحقول الفارغة فقط من بيانات غوغل
        final Map<String, dynamic> updates = {};
        if ((existing.firstName == null ||
                existing.firstName!.trim().isEmpty) &&
            derivedFirst.isNotEmpty) {
          updates['FirstName'] = derivedFirst;
        }
        if ((existing.lastName == null || existing.lastName!.trim().isEmpty) &&
            derivedLast.isNotEmpty) {
          updates['LastName'] = derivedLast;
        }
        if ((existing.email == null || existing.email!.trim().isEmpty) &&
            derivedEmail.isNotEmpty) {
          updates['Email'] = derivedEmail;
        }
        if ((existing.profilePicture).trim().isEmpty &&
            derivedPhoto.isNotEmpty) {
          updates['ProfilePicture'] = derivedPhoto;
        }

        if (updates.isNotEmpty) {
          await userRepository.updateSingleFieldUser(updates);
        }
      }
    } catch (e) {
      TLoader.warningSnackBar(
        title: 'Data not Saved',
        message:
            'Something went wrong while save your information , please try again',
      );
    }
  }

  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        imageUploading.value = true;
        final imageUrl = await userRepository.uploadImage(
          'Users/Images/Profile',
          image,
        );
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleFieldUser(json);
        user.value.profilePicture = imageUrl;
        user.refresh();

        // TLoader.successSnackBar(
        //     title: 'Success', message: 'profile photo change successfully');
      }
    } catch (e) {
      TLoader.erroreSnackBar(title: 'ohSnap', message: 'Something went wrong!');
    } finally {
      imageUploading.value = false;
    }
  }

  uploadProjectFile() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        imageUploading.value = true;
        final imageUrl = await userRepository.uploadImage(
          'Users/Images/Profile',
          image,
        );
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleFieldUser(json);
        user.value.profilePicture = imageUrl;
        user.refresh();

        // TLoader.successSnackBar(
        //   title: 'Success', message: 'profile photo change successfully');
      }
    } catch (e) {
      TLoader.erroreSnackBar(title: 'ohSnap', message: 'Something went wrong!');
    } finally {
      imageUploading.value = false;
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: AppLocalizations.of(Get.context!)!.deleteAccount,
      middleText: AppLocalizations.of(Get.context!)!.deleteAccountWarning,
      confirm: ElevatedButton(
        onPressed: () => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
          child: Text(AppLocalizations.of(Get.context!)!.delete),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: Text(AppLocalizations.of(Get.context!)!.cancel),
      ),
    );
  }

  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openloadingDialog(
        AppLocalizations.of(Get.context!)!.processing,
        TImages.proccessLottie,
      );
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();

          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();

          Get.to(() => const ReAuthenticateScreen());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.warningSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPassword() async {
    try {
      TFullScreenLoader.openloadingDialog(
        AppLocalizations.of(Get.context!)!.processing,
        TImages.proccessLottie,
      );

      // check the internet connectivity

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!reauthenticateFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
            verifyEmail.text.trim(),
            verifyPassword.text.trim(),
          );
      await AuthenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.warningSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
