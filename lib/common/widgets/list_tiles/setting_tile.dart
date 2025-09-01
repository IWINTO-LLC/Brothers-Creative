import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/features/shop/controllers/product/later_list_controller.dart';
import 'package:brothers_creative/features/shop/screens/later_list/laterlist.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSettingTile extends StatelessWidget {
  const TSettingTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final controller = UserController.instance;
    return SizedBox(
        height: 130,
        child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              StaticsItem(
                icon: Iconsax.buildings_2,
                text: "",
                number: '12',
              ),
              StaticsItem(
                icon: Iconsax.book,
                text: AppLocalizations.of(context)!.myOrders,
                number: '6',
              ),
              StaticsItem(
                icon: Iconsax.discount_shape,
                text: AppLocalizations.of(context)!.priceRequest,
                number: '5',
              ),
              GestureDetector(
                onTap: () => Get.to(() => const LaterListScreen()),
                child: StaticsItem(
                  icon: Icons.save,
                  text: AppLocalizations.of(context)!.laterList,
                  number:
                      LaterListController.instance.laterList.length.toString(),
                ),
              )
            ]));
  }
}

class StaticsItem extends StatelessWidget {
  const StaticsItem({
    super.key,
    required this.text,
    required this.number,
    required this.icon,
  });
  final String text;
  final String number;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TRoundedContainer(
        enableShadow: true,
        backgroundColor:
            THelperFunctions.isDarkMode(context) ? TColors.dark : TColors.light,
        width: 110,
        radius: BorderRadius.circular(20),
        //showBorder: true,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  icon,
                  size: 40,
                  color: TColors.primary,
                ),
              ),
              Text(number),
              Text(
                text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
