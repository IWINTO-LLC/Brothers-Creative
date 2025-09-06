import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/features/shop/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      var userId = // 'EyTbtgIxRwamzlhsPnSs4lehlcc2';
          AuthenticationRepository.instance.authUser!.uid;
      // if (userId.isEmpty) {
      //   throw 'Unable to find user information. try again later';
      // }
      final result =
          await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw 'Something wrong while fetch order data';
    }
  }

  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
    } catch (e) {
      throw "Something wrong while saving Order data";
    }
  }

  ///clear the selected address for all addresses

  // Future<void> updateSelectedAddress(String addressId, bool selected) async {
  //   try {
  //     final userId = 'EyTbtgIxRwamzlhsPnSs4lehlcc2';
  //     //final userId = AuthenticationRepository.instance.authUser!.uid;
  //     await _db
  //         .collection('Users')
  //         .doc(userId)
  //         .collection('Addresses')
  //         .doc(addressId)
  //         .update({'SelectedAddress': selected});
  //   } catch (e) {
  //     throw 'wwwwwwwwwwwwwwrrrrrrrrrrrrrooooooooonnnnnnnnnnnggggggggg';
  //   }
  // }

  // Future<String> addAddress(AddressModel address) async {
  //   try {
  //     const userId = 'EyTbtgIxRwamzlhsPnSs4lehlcc2';
  //     // AuthenticationRepository.instance.authUser!.uid;
  //     final currentAddress = await _db
  //         .collection('Users')
  //         .doc(userId)
  //         .collection('Addresses')
  //         .add(address.toJson());
  //     if (kDebugMode) {
  //       print('currentAddress $currentAddress.id');
  //     }
  //     return currentAddress.id;
  //   } catch (e) {
  //     throw 'Some thing wrong while saving address';
  //   }
//  }
}
