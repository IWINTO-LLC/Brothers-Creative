import 'package:brothers_creative/data/repositoies/clients/clients_repository.dart';
import 'package:brothers_creative/features/authontication/controllers/network_manager.dart';
import 'package:brothers_creative/features/shop/models/clients_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ClientController extends GetxController {
  static ClientController get instance => Get.find();

  final isLoading = false.obs;
  final _clientRepository = Get.put(ClientsRepository());
  RxList<ClientModel> allClients = <ClientModel>[].obs;
  RxList<ClientModel> featureClients = <ClientModel>[].obs;

  @override
  void onInit() {
    fetchAllClients();
    super.onInit();
  }

  Future<void> fetchAllClients() async {
    Get.put(NetworkManager());
    try {
      isLoading.value = true;
      final isConnected = NetworkManager.instance.isConnected();
      if (await isConnected) {
        if (kDebugMode) {
          print('connection internet is good');
        }
      } else {
        if (kDebugMode) {
          print("===========no internet=========");
        }
      }

      final clients = await _clientRepository.getAllClients();
      allClients.assignAll(clients);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      } // Get.snackbar('oh Snap!', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
