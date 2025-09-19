import 'package:brothers_creative/bindings/general_binding.dart';
import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/features/authontication/screens/login/login.dart';
import 'package:brothers_creative/features/authontication/screens/onboarding/onboarding.dart';
import 'package:brothers_creative/features/authontication/screens/register/verify_email.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/navigation_menu.dart';
import 'package:brothers_creative/utils/helpers/system_ui_helper.dart';
import 'package:brothers_creative/utils/storage/storage_utility.dart';
import 'package:brothers_creative/utils/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with TickerProviderStateMixin {
  // تم إزالة الحقول غير المستخدمة

  @override
  void initState() {
    super.initState();
    // تم إزالة الكود غير المستخدم
  }

  // تم إزالة override غير الضروري

  // تحديث SystemUI حسب النمط الحالي
  void _updateSystemUI() {
    TSystemUIHelper.updateSystemUI(context);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,
      home: const CustomSplashScreen(),
      builder: (context, child) {
        // تحديث SystemUI حسب النمط
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _updateSystemUI();
          // إضافة تشخيص في وضع التطوير
          if (kDebugMode) {
            TSystemUIHelper.debugCurrentMode(context);
          }
        });
        return child!;
      },

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Brothers Creative',
      themeMode: ThemeMode.system,
      theme:
          Get.locale?.languageCode == 'en'
              ? TAppTheme.lightThemeEg
              : TAppTheme.lightThemeArabic,
      darkTheme:
          Get.locale?.languageCode == 'en'
              ? TAppTheme.darkThemeEg
              : TAppTheme.darkThemeAr,

      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

// شاشة التحميل المخصصة
class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // تهيئة متحكم دوران اللوغو
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // تهيئة متحكم تكبير وتصغير اللوغو
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // تهيئة متحكم الظهور التدريجي
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // حركة الدوران المستمرة
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    // حركة التكبير والتصغير
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    // حركة الظهور التدريجي
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    // بدء الحركات
    _rotationController.repeat();
    _scaleController.repeat(reverse: true);
    _fadeController.forward();

    // الانتقال إلى AuthWrapper بعد 3 ثوانٍ
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => const AuthWrapper());
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00A8FF), // TColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // اللوغو الجديد مع الحركة
              Stack(
                alignment: Alignment.center,
                children: [
                  // خلفية دائرية متحركة
                  AnimatedBuilder(
                    animation: _rotationAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotationAnimation.value * 2 * 3.14159,
                        child: Container(
                          width: 280,
                          height: 280,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // اللوغو الرئيسي مع الحركة
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _scaleAnimation,
                      _fadeAnimation,
                    ]),
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Opacity(
                          opacity: _fadeAnimation.value,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/logos/icon.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // تأثيرات إضافية متحركة
                  AnimatedBuilder(
                    animation: _rotationAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: -_rotationAnimation.value * 2 * 3.14159,
                        child: Container(
                          width: 320,
                          height: 320,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // شريط التحميل المتحرك
              AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Container(
                      width: 250,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // نص التحميل
              // Text(
              //   'Brothers Creative',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //     letterSpacing: 1.2,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// AuthWrapper لتحديد الشاشة المناسبة بناءً على حالة المصادقة
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<AuthenticationRepository>(
      builder: (controller) {
        // سيُعاد البناء تلقائيًا عند تغيّر Rx داخل AuthenticationRepository
        final user = controller.authUser;

        if (user != null) {
          if (user.emailVerified) {
            _initializeUserStorage(user.uid);
            return const NavigationMenu();
          } else {
            return VerifyEmailScreen(email: user.email);
          }
        } else {
          final isFirstTime = GetStorage().read('isTheFirstTime') ?? true;
          if (isFirstTime) {
            return const OnBoardingScreen();
          } else {
            _initializeGuestStorage();
            return const LoginScreen();
          }
        }
      },
    );
  }

  void _initializeUserStorage(String uid) async {
    try {
      await TLocalStorage.init(uid);
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing user storage: $e');
      }
    }
  }

  void _initializeGuestStorage() async {
    try {
      await TLocalStorage.init('gust');
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing guest storage: $e');
      }
    }
  }
}
