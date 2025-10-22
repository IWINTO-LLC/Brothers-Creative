// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brothers_creative/api/frebase_api.dart';
import 'package:brothers_creative/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:brothers_creative/common/widgets/images/rounded_image.dart';
import 'package:brothers_creative/navigation_menu.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = FirebaseApiController.instance.currentMessage;
    final message = MessageModel.fromJson(argument.data);
    final dark = THelperFunctions.isDarkMode(context);
    //final isEg = Get.locale?.languageCode == 'en';
    //final controller = BrandController.instance;
    return Directionality(
      textDirection:
          Get.locale?.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: Scaffold(
        appBar: TAppBar(
          onbackPress: () => Get.to(() => const NavigationMenu()),
          title: Text(
            AppLocalizations.of(context)!.notifications,
            //style: Theme.of(context).textTheme.headlineMedium,
          ),
          showBackArrow: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const NavigationMenu());
                },
                child: TRoundedContainer(
                  width: double.infinity,
                  showBorder: true,
                  padding: const EdgeInsets.all(TSizes.md),
                  backgroundColor: dark ? TColors.dark : TColors.light,
                  child: Column(
                    children: [
                      Text(
                        '${argument.notification?.title}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      Text(
                        '${argument.notification?.body}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(message.title),

                      // Text('value: ${message.value}'),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      Text(message.text),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TRoundedImage(
                        borderRaduis: BorderRadius.circular(20),
                        imageUrl: message.image,
                        isNetworkImage: true,
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MessageModel {
  String image;
  String text;
  String title;
  String value;
  MessageModel({
    required this.image,
    required this.text,
    required this.title,
    required this.value,
  });

  static MessageModel empty() =>
      MessageModel(image: '', text: '', title: '', value: '');

  factory MessageModel.fromJson(Map<String, dynamic> data) {
    return MessageModel(
      text: data['text'],
      image: data['image'] ?? '',
      title: data['title'] ?? '',
      value: data['value'] ?? '',
    );
  }
}
