import 'dart:io';

import 'package:brothers_creative/data/repositoies/user/user_repository.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:brothers_creative/utils/popups/full_screen_loader.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:brothers_creative/features/authontication/screens/login/login.dart';
import 'package:brothers_creative/features/authontication/screens/login/phone_verification.dart';
import 'package:brothers_creative/features/personlization/models/users/user_model.dart';
import 'package:brothers_creative/utils/loader/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  ///variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final isGust = true.obs;
  var verificationId = ''.obs;
  final Rx<User?> _authUser = Rx<User?>(null);

  User? get authUser => _authUser.value;

  @override
  void onReady() {
    // إضافة listener لتغييرات حالة المصادقة
    _auth.authStateChanges().listen((User? user) {
      _authUser.value = user;
      if (kDebugMode) {
        print('Auth state changed: ${user?.email}');
      }
    });

    // لا نحتاج لإزالة FlutterNativeSplash هنا لأنه تم إزالته في MainApp
    // screenRedirect(); // إزالة هذا لأن AuthWrapper سيتعامل مع التوجيه
    //super.onReady();
  }

  ///Rigesteration

  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      var authUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      isGust.value = false;
      return authUser;
    } on FirebaseAuthException catch (e) {
      throw (e.code).toString();
    } on FirebaseException catch (e) {
      throw (e.code).toString();
    } on FormatException catch (_) {
      throw 'error formate';
    } on Platform catch (e) {
      throw e.toString();
    } catch (e) {
      throw 'Something wrong';
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw (e.code).toString();
    } on FirebaseException catch (e) {
      throw (e.code).toString();
    } on FormatException catch (_) {
      throw 'error formate';
    } on Platform catch (e) {
      throw e.toString();
    } catch (e) {
      throw 'Something wrong';
    }
  }

  Future<void> phoneAuthentication(String phoneNum) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNum,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
        if (kDebugMode) {
          print(credential.verificationId.toString());
        }
        // TLoader.successSnackBar(
        //     title: 'sussess', message: credential.verificationId.toString());
        TLoader.successSnackBar(
          title: 'sussess',
          message: 'complite verification please',
        );
        Get.to(const PhoneVerificationScreen());
      },
      codeSent: (verificationId, resendingToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        // throw e;
        if (kDebugMode) {
          print(e.message.toString());
        }
        if (e.code == 'invalid_phone_number') {
          TLoader.erroreSnackBar(
            title: 'Error',
            message: 'the provided phone number is not valid.',
          );
        } else {
          TLoader.erroreSnackBar(title: 'Error', message: e.message.toString());
          if (kDebugMode) {
            print(e.message.toString());
          }
        }
      },
    );
  }

  Future<bool> verifyOtp(String otp) async {
    var credentials = await _auth.signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      ),
    );
    if (credentials.user != null) {
      String uid = credentials.user!.uid;
      final user = UserModel(
        id: uid,
        phoneNumber: credentials.user!.phoneNumber,
      );
      final userRepository = Get.put(UserRepository());
      userRepository.saveUserRecord(user);
      //   TLoader.successSnackBar(
      //       title: "sussess", message: "your Account created sussessfully");
    }

    return credentials.user != null ? true : false;
  }

  /// Logout user
  Future<void> logOut() async {
    try {
      // Show brief loading overlay
      TFullScreenLoader.openloadingDialog(
        AppLocalizations.of(Get.context!)!.loggingOut,
        TImages.proccessLottie,
        color:
            THelperFunctions.isDarkMode(Get.context!)
                ? Colors.white
                : Colors.black,
      );
      await Future.delayed(const Duration(seconds: 1));

      // Clear local storage first
      await deviceStorage.remove('isTheFirstTime');
      await deviceStorage.remove('user_id');
      await deviceStorage.remove('user_data');

      // Sign out from Firebase
      await _auth.signOut();
      // Also sign out from Google to force account picker next time
      try {
        final google = GoogleSignIn();
        await google.signOut();
        await google.disconnect();
      } catch (_) {}

      // Reset guest status
      isGust.value = true;

      // Clear auth user
      _authUser.value = null;

      if (kDebugMode) {
        print('User logged out successfully');
      }

      // Close loader and show goodbye toast
      TFullScreenLoader.stopLoading();
      // TLoader.successSnackBar(
      //   title: AppLocalizations.of(Get.context!)!.logout,
      //   message: AppLocalizations.of(Get.context!)!.seeYouLater,
      // );

      // Navigate to Login screen after logout
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('FirebaseAuthException during logout: ${e.code} - ${e.message}');
      }
      // Even if Firebase fails, we should still clear local data
      await deviceStorage.remove('isTheFirstTime');
      await deviceStorage.remove('user_id');
      await deviceStorage.remove('user_data');
      isGust.value = true;
      _authUser.value = null;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('FirebaseException during logout: ${e.code} - ${e.message}');
      }
      // Even if Firebase fails, we should still clear local data
      await deviceStorage.remove('isTheFirstTime');
      await deviceStorage.remove('user_id');
      await deviceStorage.remove('user_data');
      isGust.value = true;
      _authUser.value = null;
    } catch (e) {
      if (kDebugMode) {
        print('Unknown error during logout: $e');
      }
      // Even if there's an error, we should still clear local data
      await deviceStorage.remove('isTheFirstTime');
      await deviceStorage.remove('user_id');
      await deviceStorage.remove('user_data');
      isGust.value = true;
      _authUser.value = null;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw (e.code).toString();
    } on FirebaseException catch (e) {
      throw (e.code).toString();
    } on FormatException catch (_) {
      throw 'error formate';
    } on Platform catch (e) {
      throw e.toString();
    } catch (e) {
      throw 'Something wrong';
    }
  }

  Future<void> reAuthenticateWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw (e.code).toString();
    } on FirebaseException catch (e) {
      throw (e.code).toString();
    } on FormatException catch (_) {
      throw 'error formate';
    } on Platform catch (e) {
      throw e.toString();
    } catch (e) {
      throw 'Something wrong';
    }
  }

  Future<UserCredential?> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      if (kDebugMode) {
        print('Attempting to sign in with email: $email');
      }

      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (kDebugMode) {
        print('Sign in successful for user: ${result.user?.uid}');
      }

      return result;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('FirebaseAuthException: ${e.code} - ${e.message}');
      }
      throw (e.code).toString();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('FirebaseException: ${e.code} - ${e.message}');
      }
      throw (e.code).toString();
    } on FormatException catch (e) {
      if (kDebugMode) {
        print('FormatException: $e');
      }
      throw 'error formate';
    } on Platform catch (e) {
      if (kDebugMode) {
        print('Platform Exception: $e');
      }
      throw e.toString();
    } catch (e) {
      if (kDebugMode) {
        print('Unknown error during sign in: $e');
        print('Error type: ${e.runtimeType}');
      }
      throw 'Something wrong: $e';
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // عرض شاشة التحميل
      TFullScreenLoader.openloadingDialog(
        'جاري تحضير تسجيل الدخول بـ Google...',
        TImages.proccessLottie,
        color:
            THelperFunctions.isDarkMode(Get.context!)
                ? Colors.white
                : Colors.black,
      );

      // اجعل التطبيق ينسى الحساب السابق ليظهر اختيار الحساب في كل مرة
      final googleSignIn = GoogleSignIn();
      try {
        await googleSignIn.signOut();
        await googleSignIn.disconnect();
      } catch (_) {}

      // إغلاق شاشة التحميل قبل عرض قائمة الحسابات
      TFullScreenLoader.stopLoading();

      GoogleSignInAccount? userAccount = await googleSignIn.signIn();

      if (userAccount == null) {
        TFullScreenLoader.stopLoading();
        if (kDebugMode) {
          print("Google Sign In was cancelled by user");
        }
        return null; // المستخدم ألغى العملية
      }

      if (kDebugMode) {
        print("Step 1: Got Google account - ${userAccount.email}");
      }

      // Obtain the auth details from the request.
      final GoogleSignInAuthentication? googleAuth =
          await userAccount.authentication;

      if (googleAuth == null) {
        TFullScreenLoader.stopLoading();
        if (kDebugMode) {
          print("Failed to get Google authentication");
        }
        throw 'Failed to authenticate with Google';
      }

      if (kDebugMode) {
        print("Step 2: Got Google authentication tokens");
      }

      // Create a new credential.
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      if (kDebugMode) {
        print("Step 3: Created Firebase credential");
      }

      // Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(credentials);

      if (kDebugMode) {
        print(
          "Step 4: Successfully signed in to Firebase - ${userCredential.user?.email}",
        );
      }

      // تأكيد البريد الإلكتروني من Google تلقائياً
      if (userCredential.user != null) {
        await _autoVerifyGoogleEmail(userCredential.user!);
      }

      isGust.value = false;
      return userCredential;
    } on FirebaseAuthException catch (e) {
      TFullScreenLoader.stopLoading();
      if (kDebugMode) {
        print(
          'FirebaseAuthException during Google sign in: ${e.code} - ${e.message}',
        );
      }
      throw (e.code).toString();
    } on FirebaseException catch (e) {
      TFullScreenLoader.stopLoading();
      if (kDebugMode) {
        print(
          'FirebaseException during Google sign in: ${e.code} - ${e.message}',
        );
      }
      throw (e.code).toString();
    } on FormatException catch (e) {
      TFullScreenLoader.stopLoading();
      if (kDebugMode) {
        print('FormatException during Google sign in: $e');
      }
      throw 'Authentication format error';
    } on Platform catch (e) {
      TFullScreenLoader.stopLoading();
      if (kDebugMode) {
        print('Platform Exception during Google sign in: $e');
      }
      throw e.toString();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      if (kDebugMode) {
        print('Unknown error during Google sign in: $e');
        print('Error type: ${e.runtimeType}');
      }
      throw 'Google sign in failed: $e';
    }
  }

  /// تأكيد البريد الإلكتروني من Google تلقائياً
  Future<void> _autoVerifyGoogleEmail(User user) async {
    try {
      if (kDebugMode) {
        print("Auto-verifying Google email for: ${user.email}");
        print("Current emailVerified status: ${user.emailVerified}");
      }

      // إذا كان البريد من Google ولم يتم تأكيده
      if (user.providerData.any(
            (provider) => provider.providerId == 'google.com',
          ) &&
          !user.emailVerified) {
        // محاولة تأكيد البريد تلقائياً
        await user.reload();

        // التحقق من حالة التأكيد بعد التحديث
        final updatedUser = _auth.currentUser;
        if (updatedUser != null && updatedUser.emailVerified) {
          if (kDebugMode) {
            print("✅ Google email auto-verified successfully");
          }
        } else {
          if (kDebugMode) {
            print("⚠️ Google email could not be auto-verified");
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during auto-verification: $e");
      }
      // لا نريد أن نوقف العملية إذا فشل التأكيد التلقائي
    }
  }

  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw (e.code).toString();
    } on FirebaseException catch (e) {
      throw (e.code).toString();
    } on FormatException catch (_) {
      throw 'error formate';
    } on Platform catch (e) {
      throw e.toString();
    } catch (e) {
      throw 'Something wrong';
    }
  }
}
