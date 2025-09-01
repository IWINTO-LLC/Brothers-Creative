import 'dart:ui';

import 'package:brothers_creative/data/repositoies/brothers/brothers_repository.dart';
import 'package:brothers_creative/features/general/models/brother_model.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/loader/loaders.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class BrothersController extends GetxController {
  static BrothersController get instance => Get.find();
  final isLoading = false.obs;
  RxString? primaryColor = "Color(0xff0099ff)".obs;
  Color color = TColors.white;
  final _brothersRepository = Get.put(BrotherRepository());
  RxList<BrotherModel> allData = <BrotherModel>[].obs;
  // final imageUrl = [
  //   'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/Users%2FImages%2FProfile%2Fscaled_1000414330.jpg?alt=media&token=18f991e9-f02d-4922-8deb-883885623893',
  //   'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/Users%2FImages%2FProfile%2Fscaled_1000414330.jpg?alt=media&token=18f991e9-f02d-4922-8deb-883885623893',
  //   'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/Users%2FImages%2FProfile%2Fscaled_1000414330.jpg?alt=media&token=18f991e9-f02d-4922-8deb-883885623893',
  //   'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/Users%2FImages%2FProfile%2Fscaled_1000414330.jpg?alt=media&token=18f991e9-f02d-4922-8deb-883885623893',
  //   'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/Users%2FImages%2FProfile%2Fscaled_1000414330.jpg?alt=media&token=18f991e9-f02d-4922-8deb-883885623893'
  // ];
  @override
  void onInit() {
    fetchAllData();
    super.onInit();
  }

  Future<void> fetchAllData() async {
    try {
      isLoading.value = true;

      final data = await _brothersRepository.getAlldata();
      allData.assignAll(data);
      primaryColor?.value = allData[0].primaryColor!;
      // color = ColorUtils.stringToColor(primaryColor.toString());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      TLoader.erroreSnackBar(title: 'oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
