import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/features/shop/models/cart_item_model.dart';
import 'package:brothers_creative/features/shop/models/product_model.dart';
import 'package:brothers_creative/utils/dialog/reusable_alert_dialog.dart';
import 'package:brothers_creative/utils/loader/loaders.dart';
import 'package:brothers_creative/utils/storage/storage_utility.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();
  RxInt numOfCartItems = 0.obs;
  RxDouble totalOfCartPrice = 0.0.obs;
  RxInt productQuantityinCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  //bool dark = THelperFunctions.isDarkMode(Get.context!);
  CartController() {
    if (!AuthenticationRepository.instance.isGust.value) loadCartItem();
  }

  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    final price = product.salePrice > 0.0 ? product.salePrice : product.price;
    return CartItemModel(
      productId: product.id,
      product: product,
      quantity: quantity,
      title: product.title,
      price: price,
      image: product.thumbnail,
      brandName: product.brand != null ? product.brand!.name : '',
    );
  }

  ProductModel convertToProductModel(CartItemModel item, int quantity) {
    // ProductController.instance.get
    return ProductModel(
      id: item.productId,
      title: item.title,
      price: item.price,
      thumbnail: item.image ?? '',
      arabicTitle: '',
      productType: '',
      stock: 10, //need to bring from database
    );
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) => cartItem.productId == item.productId,
    );
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) => cartItem.productId == item.productId,
    );

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index) {
    ReusableAlertDialog.show(
      context: Get.context!,
      title: 'Remove Product',
      content: 'Are you Sure you want to remove this item?',
      onConfirm: () async {
        cartItems.removeAt(index);
        updateCart();
        Get.back();
      },
    );

    // Get.defaultDialog(
    //     backgroundColor: THelperFunctions.isDarkMode(Get.context!)
    //         ? TColors.dark
    //         : TColors.light,
    //     title: 'Remove Product',
    //     middleText: 'Are you Sure you want to remove this item?',
    //     onConfirm: () {
    //       cartItems.removeAt(index);
    //       updateCart();
    //       Get.back();

    //     },
    //     onCancel: () => Get.back());
  }

  void addToCart(ProductModel product) {
    if (productQuantityinCart.value < 1) {
      removeOneFromCart(
        convertToCartItem(product, productQuantityinCart.value),
      );
      // TLoader.warningSnackBar(
      //     title: 'warrning',
      //     message: AppLocalizations.of(Get.context!)!.pleaseSelectQuantity);
      return;
    } else if (product.stock < productQuantityinCart.value) {
      TLoader.warningSnackBar(
        title: 'warrning',
        message: 'Selected Product is out of stock',
      );
      return;
    }
    final selectedCartItem = convertToCartItem(
      product,
      productQuantityinCart.value,
    );

    ///Check if already added on cart

    int index = cartItems.indexWhere(
      (cartItem) => cartItem.productId == selectedCartItem.productId,
    );
    if (index >= 0) {
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }
    updateCart();
    // TLoader.successSnackBar(
    //   title: AppLocalizations.of(Get.context!)!.info,
    //   message: AppLocalizations.of(Get.context!)!.successfullyAddedToCart,
    // );
  }

  void updateCart() {
    updateTotal();
    saveCartItems();
    cartItems.refresh();
  }

  void updateTotal() {
    double total = 0.0;
    int calculatedItem = 0;
    for (var item in cartItems) {
      total += (item.price) * item.quantity.toDouble();
      calculatedItem += item.quantity;
    }
    totalOfCartPrice.value = total;
    numOfCartItems.value = calculatedItem;
  }

  void saveCartItems() {
    final cartItemsStrings =
        cartItems.map((element) => element.toJason()).toList();
    TLocalStorage.instance().writeData('cartItem', cartItemsStrings);
  }

  void loadCartItem() {
    final cartItemStrings = TLocalStorage.instance().readData<List<dynamic>>(
      'cartItem',
    );
    if (cartItemStrings != null) {
      cartItems.assignAll(
        cartItemStrings.map(
          (e) => CartItemModel.fromJason(e as Map<String, dynamic>),
        ),
      );
      updateTotal();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((p0) => p0.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  void clearCart() {
    productQuantityinCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  void updateAlreadyAddedProductCount(ProductModel product) {
    productQuantityinCart.value = getProductQuantityInCart(product.id);
  }
}
