// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/devices/device_utility.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.centerTitle = false,
    this.leadingOnPress,
    this.onbackPress,
  });

  final Widget? title;
  final bool showBackArrow;
  final bool? centerTitle;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPress;
  final VoidCallback? onbackPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.md,
        vertical: TSizes.xs,
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        //backgroundColor: TColors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              THelperFunctions.isDarkMode(context)
                  ? Brightness.light
                  : Brightness.dark,
          statusBarBrightness:
              THelperFunctions.isDarkMode(context)
                  ? Brightness.dark
                  : Brightness.light,
        ),
        leading:
            showBackArrow
                ? IconButton(
                  onPressed: onbackPress ?? () => Get.back(),
                  icon: Icon(
                    Get.locale?.languageCode == 'en'
                        ? Icons.keyboard_arrow_left
                        : Icons.keyboard_arrow_right,
                    size: 30,
                  ),
                )
                : leadingIcon != null
                ? IconButton(
                  onPressed: leadingOnPress,
                  icon: Icon(leadingIcon, color: Colors.white),
                )
                : null,
        title: title,
        titleTextStyle: Theme.of(context).textTheme.headlineSmall,
        centerTitle: centerTitle,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppbarHeight());
}
