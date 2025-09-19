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
    body: SafeArea(
      child: PhotoViewGallery.builder(
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
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
    ),
  );
}
