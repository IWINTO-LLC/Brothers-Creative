// import 'package:brothers_creative/utils/constants/image_strings.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
// import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
// import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
// import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
// import 'package:flutter_paytabs_bridge/PaymentSdkTransactionClass.dart';
// import 'package:flutter_paytabs_bridge/PaymentSdkTransactionType.dart';
// import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
// import 'package:get/get.dart';
//
// //merchantId:57202
// class PayTabsController extends GetxController {
//   static PayTabsController get instance => Get.find();
//   final serverKey = "";
//
//   var billingDetails = BillingDetails("billing name", "billing email",
//       "billing phone", "address line", "country", "city", "state", "zip code");
//
//   // var shippingDetails = ShippingDetails("shipping name", "shipping email",
//   //     "shipping phone", "address line", "country", "city", "state", "zip code");
//
//   var configuration = PaymentSdkConfigurationDetails(
//     profileId: "110145", //110145
//     showShippingInfo: false,
//     iOSThemeConfigurations: IOSThemeConfigurations(),
//     forceShippingInfo: false,
//     serverKey: "SMJNHZG26Z-JKNZ2NMDBK-JTZW2WDT6B",
//     clientKey: "CHKM96-BD7B6K-Q9MQND-9TDBHB",
//     cartId: "test111orderid",
//     transactionType: PaymentSdkTransactionType.SALE,
//     transactionClass: PaymentSdkTransactionClass.ECOM,
//     cartDescription: "cart description it is about the products or project",
//     merchantName: "Brothers Creative",
//     screentTitle: "Pay with Card",
//     locale:
//         PaymentSdkLocale.EN, //PaymentSdkLocale.AR or PaymentSdkLocale.DEFAULT
//     amount: 0.002,
//     currencyCode: "SAR",
//     merchantCountryCode: "SA",
//     showBillingInfo: true,
//     billingDetails: BillingDetails("walaa Elsaeed", "walaa@gmail.com", "",
//         "address line", "SA", "city", "state", "213"),
//   );
//
//   var theme = IOSThemeConfigurations();
//
//   void startPayment() {
//     FlutterPaytabsBridge.startCardPayment(configuration, (event) {
//       var theme = IOSThemeConfigurations();
//       theme.logoImage = TImages.wordBlack;
//       configuration.iOSThemeConfigurations = theme;
//       Obx(() {
//         if (event["status"] == "success") {
//           // Handle transaction details here.
//           var transactionDetails = event["data"];
//           if (kDebugMode) {
//             print(transactionDetails);
//           }
//
//           if (transactionDetails["isSuccess"]) {
//             if (kDebugMode) {
//               print("successful transaction");
//             }
//           } else {
//             if (kDebugMode) {
//               print("failed transaction");
//             }
//           }
//         } else if (event["status"] == "error") {
//           // Handle error here.
//         } else if (event["status"] == "event") {
//           // Handle cancel events here.
//         }
//         return SizedBox();
//       });
//     });
//   }
//
//   void cancelPayment() {
//     FlutterPaytabsBridge.cancelPayment((_) {});
//   }
// }
