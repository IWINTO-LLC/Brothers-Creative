import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/features/authontication/controllers.onboarding/onboarding_controller.dart';
import 'package:brothers_creative/features/authontication/controllers/login/login_controller.dart';
import 'package:brothers_creative/features/authontication/controllers/network_manager.dart';
import 'package:brothers_creative/features/blog/controller/blog_controller.dart';
import 'package:brothers_creative/features/gallery/controller/album_controller.dart';
import 'package:brothers_creative/features/gallery/controller/gallery_controller.dart';
import 'package:brothers_creative/features/general/controllers/brother_controller.dart';

import 'package:brothers_creative/features/project/controllers/ask_price_controller.dart';
import 'package:brothers_creative/features/project/controllers/project_controller.dart';
import 'package:brothers_creative/features/shop/controllers/address_controller.dart';
import 'package:brothers_creative/features/shop/controllers/banner_controller.dart';
import 'package:brothers_creative/features/shop/controllers/product/checkout_controller.dart';
import 'package:brothers_creative/features/shop/controllers/product/images_controller.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(AuthenticationRepository());
    Get.put(LoginController());
    Get.put(OnBoardingController());
    Get.put(AlbumController());
    Get.put(GalleryController());

    Get.put(BrothersController());
    Get.put(AddressController());
    Get.put(CheckoutController());
    Get.put(ImagesController());
    Get.put(ProjectController());
    Get.put(AskPriceController());
    Get.put(BlogController());
    Get.put(BannerController());

    // Get.put(PayTabsController());
  }

  //ProjectController
}
