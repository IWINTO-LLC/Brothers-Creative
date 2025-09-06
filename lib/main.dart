import 'package:brothers_creative/api/frebase_api.dart';
import 'package:brothers_creative/firebase_options.dart';
import 'package:brothers_creative/main_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'data/repositoies/authentication/authentication_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // إعدادات SystemUI ثابتة - سيتم تحديثها لاحقاً حسب النمط
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  FlutterError.onError = (FlutterErrorDetails details) {
    if (kDebugMode) {
      print('Flutter Error: ${details.exception}');
      print('Stack trace: ${details.stack}');
    }

    if (details.exception.toString().contains('avc: denied') ||
        details.exception.toString().contains('miuilog')) {
      if (kDebugMode) {
        print('Ignoring SELinux permission error');
      }
      return;
    }

    // معالجة جميع الأخطاء الأخرى
    if (kDebugMode) {
      print('Handling Flutter error gracefully');
    }
  };

  // معالجة أخطاء Platform
  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) {
      print('Platform Error: $error');
      print('Stack trace: $stack');
    }

    // تجاهل SELinux errors
    if (error.toString().contains('avc: denied') ||
        error.toString().contains('miuilog')) {
      if (kDebugMode) {
        print('Ignoring SELinux permission error');
      }
      return true;
    }

    // معالجة جميع الأخطاء الأخرى
    if (kDebugMode) {
      print('Handling platform error gracefully');
    }
    return true;
  };

  await GetStorage.init();

  if (kDebugMode) {
    print('=========get storage ========');
    print(GetStorage().read('en'));
  }

  GetStorage().writeIfNull('en', true);
  if (Get.locale?.languageCode == null && GetStorage().read('en')) {
    Get.updateLocale(const Locale('en'));
  } else {
    Get.updateLocale(const Locale('ar'));
  }

  try {
    // التحقق من وجود Firebase apps
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      if (kDebugMode) {
        print('Firebase initialized successfully');
      }
    } else {
      if (kDebugMode) {
        print('Firebase already initialized, skipping...');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Firebase initialization error: $e');
      print('Continuing without Firebase...');
    }
    // نستمر حتى لو فشل Firebase
  }

  try {
    // تهيئة Controllers مع معالجة الأخطاء
    Get.put(AuthenticationRepository());
    if (kDebugMode) {
      print('AuthenticationRepository initialized successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      print('AuthenticationRepository error: $e');
    }
  }

  try {
    Get.put(FirebaseApiController());
    if (kDebugMode) {
      print('FirebaseApiController initialized successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      print('FirebaseApiController error: $e');
    }
  }

  runApp(const MainApp());
}
