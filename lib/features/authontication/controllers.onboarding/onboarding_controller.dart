import 'package:brothers_creative/app.dart';
import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/data/repositoies/brothers/onboarding_repository.dart';
import 'package:brothers_creative/features/authontication/screens/login/login.dart';
import 'package:brothers_creative/features/general/models/onboarding_model.dart';
import 'package:brothers_creative/utils/loader/loaders.dart';
import 'package:brothers_creative/utils/logging/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController {
  final isLoading = false.obs;

  final _onboardingRepository = Get.put(OnBoardingRepository());
  RxList<OnBoardingModel> allData = <OnBoardingModel>[].obs;

  static OnBoardingController get instance => Get.find();
//Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
//update current index when page Scrolling

  @override
  void onInit() {
    //  fetchAllData();
    super.onInit();
  }

  Future<List<OnBoardingModel>> fetchAllData() async {
    try {
      isLoading.value = true;

      final data = await _onboardingRepository.getAlldata();
      allData.assignAll(data);
      return data;
    } catch (e) {
      TLoggerHelper.error(e.toString());
      TLoader.erroreSnackBar(title: 'oh Snap!', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  void updatePageIndicator(index) => currentPageIndex.value = index;

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
    // Get.updateLocale(const Locale('en'));
// deviceStorage.writeIfNull('isTheFirstTime', true);
    if (currentPageIndex.value == allData.length - 1) {
      GetStorage().write('isTheFirstTime', false);

      if (AuthenticationRepository.instance.authUser != null) {
        Get.to(const App());
      } else {
        Get.to(const LoginScreen());
      }
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    GetStorage().write('isTheFirstTime', false);
    if (AuthenticationRepository.instance.authUser != null) {
      Get.to(const App());
    } else {
      Get.to(const LoginScreen());
    }
  }
}
