import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// مساعد لإدارة إعدادات SystemUI حسب النمط
class TSystemUIHelper {
  TSystemUIHelper._();

  /// تحديث SystemUI حسب النمط الحالي
  static void updateSystemUI(BuildContext context) {
    // الحصول على النمط من عدة مصادر للتأكد من الدقة
    final themeBrightness = Theme.of(context).brightness;
    final mediaQueryBrightness = MediaQuery.of(context).platformBrightness;

    // استخدام MediaQuery كأولوية لأنه يعكس إعدادات النظام
    final isDark =
        mediaQueryBrightness == Brightness.dark ||
        themeBrightness == Brightness.dark;

    if (kDebugMode) {
      print('🔍 SystemUI Update:');
      print('   Theme Brightness: $themeBrightness');
      print('   MediaQuery Brightness: $mediaQueryBrightness');
      print('   Is Dark: $isDark');
      print('   StatusBar Icons: ${isDark ? "LIGHT (WHITE)" : "DARK (BLACK)"}');
      print(
        '   Navigation Icons: ${isDark ? "LIGHT (WHITE)" : "DARK (BLACK)"}',
      );
    }

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        // شريط الحالة - شفاف مع أيقونات مناسبة للنمط
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,

        // شريط التنقل - شفاف مع أيقونات مناسبة للنمط
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarDividerColor:
            isDark ? Colors.white24 : Colors.black12,

        // إعدادات إضافية
        systemNavigationBarContrastEnforced: false,
      ),
    );
  }

  /// تطبيق نمط النافذة الكاملة
  static void enableFullScreenMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  /// تطبيق الوضع العادي
  static void enableNormalMode() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
  }

  /// إعدادات خاصة للنمط الفاتح
  static void setLightMode() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.black12,
        systemNavigationBarContrastEnforced: false,
      ),
    );
  }

  /// إعدادات خاصة للنمط المظلم
  static void setDarkMode() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.white24,
        systemNavigationBarContrastEnforced: false,
      ),
    );
  }

  /// إعدادات مخصصة للنمط المحدد
  static void setCustomMode({
    required bool isDark,
    Color? statusBarColor,
    Color? navigationBarColor,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: navigationBarColor ?? Colors.transparent,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarDividerColor:
            isDark ? Colors.white24 : Colors.black12,
        systemNavigationBarContrastEnforced: false,
      ),
    );
  }

  /// اختبار النمط الحالي وإظهار معلومات التشخيص
  static void debugCurrentMode(BuildContext context) {}

  /// إجبار تطبيق النمط المظلم
  static void forceDarkMode() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // أبيض
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light, // أبيض
        systemNavigationBarDividerColor: Colors.white24,
        systemNavigationBarContrastEnforced: false,
      ),
    );
  }

  /// إجبار تطبيق النمط الفاتح
  static void forceLightMode() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // أسود
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark, // أسود
        systemNavigationBarDividerColor: Colors.black12,
        systemNavigationBarContrastEnforced: false,
      ),
    );
  }

  /// تحديث SystemUI عند تغيير النمط
  static void updateSystemUIOnThemeChange(BuildContext context, bool isDark) {
    if (kDebugMode) {
      print('🔄 Theme Changed - Updating SystemUI:');
      print('   New Theme: ${isDark ? "DARK" : "LIGHT"}');
      print('   Status Bar Icons: ${isDark ? "WHITE" : "BLACK"}');
      print('   Navigation Icons: ${isDark ? "WHITE" : "BLACK"}');
    }

    // تطبيق SystemUI مباشرة بدلاً من استدعاء الدوال الثابتة
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        // شريط الحالة - شفاف مع أيقونات مناسبة للنمط
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,

        // شريط التنقل - شفاف مع أيقونات مناسبة للنمط
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarDividerColor:
            isDark ? Colors.white24 : Colors.black12,

        // إعدادات إضافية
        systemNavigationBarContrastEnforced: false,
      ),
    );
  }

  /// تحديث SystemUI مع تأخير بسيط للتأكد من تحديث النمط
  static void updateSystemUIWithDelay(
    BuildContext context, {
    int delayMs = 100,
  }) {
    Future.delayed(Duration(milliseconds: delayMs), () {
      updateSystemUI(context);
    });
  }

  /// تحديث SystemUI عند تغيير النمط مع تأخير للتأكد من تحديث النمط
  static void updateSystemUIOnThemeChangeWithDelay(
    BuildContext context,
    bool isDark, {
    int delayMs = 150,
  }) {
    if (kDebugMode) {
      print('🔄 Theme Changed - Updating SystemUI with delay:');
      print('   New Theme: ${isDark ? "DARK" : "LIGHT"}');
      print('   Delay: ${delayMs}ms');
    }

    Future.delayed(Duration(milliseconds: delayMs), () {
      updateSystemUIOnThemeChange(context, isDark);
    });
  }

  /// تحديث SystemUI عند تغيير النمط مع تأخير وتحديث إضافي
  static void updateSystemUIOnThemeChangeEnhanced(
    BuildContext context,
    bool isDark, {
    int delayMs = 100,
  }) {
    if (kDebugMode) {
      print('🔄 Theme Changed - Enhanced SystemUI Update:');
      print('   New Theme: ${isDark ? "DARK" : "LIGHT"}');
      print('   Status Bar Icons: ${isDark ? "WHITE" : "BLACK"}');
      print('   Navigation Icons: ${isDark ? "WHITE" : "BLACK"}');
    }

    // تطبيق فوري
    updateSystemUIOnThemeChange(context, isDark);

    // تطبيق إضافي بعد تأخير للتأكد
    Future.delayed(Duration(milliseconds: delayMs), () {
      updateSystemUIOnThemeChange(context, isDark);
      if (kDebugMode) {
        print('   🔄 Applied again after ${delayMs}ms delay');
      }
    });
  }

  /// تحديث SystemUI بقوة للتأكد من التطبيق
  static void forceUpdateSystemUI(BuildContext context, bool isDark) {
    if (kDebugMode) {
      print('💪 Force Updating SystemUI:');
      print('   Theme: ${isDark ? "DARK" : "LIGHT"}');
      print('   Icons: ${isDark ? "WHITE" : "BLACK"}');
    }

    // تطبيق متعدد المراحل للتأكد من التطبيق
    updateSystemUIOnThemeChange(context, isDark);

    Future.delayed(const Duration(milliseconds: 50), () {
      updateSystemUIOnThemeChange(context, isDark);
    });

    Future.delayed(const Duration(milliseconds: 150), () {
      updateSystemUIOnThemeChange(context, isDark);
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      updateSystemUIOnThemeChange(context, isDark);
      if (kDebugMode) {
        print('   💪 Final force update applied');
      }
    });
  }
}
