// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:brothers_creative/features/shop/models/address_model.dart';
import 'package:brothers_creative/features/shop/models/cart_item_model.dart';
import 'package:brothers_creative/utils/constants/enums.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:brothers_creative/l10n/app_localizations.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;

  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = 'Stripe',
    this.address,
    this.deliveryDate,
  });

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);
  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  ///  "deliverd":"تم التوصيل",
  ///"shipmentInWay":"قيد الشحن",
  ///"processing":"قيد المعالجة"
  String get orderStatusText => status == OrderStatus.delivered
      ? AppLocalizations.of(Get.context!)!.deliverd
      : status == OrderStatus.shipping
          ? AppLocalizations.of(Get.context!)!.shipmentInWay
          : AppLocalizations.of(Get.context!)!.processing;

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "UserId": userId,
      "Status": status.toString(),
      "TotalAmount": totalAmount,
      "OrderDate": orderDate,
      "PaymentMethod": paymentMethod,
      "Address": address?.toJson(),
      "DeliveryDate": deliveryDate,
      'Items': items.map((e) => e.toJason()).toList()
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return OrderModel(
      id: data['Id'] as String,
      userId: data['UserId'] as String,
      status: OrderStatus.values
          .firstWhere((element) => element.toString() == data['Status']),
      totalAmount: data['TotalAmount'] as double,
      orderDate: (data['OrderDate'] as Timestamp).toDate(),
      paymentMethod: data['PaymentMethod'] as String,
      address: AddressModel.fromMap(data['Address'] as Map<String, dynamic>),
      deliveryDate: data['DeliveryDate'] == null
          ? null
          : (data['DeliveryDate'] as Timestamp).toDate(),
      items: (data['Items'] as List<dynamic>)
          .map((itemData) =>
              CartItemModel.fromJason(itemData as Map<String, dynamic>))
          .toList(),
    );
  }
}
