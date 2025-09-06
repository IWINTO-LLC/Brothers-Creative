import 'package:brothers_creative/features/shop/controllers/map_controller.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

class MapScreen extends StatelessWidget {
  final Function(double lat, double lng) onLocationSelected;

  const MapScreen({super.key, required this.onLocationSelected});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TMapController());

    return Scaffold(
      appBar: AppBar(title: const Text('اختر موقعك')),
      body: SafeArea(
        child: Stack(
          children: [
            Obx(
              () => FlutterMap(
                options: MapOptions(
                  initialCenter: controller.selectedLocation.value,
                  maxZoom: 15,
                  onTap: (tapPosition, point) {
                    controller.selectedLocation.value = point;
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: controller.selectedLocation.value,
                        width: 50,
                        height: 50,
                        child: const Icon(
                          Icons.location_pin,
                          size: 40,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 50,
              right: 50,
              child: ElevatedButton(
                onPressed: () {
                  final loc = controller.selectedLocation.value;
                  onLocationSelected(loc.latitude, loc.longitude);
                  Get.back();
                },
                child: Text(
                  'تأكيد العنوان',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color:
                        THelperFunctions.isDarkMode(context)
                            ? Colors.black
                            : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
