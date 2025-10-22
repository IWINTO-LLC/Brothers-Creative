import 'package:brothers_creative/features/authontication/controllers/login/login_controller.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/icons_string.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/devices/device_utility.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TSocialButtons extends StatelessWidget {
  const TSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    bool dark = THelperFunctions.isDarkMode(context);
    final iconback = dark ? TColors.white : Colors.black;
    final iconColor = dark ? Colors.black : TColors.white;
    final apple = TDeviceUtils.isIos();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Visibility(
        //   visible: false,
        //   child: Container(
        //     width: 100,
        //     height: 50,
        //     decoration: BoxDecoration(
        //         color: iconback,
        //         border: Border.all(color: iconColor),
        //         borderRadius: BorderRadius.circular(10)),
        //     child: Padding(
        //       padding: const EdgeInsets.all(2.0),
        //       child: InkWell(
        //         onTap: () {},
        //         child: SvgPicture.asset(
        //           TIcons.appleIcon,
        //           colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        Visibility(
          visible: apple,
          child: Container(
            width: 130,
            height: 50,
            decoration: BoxDecoration(
              color: iconback,
              border: Border.all(color: iconColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => controller.appleSignIn(),
                    child: SvgPicture.asset(
                      width: 35,
                      height: 35,
                      TIcons.appleIcon,
                      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Apple",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: iconColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: apple,
          child: const SizedBox(width: TSizes.spaceBtWItems),
        ),
        GestureDetector(
          onTap: () => controller.googleSignIn(),
          child: Container(
            width: 130,
            height: 50,
            decoration: BoxDecoration(
              color: iconback,
              border: Border.all(color: iconColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    width: 30,
                    height: 30,
                    TIcons.gmailIcon,

                    //  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Google",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: iconColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        // const SizedBox(width: TSizes.spaceBtWItems),
        // Container(
        //   width: 50,
        //   height: 50,
        //   decoration: BoxDecoration(
        //       border: Border.all(color: iconColor),
        //       borderRadius: BorderRadius.circular(100)),
        //   child: Padding(
        //     padding: const EdgeInsets.all(10.0),
        //     child: InkWell(
        //       onTap: () {},
        //       child: SvgPicture.asset(
        //         TIcons.facebookIcon,
        //         colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
