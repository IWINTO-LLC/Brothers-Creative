// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brothers_creative/common/widgets/icons/circuler_icon.dart';
import 'package:brothers_creative/features/shop/controllers/product/favorites_controller.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TFavoriteIcon extends StatelessWidget {
  const TFavoriteIcon({
    Key? key,
    required this.productId,
  }) : super(key: key);
  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());
    return Obx(() => TCircularIcon(
          backgroundColor: Colors.transparent,
          size: 25,
          icon: controller.isFavorites(productId)
              ? CupertinoIcons.heart_fill //Icons.favorite
              : CupertinoIcons.heart,
          color:
              controller.isFavorites(productId) ? TColors.error : Colors.black,
          onPressed: () => controller.toggleFavoriteProduct(productId),
        ));
  }
}
