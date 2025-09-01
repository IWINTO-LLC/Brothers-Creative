import 'package:brothers_creative/common/widgets/shimmers/shimmer.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomCaChedNetworkImage extends StatelessWidget {
  const CustomCaChedNetworkImage({
    super.key,
    required this.width,
    required this.height,
    required this.url,
    this.enableShadow = true,
    this.enableborder = false,
    this.fit = BoxFit.fill,
    required this.raduis,
  });
  final double width;
  final double height;
  final bool enableShadow;
  final bool enableborder;
  final BorderRadius raduis;
  final String url;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    // Debug: طباعة معلومات الصورة
    if (kDebugMode) {
      print('🖼️ CustomCaChedNetworkImage Debug:');
      print('   URL: $url');
      print('   Width: $width');
      print('   Height: $height');
    }

    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) {
        if (kDebugMode) {
          print('   ✅ Image loaded successfully');
        }
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            boxShadow: enableShadow ? TColors.tboxShadow : null,
            borderRadius: raduis,
            border:
                enableborder ? Border.all(color: TColors.borderPrimary) : null,
            color: TColors.light,
            image: DecorationImage(image: imageProvider, fit: fit),
          ),
        );
      },
      progressIndicatorBuilder: (context, url, downloadProgress) {
        if (kDebugMode) {
          final progress = downloadProgress.progress ?? 0.0;
          print('   📥 Loading image: ${(progress * 100).toStringAsFixed(1)}%');
        }
        return TShimmerEffect(width: width, height: height, raduis: raduis);
      },
      errorWidget: (context, url, error) {
        return Container(
          width: width,
          height: height,

          decoration: BoxDecoration(borderRadius: raduis),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: raduis,
              child: Image(
                image: AssetImage('assets/logos/1.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}
