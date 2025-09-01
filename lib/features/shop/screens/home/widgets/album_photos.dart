import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/common/widgets/layout/grid_gallery_layout.dart';
import 'package:brothers_creative/common/widgets/shimmers/gallery_photo_shimmer.dart';
import 'package:brothers_creative/common/widgets/shimmers/shimmer.dart';
import 'package:brothers_creative/features/gallery/controller/album_controller.dart';
import 'package:brothers_creative/features/gallery/models/album_model.dart';
import 'package:brothers_creative/features/general/screens/gallery_widget.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';

class TSingleAlbumPhotoView extends StatelessWidget {
  const TSingleAlbumPhotoView({
    super.key,
    required this.album,
  });
  final AlbumModel album;
  @override
  Widget build(BuildContext context) {
    // final imageController = Get.put(ImagesController());
    final controller = AlbumController.instance;
    final isEg = Get.locale?.languageCode == 'en';
    return Directionality(
      textDirection: Get.locale?.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            isEg ? album.name : album.arabicName,
          ),
          showBackArrow: true,
        ),
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    const SizedBox(
                      height: TSizes.spaceBtWItems,
                    ),
                    FutureBuilder(
                        future: controller.getGalleryAlbum(albumId: album.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const TGalleryPhotoShimmer(
                              itemCount: 4,
                            );
                          }
                          if (!snapshot.hasData ||
                              snapshot.data == null ||
                              snapshot.data!.isEmpty) {
                            return Center(
                              child: Text(
                                AppLocalizations.of(context)!.noData,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .somethingWentWrong,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          }
                          final photos = snapshot.data!;
                          if (photos.isEmpty) {
                            return Center(
                              child: Text(
                                AppLocalizations.of(context)!.noData,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          }

                          return TGridGalleryLayout(
                              maxAxisExtent:
                                  THelperFunctions.screenwidth() / 1.7,
                              itemCount: photos.length,
                              itemBuilder: (_, index) => GestureDetector(
                                    onTap: () => Get.to(
                                      GalleryWidget(
                                        urlImage:
                                            photos.map((e) => e.image).toList(),
                                        index: index,
                                      ),
                                    ),

                                    // imageController.showEnLargedImage(
                                    //     photos[index].image,
                                    //     Get.locale?.languageCode == 'en'
                                    //         ? photos[index].name ?? ""
                                    //         : photos[index].arabicName ?? "",
                                    //     Get.locale?.languageCode == 'en'
                                    //         ? photos[index].description ?? ""
                                    //         : photos[index]
                                    //                 .arabicDescription ??
                                    //             ""),
                                    child: Column(
                                      children: [
                                        CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            width:
                                                THelperFunctions.screenwidth() -
                                                    16,
                                            height:
                                                THelperFunctions.screenwidth() /
                                                    1.7,
                                            // color: TColors.darkGrey.withValues(alpha:0.1),
                                            imageUrl: photos[index].image,
                                            imageBuilder: (context,
                                                    imageProvider) =>
                                                Container(
                                                  width: THelperFunctions
                                                          .screenwidth() -
                                                      17,
                                                  height: THelperFunctions
                                                          .screenwidth() /
                                                      1.7,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    child: TShimmerEffect(
                                                        width: THelperFunctions
                                                                .screenwidth() -
                                                            16,
                                                        height: 230)),
                                            errorWidget: (context, url, error) =>
                                                const Icon(
                                                  Icons.error,
                                                  size: 50,
                                                )),
                                        // TRoundedImage(
                                        //     imageUrl: photos[index].image,
                                        //     width: THelperFunctions.screenwidth(),
                                        //     fit: BoxFit.cover,
                                        //     isNetworkImage: true,
                                        //     height:
                                        //         THelperFunctions.screenwidth() /
                                        //             2),
                                      ],
                                    ),
                                  ));
                        }),
                    const SizedBox(
                      height: TSizes.spaceBtWsections,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
