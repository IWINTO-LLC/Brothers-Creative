import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key, required this.info, required this.title});
  final String title;
  final String info;
  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(UpdateNameController());
    return Directionality(
      textDirection: Get.locale?.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            title,
          ),
          showBackArrow: true,
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Center(
                      child: Text(info,
                          style: Theme.of(context).textTheme.headlineSmall)),
                  const SizedBox(
                    height: TSizes.spaceBtWsections,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
//////////////
