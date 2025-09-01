// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/devices/device_utility.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
    this.showBorder = false,
    this.showBackground = true,
    this.onTap,
    this.onSearchTap,
    this.isSearchField = false,
    this.onChanged,
    this.controller,
    this.isSearchButton = false,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder, isSearchField, isSearchButton;
  final VoidCallback? onTap;
  final VoidCallback? onSearchTap;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    // إذا كان حقل بحث حقيقي
    if (isSearchField) {
      return Padding(
        padding: padding,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: text,
            prefixIcon: Icon(icon, color: dark ? TColors.white : TColors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
              borderSide:
                  showBorder
                      ? const BorderSide(color: Colors.grey)
                      : BorderSide.none,
            ),
            filled: showBackground,
            fillColor:
                showBackground
                    ? (dark ? TColors.darkGrey : TColors.white)
                    : Colors.transparent,
            contentPadding: const EdgeInsets.all(TSizes.md),
          ),
        ),
      );
    }

    // إذا كان زر بحث (يظهر صفحة البحث عند الضغط)
    if (isSearchButton) {
      return GestureDetector(
        onTap: onSearchTap ?? onTap,
        child: Padding(
          padding: padding,
          child: Container(
            width: TDeviceUtils.getScreenWidth(context),
            padding: const EdgeInsets.all(TSizes.md),
            decoration: BoxDecoration(
              color:
                  showBackground
                      ? (dark ? TColors.darkGrey : TColors.white)
                      : Colors.transparent,
              border: showBorder ? Border.all(color: Colors.grey) : null,
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            ),
            child: Row(
              children: [
                Icon(icon, color: dark ? Colors.white : TColors.black),
                const SizedBox(width: TSizes.spaceBtWItems),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodySmall!.apply(
                    color: dark ? Colors.grey : Colors.grey,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: dark ? TColors.darkerGray : TColors.darkGrey,
                ),
              ],
            ),
          ),
        ),
      );
    }

    // الحالة الافتراضية (زر عادي)
    return GestureDetector(
      onTap: onSearchTap ?? onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: TDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color: TColors.white,
            border: showBorder ? Border.all(color: Colors.grey) : null,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          ),
          child: Row(
            children: [
              Icon(icon, color: dark ? TColors.black : TColors.black),
              const SizedBox(width: TSizes.spaceBtWItems),
              Text(
                text,
                style: Theme.of(context).textTheme.bodySmall!.apply(
                  color: dark ? TColors.black : TColors.darkGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
