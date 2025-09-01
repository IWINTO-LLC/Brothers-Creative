import 'package:flutter/material.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:get/get.dart';
class TCloudHelperFunctions {
  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data == null) {
      return Center(
        child: Text(
          AppLocalizations.of(Get.context!)!.noData,
          style: Theme.of(Get.context!).textTheme.bodyMedium,
        ),
      );
    }
    if (snapshot.hasError) {
      return Center(
        child: Text(
          AppLocalizations.of(Get.context!)!.somethingWentWrong,
          style: Theme.of(Get.context!).textTheme.bodyMedium,
        ),
      );
    }
    return null;
  }

  static Widget? checkMuiltiRecordState<T>({
    required AsyncSnapshot<List<T>> snapshot,
    Widget? loader,
    Widget? error,
    Widget? nothingFound,
  }) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;

      return const Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      if (nothingFound != null) return nothingFound;
      return const SizedBox();
      // Center(
      //   child: Text(
      //     AppLocalizations.of(Get.context!)!.noData,
      //     style: Theme.of(Get.context!).textTheme.bodyMedium,
      //   ),
      // );
    }
    if (snapshot.hasError) {
      if (error != null) return error;
      return Center(
        child: Text(
          AppLocalizations.of(Get.context!)!.somethingWentWrong,
          style: Theme.of(Get.context!).textTheme.bodyMedium,
        ),
      );
    }
    return null;
  }

  // static Future<String> getUrlFromFilePathAndName(String path) async {
  //   try {
  //     if (path.isEmpty) return '';
  //     final ref = FirebaseStorage.instans.ref().child(path);
  //   } catch (e) {
  //     throw 'Some thing went wrong in file path image';
  //   }
  // }
}
