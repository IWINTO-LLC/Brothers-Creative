import 'package:brothers_creative/features/gallery/screen/gallery.dart';
import 'package:brothers_creative/features/shop/screens/home/home.dart';
import 'package:brothers_creative/features/shop/screens/orders/widgets/order.dart';
import 'package:brothers_creative/features/shop/screens/store/store.dart';
import 'package:brothers_creative/features/shop/screens/wishlist/wishlist.dart';
import 'package:brothers_creative/routes/routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.store, page: () => const StoreScreen()),
    GetPage(name: TRoutes.gallery, page: () => const TGalleryScreen()),
    GetPage(name: TRoutes.order, page: () => const OrderScreen()),
    GetPage(name: TRoutes.favorites, page: () => const FavoriteScreen()),
  ];
}
