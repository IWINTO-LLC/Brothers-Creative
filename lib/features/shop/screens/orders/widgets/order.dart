import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/features/shop/screens/orders/widgets/order_item.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.locale?.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(AppLocalizations.of(context)!.myOrders,
              style: Theme.of(context).textTheme.headlineSmall),
          showBackArrow: true,
        ),
        body: SafeArea(
          child: const Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: TOrderListItem(),
          ),
        ),
      ),
    );
  }
}
