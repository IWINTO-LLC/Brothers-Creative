import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryWidget extends StatefulWidget {
  final PageController pageController;
  final int index;
  final List<String> urlImage;
  GalleryWidget({super.key, required this.urlImage, this.index = 0})
      : pageController = PageController(initialPage: index);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  late int index = widget.index;
  @override
  Widget build(BuildContext context) => Scaffold(
          // bottomNavigationBar: Padding(
          //     padding: const EdgeInsets.symmetric(
          //         horizontal: TSizes.defaultSpace * 3,
          //         vertical: TSizes.defaultSpace),
          //     child: Row(
          //       children: [
          //         IconButton(onPressed: () {}, icon: const Icon(Iconsax.more))
          //       ],
          //     )),
          body: SafeArea(
        child: PhotoViewGallery.builder(
          backgroundDecoration:
              BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
          onPageChanged: (index) => setState(() => this.index = index),
          pageController: widget.pageController,
          itemCount: widget.urlImage.length,
          builder: (context, index) {
            final urlImage = widget.urlImage[index];

            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(urlImage),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.contained * 10,
            );
          },
        ),
      ));
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';

// class GalleryWidget extends StatelessWidget {
//   const GalleryWidget({
//     Key? key,
//     required this.urlImage,
//   }) : super(key: key);
//   final List<String> urlImage;
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: PhotoViewGallery.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: urlImage.length,
//             builder: (context, index) {
//               final imageUrl = urlImage[index];
//               return PhotoViewGalleryPageOptions(
//                 imageProvider: NetworkImage(imageUrl),
//                 minScale: PhotoViewComputedScale.contained,
//                 maxScale: PhotoViewComputedScale.contained * 4,
//               );
//             }),
//       );
// }
