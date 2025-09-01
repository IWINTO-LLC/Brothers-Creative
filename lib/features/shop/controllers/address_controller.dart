import 'package:brothers_creative/common/widgets/texts/section_heading.dart';
import 'package:brothers_creative/data/repositoies/address/address_repository.dart';
import 'package:brothers_creative/features/authontication/controllers/network_manager.dart';
import 'package:brothers_creative/features/personlization/screens/address/add_new_address.dart';
import 'package:brothers_creative/features/personlization/screens/address/widgets/single_address.dart';
import 'package:brothers_creative/features/shop/models/address_model.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:brothers_creative/utils/helpers/cloud_helper_function.dart';
import 'package:brothers_creative/utils/loader/loaders.dart';
import 'package:brothers_creative/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final country = TextEditingController();
  final details = TextEditingController();
  RxString currentAddress = ''.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxBool useCurrentLocation = false.obs;

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  Future<void> updateAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude.value,
        longitude.value,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        currentAddress.value =
            '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
      }
    } catch (e) {
      currentAddress.value = 'تعذر تحديد العنوان';
    }
  }

  Future<void> setCurrentLocation() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever)
      return;

    final position = await Geolocator.getCurrentPosition();
    latitude.value = position.latitude;
    longitude.value = position.longitude;
    await updateAddressFromCoordinates();
  }

  // final isLoading = false.obs;
  final addressRepository = Get.put(AddressRepository());
  Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  RxBool refreshData = true.obs;
  // RxList<CategoryModel> featureCategories = <CategoryModel>[].obs;

  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await AddressRepository.instance.fetchUserAddress();
      selectedAddress.value = addresses.firstWhere(
        (element) => element.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      return addresses;
    } catch (e) {
      TLoader.erroreSnackBar(title: 'address not found', message: e.toString());

      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedAddress(
          selectedAddress.value.id,
          false,
        );
      }
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;
      await addressRepository.updateSelectedAddress(
        selectedAddress.value.id,
        true,
      );
    } catch (e) {
      TLoader.erroreSnackBar(
        title: 'error in selection ',
        message: e.toString(),
      );
    }
  }

  Future addNewAddress() async {
    try {
      //start loading
      TFullScreenLoader.openloadingDialog(
        AppLocalizations.of(Get.context!)!.storingAddress,
        TImages.proccessLottie,
      );

      // check the internet connectivity

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // form validations
      if (!addressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // save address data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        country: country.text.trim(),
        postalCode: postalCode.text.trim(),
        details: details.text.trim(),
        latitude: latitude.value,
        longitude: longitude.value,
        selectedAddress: true,
      );

      final id = await addressRepository.addAddress(address);

      //update selected address status
      address.id = id;
      await selectAddress(address);

      //remove loader
      TFullScreenLoader.stopLoading();

      //show success message

      // TLoader.successSnackBar(
      //     title: AppLocalizations.of(Get.context!)!.congratulation,
      //     message: AppLocalizations.of(Get.context!)!.saveAddressMessage);

      refreshData.toggle();
      resetFormField();
      // redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.erroreSnackBar(title: 'error', message: e.toString());
    }
  }

  void resetFormField() {
    name.clear();
    phoneNumber.clear();
    postalCode.clear();
    street.clear();
    city.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      //isScrollControlled: true,
      context: context,
      builder:
          (_) => SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(TSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TSectionHeading(
                    showActionButton: false,
                    title: AppLocalizations.of(context)!.selectAddress,
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  FutureBuilder(
                    future: getAllUserAddresses(),
                    builder: (_, snapshot) {
                      final response =
                          TCloudHelperFunctions.checkMuiltiRecordState(
                            snapshot: snapshot,
                          );
                      if (response != null) return response;

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder:
                            (_, index) => TSingleAddress(
                              address: snapshot.data![index],
                              onTap: () async {
                                await selectAddress(snapshot.data![index]);
                                Get.back();
                              },
                            ),
                      );
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        // left: 20,
                        // right: 20,
                        // horizontal: THelperFunctions.screenwidth() / 5,
                        bottom: 32,
                      ),
                      child: ElevatedButton(
                        onPressed:
                            () => Get.to(() => const AddNewAddressScreen()),
                        child: Text(
                          AppLocalizations.of(context)!.addNewAddress,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
