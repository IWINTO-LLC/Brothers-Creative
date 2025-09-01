import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/data/repositoies/project/project_repository.dart';
import 'package:brothers_creative/features/project/models/project_model.dart';
import 'package:brothers_creative/features/project/screens/projects/projects.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/loader/loaders.dart';
import 'package:brothers_creative/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProjectController extends GetxController {
  static ProjectController get instance => Get.find();
  final format = DateFormat("MM/dd/yyyy");
  final name = TextEditingController();
  final description = TextEditingController();
  final quantity = TextEditingController();
  final city = TextEditingController();
  final country = TextEditingController();
  final RxList projects = [].obs;
  //final pickedFile = Rx<PlatformFile>(PlatformFile);

  String? selectedValue;

  GlobalKey<FormState> projectFormKey = GlobalKey<FormState>();

  // final isLoading = false.obs;

  final projectRepository = Get.put(ProjectRepository());

  Future addNewProject() async {
    try {
      //start loading
      TFullScreenLoader.openloadingDialog(
        AppLocalizations.of(Get.context!)!.addProject,
        TImages.proccessLottie,
      );

      // form validations
      if (!projectFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // save address data
      final project = ProjectModel(
        id: UniqueKey().toString(),
        uId: //'w0xDf8Cau2aqJrcH8vaaRYASY4I2',
            AuthenticationRepository.instance.authUser?.uid,
        name: name.text.trim(),
        state: 'pending',
        quantity: quantity.text.trim(),
        description: description.text.trim(),
        city: city.text.trim(),
        country: country.text.trim(),
      );

      await projectRepository.addProject(project);

      //remove loader
      TFullScreenLoader.stopLoading();

      //show success message
      fetchUserProject();
      // TLoader.successSnackBar(
      //     title: AppLocalizations.of(Get.context!)!.congratulation,
      //     message: AppLocalizations.of(Get.context!)!.saveProjectMessage);

      //Refresh data

      //reset Field

      resetFormField();
      // redirect
      Get.to(const ProjectsScreen());
      //  Na\[-p0oi8u7y6t5r4q1  ` cgator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.erroreSnackBar(title: 'error', message: e.toString());
    }
  }

  Future<List<ProjectModel>> fetchUserProject() async {
    try {
      final projects = await projectRepository.fetchUserProjects();
      return projects;
    } catch (e) {
      TLoader.erroreSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void resetFormField() {
    name.clear();
    description.clear();
    city.clear();
    country.clear();
    projectFormKey.currentState?.reset();
  }
}
