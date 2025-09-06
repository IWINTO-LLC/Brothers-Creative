import 'dart:io';

import 'package:brothers_creative/common/widgets/images/rounded_image.dart';
import 'package:brothers_creative/features/shop/models/product_model.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:brothers_creative/utils/loader/loaders.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
//import 'package:intl/number_symbols_data.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();
  RxString selectedProductImage = ''.obs;
  RxDouble turns = 0.0.obs;
  RxInt selectdindex = 0.obs;
  List<String> getAllProductImage(ProductModel product) {
    Set<String> images = {};
    images.add(product.thumbnail);
    selectedProductImage.value = product.thumbnail;
    if (product.images != null) {
      images.addAll(product.images!);
    }
    return images.toList();
  }

  Future<void> fullScreenImage2(String image, List<String> otherImages) async {
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: PhotoView(
                  imageProvider: NetworkImage(image),
                  // enableRotation: true,
                  maxScale: PhotoViewComputedScale.contained * 4,
                  minScale: PhotoViewComputedScale.contained,
                ),
              ),
            ));
  }

  var start = 0;
  Future<void> fullScreenImage(
      int currIndex, String img, List<String> otherImages) async {
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: PhotoViewGallery.builder(
                  onPageChanged: (index) {
                    start = 2;
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: otherImages.length,
                  builder: (context, index) {
                    final url = otherImages[index];

                    if (kDebugMode) {
                      print('=============index is$index===start is $start');
                    }
                    return PhotoViewGalleryPageOptions(
                      imageProvider:
                          start == 0 ? NetworkImage(img) : NetworkImage(url),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.contained * 4,
                    );
                  }),
            ));
  }

  Future<void> showEnLargedImage(
      String image, String? title, String? description) async {
    TLoader.warningSnackBar(title: 'in progress Now...');
    //return;
    // var myFile = await file(image);
    Get.to(fullscreenDialog: true, OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Dialog.fullscreen(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: InteractiveViewer(
                          boundaryMargin: const EdgeInsets.all(
                              0.0), // Optional: Margin around the content
                          minScale: 1.0, // Optional: Minimum scale (zoom out)
                          maxScale: 3.0, // Optional: Maximum scale (zoom in)
                          scaleEnabled:
                              true, // Optional: Allow scaling (zooming)
                          panEnabled:
                              true, // Optional: Allow panning (dragging)
                          // Optional: Align panning to one axis
                          child: Obx(
                            () => AnimatedRotation(
                              turns: turns.value,
                              duration: const Duration(seconds: 1),
                              child: TRoundedImage(
                                borderRaduis: BorderRadius.circular(20),
                                backgroundColor: Colors.transparent,
                                width: THelperFunctions.screenwidth(),
                                height: THelperFunctions.screenHeight() * 0.6,
                                isNetworkImage: true,
                                imageUrl: image,
                                padding: const EdgeInsets.all(0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Share.share('check out my image $image',
                                  //     subject: 'Look what I like!');
                                },
                                child: const Icon(
                                  size: 30,
                                  Icons.share,
                                  weight: 2,
                                ),
                              ),
                              const SizedBox(
                                width: TSizes.md,
                              ),
                              GestureDetector(
                                onTap: () => turns.value += 1 / 4,
                                child: const Icon(
                                  Iconsax.rotate_right,
                                  size: 35,
                                  weight: 2,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  if (title != '')
                    const SizedBox(height: TSizes.spaceBtWsections / 2),
                  if (title != '')
                    Padding(
                      padding: const EdgeInsets.only(
                          left: TSizes.defaultSpace,
                          right: TSizes.defaultSpace),
                      child: Align(
                        alignment: Get.locale?.languageCode == 'en'
                            ? Alignment.topLeft
                            : Alignment.topRight,
                        child: Text(title!,
                            style:
                                Theme.of(Get.context!).textTheme.headlineSmall),
                      ),
                    ),
                  if (description != '')
                    const SizedBox(height: TSizes.spaceBtWsections / 2),
                  if (description != '')
                    Padding(
                      padding: const EdgeInsets.only(
                          left: TSizes.defaultSpace,
                          right: TSizes.defaultSpace),
                      child: Align(
                        alignment: Get.locale?.languageCode == 'en'
                            ? Alignment.topLeft
                            : Alignment.topRight,
                        child: Text(description!,
                            style: Theme.of(Get.context!).textTheme.bodyMedium),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtWsections),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 150,
                  child: OutlinedButton(
                    onPressed: () {
                      turns.value = 0.0;
                      Get.back();
                    },
                    child: Text(AppLocalizations.of(Get.context!)!.close,
                        style: Theme.of(Get.context!).textTheme.headlineSmall),
                  ),
                ),
              )
            ],
          ),
        ));
      },
    ));
  }

  Future<File> file(String filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String pathName = p.join(dir.path, filename);
    return File(pathName);
  }
}
