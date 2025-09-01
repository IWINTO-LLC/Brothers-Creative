import 'package:brothers_creative/common/widgets/success_screen/success_screen.dart';
import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/navigation_menu.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  static OtpController get instance => Get.find();

  void verifyOtp(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOtp(otp);
    isVerified
        ? Get.offAll(SuccessScreen(
            subTitle: AppLocalizations.of(Get.context!)!.congratulation,
            title: "Your phone verified successfully",
            image: TImages.successfullLottie,
            onPressed: () => Get.offAll(() => const NavigationMenu()),
          ))
        : Get.back();
  }
}
