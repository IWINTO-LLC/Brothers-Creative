import 'package:brothers_creative/data/repositoies/banners/banner_repository.dart';
import 'package:brothers_creative/features/shop/models/banner_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();
  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;
      final bannersRepo = Get.put(BannerRepository());
      final banners = await bannersRepo.fetchBanners();
      this.banners.assignAll(banners);
      if (kDebugMode) {
        print('============ banners length==========');
        print(banners.length);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      } // Get.snackbar('oh Snap!', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
