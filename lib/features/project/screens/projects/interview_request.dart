import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterviewRequestScreen extends StatelessWidget {
  const InterviewRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          Get.locale?.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: Scaffold(
        appBar: const TAppBar(
          title: Text('Interview Request'),
          showBackArrow: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.title),
                        labelText: 'Interview Title',
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: 'Phone Number',
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email Address',
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    TextFormField(
                      maxLines: 3,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.description),
                        labelText: 'the purpose',
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    SizedBox(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Load Files',
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color:
                                THelperFunctions.isDarkMode(context)
                                    ? Colors.black
                                    : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    SizedBox(
                      width: THelperFunctions.screenwidth() * 0.6,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Send',
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color:
                                THelperFunctions.isDarkMode(context)
                                    ? Colors.black
                                    : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
