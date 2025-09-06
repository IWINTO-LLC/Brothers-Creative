import 'package:brothers_creative/common/widgets/success_screen/success_screen.dart';
import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/data/repositoies/order/order_repository.dart';
import 'package:brothers_creative/features/shop/controllers/address_controller.dart';
import 'package:brothers_creative/features/shop/controllers/product/cart_controller.dart';
import 'package:brothers_creative/features/shop/controllers/product/checkout_controller.dart';
import 'package:brothers_creative/features/shop/models/order_model.dart';
import 'package:brothers_creative/navigation_menu.dart';
import 'package:brothers_creative/utils/constants/enums.dart';
import 'package:brothers_creative/utils/constants/image_strings.dart';
import 'package:brothers_creative/utils/loader/loaders.dart';
import 'package:brothers_creative/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  final addressController = Get.put(AddressController());
  final checkoutController = Get.put(CheckoutController());
  final orderRepository = Get.put(OrderRepository());

  // RxInt numOfCartItems = 0.obs;
  // RxDouble totalOfCartPrice = 0.0.obs;
  // RxInt productQuantityinCart = 0.obs;
  // RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

// if (AuthenticationRepository.instance.isGust.value)

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrder = await orderRepository.fetchUserOrders();
      return userOrder;
    } catch (e) {
      TLoader.erroreSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    TFullScreenLoader.openloadingDialog(
        'Processing your order', TImages.proccessLottie);
    //const userId = 'EyTbtgIxRwamzlhsPnSs4lehlcc2';

    final userId = AuthenticationRepository.instance.authUser!.uid;
    // if (userId.isEmpty) return;
    final order = OrderModel(
      id: UniqueKey().toString(),
      userId: userId,
      status: OrderStatus.pinding,
      totalAmount: totalAmount,
      orderDate: DateTime.now(),
      paymentMethod: checkoutController.selectedPaymentMethode.value.name,
      address: addressController.selectedAddress.value,
      deliveryDate: DateTime.now(),
      items: cartController.cartItems.toList(),
    );
    await orderRepository.saveOrder(order, userId);
    cartController.clearCart();
    Get.off(() => SuccessScreen(
          image: TImages.paySuccess,
          title: AppLocalizations.of(Get.context!)!.paymentSuccessfull,
          subTitle:
              AppLocalizations.of(Get.context!)!.yourItemWillBeShippingSoon,
          onPressed: () => Get.to(() => const NavigationMenu()),
        ));
  }
}
