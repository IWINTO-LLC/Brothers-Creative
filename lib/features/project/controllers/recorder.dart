import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';

class RecorderController extends GetxController {
  static RecorderController get instance => Get.find();

  @override
  void onInit() {
    initRecord();

    super.onInit();
  }

  String? title;

  ///
  String? subTitle;

  ///
  String? description;
  final recorder = FlutterSoundRecorder();
  Future stop() async {
    //String? path = await recorder.stopRecorder();
    //final audioFile = File(path!);
    //print("Record audio :$audioFile");
  }

  Future start() async {
    await recorder.startRecorder(toFile: 'audio');
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.microphone.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.microphone].request();
      return permissionStatus[Permission.microphone] ??
          PermissionStatus.permanentlyDenied;
    } else {
      return permission;
    }
  }

  Future<void> initRecord() async {
    final status = await _getPermission();
    if (status != PermissionStatus.granted) {
      throw 'Microphone not permissioned';
    }
    await recorder.openRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future record() async {
    await recorder.startRecorder(toFile: 'audio');
  }
}
