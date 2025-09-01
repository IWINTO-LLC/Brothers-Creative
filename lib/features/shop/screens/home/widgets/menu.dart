import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TMenuItem extends StatelessWidget {
  const TMenuItem(
      {super.key, this.route = '', required this.icon, required this.itemName});
  final String route;
  final String itemName;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    // final menuController = Get.put(SidebarController());
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
        child: Container(
          width: THelperFunctions.screenwidth() / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
            TSizes.cardRadiusMd,
          )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(TSizes.md),
                  child: Icon(
                    icon,
                    size: 22,
                    color: TColors.darkGrey,
                  )),
              Text(
                itemName,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: TColors.darkGrey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
