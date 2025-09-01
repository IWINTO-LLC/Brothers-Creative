import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();
  final Connectivity _connectivity = Connectivity();


  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  final Rx<ConnectivityResult> _connectivityStatus =
      ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();

    // تأخير فحص الاتصال حتى يتم تحميل التطبيق
    Future.delayed(const Duration(seconds: 2), () {
      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen(_handleConnectivityChange);

      _connectivity.checkConnectivity().then((results) {
        // results = List<ConnectivityResult>
        if (results.contains(ConnectivityResult.none)) {
          _updateConnectionStatus(ConnectivityResult.none);
        } else {
          _updateConnectionStatus(results.first);
        }
      });
    });
  }

  Future<bool> isConnected() async {
    try {
      final results = await _connectivity.checkConnectivity();
      return !results.contains(ConnectivityResult.none);
    } on PlatformException catch (_) {
      return false;
    }
  }

 
  void _handleConnectivityChange(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.none)) {
      _updateConnectionStatus(ConnectivityResult.none);
    } else {
      _updateConnectionStatus(results.first);
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    _connectivityStatus.value = result;

    // تجنب عرض رسائل عند بدء التطبيق
    if (result == ConnectivityResult.none) {
      // لا نعرض رسائل خطأ عند بدء التطبيق
      if (kDebugMode) {
        print('No internet connection');
      }
    } else {
      // لا نعرض رسائل نجاح عند بدء التطبيق
      if (kDebugMode) {
        print('Internet connection restored');
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    try {
      _connectivitySubscription?.cancel();
    } catch (e) {
    
      if (kDebugMode) {
        print('Error canceling subscription: $e');
      }
    }
  }
}
