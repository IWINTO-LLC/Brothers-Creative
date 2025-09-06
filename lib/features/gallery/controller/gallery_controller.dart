import 'package:brothers_creative/data/repositoies/gallery/gallery_repository.dart';
import 'package:brothers_creative/features/gallery/models/gallery_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class GalleryController extends GetxController {
  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<GalleryModel> banners = <GalleryModel>[].obs;

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
      final galleryRepo = Get.put(GalleryRepository());
      final banners = await galleryRepo.fetchgalleryPhoto();
      this.banners.assignAll(banners);
      if (kDebugMode) {
        print('============ gallery  banners length==========');
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
