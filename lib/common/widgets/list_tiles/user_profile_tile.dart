import 'package:brothers_creative/common/widgets/shimmers/shimmer.dart';
import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/features/authontication/screens/register/register.dart';
import 'package:brothers_creative/features/personlization/controllers/user_controller.dart';
import 'package:brothers_creative/features/personlization/screens/profile/profile.dart';
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    var iconColor =
        THelperFunctions.isDarkMode(context) ? TColors.white : TColors.black;
    return ListTile(
      leading: Obx(() {
        final networkImage = controller.user.value.profilePicture;
        final image =
            networkImage.isNotEmpty ? networkImage : TImages.userImage;
        return controller.imageUploading.value
            ? TShimmerEffect(
              width: 80,
              height: 80,
              raduis: BorderRadius.circular(80),
            )
            : networkImage.isNotEmpty
            ? GestureDetector(
              onTap: () => Get.to(() => const ProfileScreen()),
              child: CircleAvatar(
                backgroundImage: NetworkImage(image),
                radius: MediaQuery.of(context).size.height * 0.05,
              ),
            )
            : CircleAvatar(
              backgroundImage: AssetImage(image),
              radius: MediaQuery.of(context).size.height * 0.05,
            )
        // TCircularImage(
        //     image: image,
        //     fit: BoxFit.contain,
        //     isNetworkImage: networkImage.isNotEmpty,
        //     width: 50,
        //     height: 50,
        //   )
        ;
      }),
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(context).textTheme.headlineSmall!,
      ),
      subtitle: Text(
        controller.user.value.email ?? 'Gust',
        style: Theme.of(context).textTheme.bodyMedium!,
      ),
      trailing:
          AuthenticationRepository.instance.isGust.value
              ? IconButton(
                icon: Icon(Iconsax.login, color: iconColor),
                //onPressed: () => Get.to(() => const ProfileScreen()),
                onPressed:
                    () => Get.to(
                      () => const RegisterScreen(),
                    ), // RegisterScreen()),
              )
              : IconButton(
                icon: Icon(Iconsax.edit, color: iconColor),
                //onPressed: () => Get.to(() => const ProfileScreen()),
                onPressed:
                    () => Get.to(
                      () => const ProfileScreen(),
                    ), // RegisterScreen()),
              ),
    );
  }
}
