import 'package:brothers_creative/features/authontication/controllers.onboarding/onboarding_controller.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/onboarding_dot_navigation.dart';
import 'widgets/onboarding_next_button.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/onboarding_skip.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final screens = controller.allData;
    bool isEg = Get.locale?.languageCode == 'en';
    return Directionality(
      textDirection: isEg ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: FutureBuilder(
              future: controller.fetchAllData(),
              builder: (_, snapshot) {
                final response = TCloudHelperFunctions.checkMuiltiRecordState(
                    snapshot: snapshot);
                if (response != null) return response;

                return Stack(children: [
                  ///Horizontal scrolle pages
                  PageView.builder(
                    itemCount: screens.length,
                    controller: controller.pageController,
                    onPageChanged: controller.updatePageIndicator,

                    itemBuilder: (BuildContext context, int index) =>
                        OnBoardingPage(
                      image: screens[index].image == ''
                          ? TImages.bBlack
                          : screens[index].image,
                      title: screens[index].title == ''
                          ? AppLocalizations.of(context)!.onboardingTitle1
                          : isEg
                              ? screens[index].title
                              : screens[index].arabicTitle,
                      subTitle: screens[index].subTitle == ''
                          ? AppLocalizations.of(context)!.onboardingSubtitle1
                          : isEg
                              ? screens[index].subTitle
                              : screens[index].arabicSubtitle,
                    ),

                    // OnBoardingPage(
                    //   image:
                    //       screens[2].image == '' ? TImages.bBlack : screens[2].image,
                    //   title: AppLocalizations.of(context)!.onboardingTitle3,
                    //   subTitle: AppLocalizations.of(context)!.onboardingSubtitle3,
                    // )
                  ),

                  ///skip button
                  OnBoardingSkip(count: screens.length),

                  ///dot navigation indicator
                  OnBoardingDotNavigation(count: screens.length),

                  /// button circuler

                  const OnBoardingNextButton()
                ]);
              }),
        ),
      ),
    );
  }
}
