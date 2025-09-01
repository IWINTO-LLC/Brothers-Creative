import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';

class TValidator {
  ///Empty Text Validation

  static String? validateEmptyText(String? fieldName, String? value) {
    String g = AppLocalizations.of(Get.context!)!.required;
    if (value == null || value.isEmpty) {
      return '$fieldName  $g';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final ctx = Get.context!;
    final isEn = Get.locale?.languageCode == 'en';
    if (value == null || value.trim().isEmpty) {
      // استخدم رسالة "مطلوب" المتوفرة
      return AppLocalizations.of(ctx)!.required;
    }
    // تحقق من بنية البريد الإلكتروني
    final email = value.trim();
    final emailRegExp = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegExp.hasMatch(email)) {
      return isEn ? 'Invalid email address' : 'بريد إلكتروني غير صالح';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.phoneRequired;
    }
    // final phoneRegExp = RegExp(r'^\d{10}$');
    // if (!phoneRegExp.hasMatch(value)) {
    //   return 'invalid phone number (10 digits requeried..)';
    // }
    return null;
  }
}
