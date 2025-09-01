import 'package:brothers_creative/features/shop/models/clients_model.dart';
import 'package:brothers_creative/features/shop/screens/client_page.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TClientSlider extends StatelessWidget {
  const TClientSlider(
      {super.key, required this.items, required this.currentClient});
  final int currentClient;
  final List<ClientModel> items;
  @override
  Widget build(BuildContext context) {
    RxInt selectdindex = 0.obs;
    // void openGallery() => Navigator.of(context).push(MaterialPageRoute(
    //     builder: (_) => GalleryWidget(index: ,
    //           urlImage: product.images!,
    //         )));

    //final dark = THelperFunctions.isDarkMode(context);

    return CarouselSlider(
      options: CarouselOptions(
        onPageChanged: (index, _) => selectdindex.value = index,
        height: THelperFunctions.screenHeight(),
        viewportFraction: 1,
        initialPage: currentClient,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        // enlargeCenterPage: true,
      ),
      items: items
          .map((item) => ClientScreen(
                client: item,
              ))
          .toList(),
    );
  }
}
