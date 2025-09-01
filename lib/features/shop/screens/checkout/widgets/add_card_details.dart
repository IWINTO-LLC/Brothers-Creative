import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardDetails extends StatefulWidget {
  const AddCardDetails({super.key});

  Widget build(BuildContext context) {
    //  final controller = PayTabsController.instance;
    return Directionality(
      textDirection:
          Get.locale?.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            'card info',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                // controller.startPayment();
              },
              child: Text(
                'try pay',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color:
                      THelperFunctions.isDarkMode(context)
                          ? Colors.black
                          : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
