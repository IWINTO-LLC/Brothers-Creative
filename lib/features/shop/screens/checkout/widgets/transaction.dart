// import 'dart:async';
// import 'dart:io' show Platform;

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
// import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
// import 'package:flutter_paytabs_bridge/PaymentSDKQueryConfiguration.dart';
// import 'package:flutter_paytabs_bridge/PaymentSDKSavedCardInfo.dart';
// import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
// import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
// import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
// import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
// import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
// import 'package:get/get.dart';
// import 'package:brothers_creative/l10n/app_localizations.dart';

// class Ttransaction extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<Ttransaction> {
//   String _instructions = 'Tap on "Pay" Button to test PayTabs';

//   @override
//   void initState() {
//     super.initState();
//   }

//   static const String billingName = "Nuwar Saeed";

//   /// Billing email for the payment configuration.
//   static const String billingEmail = "nuwar.m.saeed@gmail.com";

//   /// Billing phone number for the payment configuration.
//   static const String billingPhone = "+971503780091";

//   /// Billing address for the payment configuration.
//   static const String billingAddress =
//       "3017 Haroon Al Rashid Rd, Dareen St. 3017 ";

//   /// Billing country for the payment configuration.
//   static const String billingCountry = "Saudi Arabia";

//   /// Billing city for the payment configuration.
//   static const String billingCity = "Riyadh";

//   /// Billing state for the payment configuration.
//   static const String billingState = "SA";

//   /// Billing zip code for the payment configuration.
//   static const String billingZipCode = "12345";

//   PaymentSdkConfigurationDetails generateConfig() {
//     var billingDetails = BillingDetails(
//       billingName,
//       billingEmail,
//       billingPhone,
//       billingAddress,
//       billingCountry,
//       billingCity,
//       billingState,
//       billingZipCode,
//     );
//     var en = Get.locale?.languageCode == 'en'
//         ? PaymentSdkLocale.EN
//         : PaymentSdkLocale.AR;
//     List<PaymentSdkAPms> apms = [];
//     apms.add(PaymentSdkAPms.AMAN);
//     final configuration = PaymentSdkConfigurationDetails(
//       profileId: "110145", //110145
//       showShippingInfo: false,
//       iOSThemeConfigurations: IOSThemeConfigurations(),
//       forceShippingInfo: false,
//       serverKey: "SMJNHZG26Z-JKNZ2NMDBK-JTZW2WDT6B",
//       clientKey: "CHKM96-BD7B6K-Q9MQND-9TDBHB",
//       cartId: "test111orderid",
//       cartDescription: "cart description it is about the products or project",
//       merchantName: "Brothers Creative",
//       screentTitle: "Pay with Card",
//       //PaymentSdkLocale.AR or PaymentSdkLocale.DEFAULT
//       amount: 3.00,
//       currencyCode: "SAR",
//       merchantCountryCode: "SA",
//       showBillingInfo: true,
//       billingDetails: billingDetails,
//       alternativePaymentMethods: apms,
//       linkBillingNameWithCardHolderName: true,
//       locale: en,
//       // tokeniseType: PaymentSdkTokeniseType.MERCHANT_MANDATORY,
//       //tokenFormat: PaymentSdkTokenFormat.AlphaNum20Format
//     );
//     final theme = IOSThemeConfigurations();
//     configuration.iOSThemeConfigurations = theme;
//     configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
//     return configuration;
//   }

//   Future<void> payPressed() async {
//     try {
//       FlutterPaytabsBridge.startCardPayment(generateConfig(), (event) {
//         setState(() {
//           if (event["status"] == "success") {
//             // Handle transaction details here.
//             var transactionDetails = event["data"];
//             if (kDebugMode) {
//               print(transactionDetails);
//             }

//             if (transactionDetails["isSuccess"]) {
//               if (kDebugMode) {
//                 print("successful transaction");
//               }
//             } else {
//               if (kDebugMode) {
//                 print("failed transaction");
//               }
//             }
//           } else if (event["status"] == "error") {
//             // Handle error here.
//           } else if (event["status"] == "event") {
//             // Handle events here.
//           }
//         });
//       });
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//   }

//   Future<void> payWithTokenPressed() async {
//     FlutterPaytabsBridge.startTokenizedCardPayment(
//       generateConfig(),
//       "*TOKEN*",
//       "*TRANSACTION REFERENCE*",
//       (event) {
//         setState(() {
//           if (event["status"] == "success") {
//             // Handle transaction details here.
//             var transactionDetails = event["data"];
//             print(transactionDetails);
//             if (transactionDetails["isSuccess"]) {
//               print("successful transaction");
//               if (transactionDetails["isPending"]) {
//                 print("transaction pending");
//               }
//             } else {
//               print("failed transaction");
//             }
//           } else if (event["status"] == "error") {
//             print("Error occurred in transaction: ${event["message"]}");
//           } else if (event["status"] == "event") {
//             print("Event occurred: ${event["message"]}");
//           }
//         });
//       },
//     );
//   }

//   Future<void> payWith3ds() async {
//     FlutterPaytabsBridge.start3DSecureTokenizedCardPayment(
//         generateConfig(),
//         PaymentSDKSavedCardInfo("4111 11## #### 1111", "visa"),
//         "*Token*", (event) {
//       setState(() {
//         if (event["status"] == "success") {
//           // Handle transaction details here.
//           var transactionDetails = event["data"];
//           print(transactionDetails);
//           if (transactionDetails["isSuccess"]) {
//             print("successful transaction");
//             if (transactionDetails["isPending"]) {
//               print("transaction pending");
//             }
//           } else {
//             print("failed transaction");
//           }

//           // print(transactionDetails["isSuccess"]);
//         } else if (event["status"] == "error") {
//           // Handle error here.
//         } else if (event["status"] == "event") {
//           // Handle events here.
//         }
//       });
//     });
//   }

//   Future<void> payWithSavedCards() async {
//    // FlutterPaytabsBridge.startPaymentWithSavedCards(generateConfig(), false,
//         (event) {
//       setState(() {
//         if (event["status"] == "success") {
//           // Handle transaction details here.
//           var transactionDetails = event["data"];
//           print(transactionDetails);
//           if (transactionDetails["isSuccess"]) {
//             print("successful transaction");
//             if (transactionDetails["isPending"]) {
//               print("transaction pending");
//             }
//           } else {
//             print("failed transaction");
//           }

//           // print(transactionDetails["isSuccess"]);
//         } else if (event["status"] == "error") {
//           // Handle error here.
//         } else if (event["status"] == "event") {
//           // Handle events here.
//         }
//       });
//     });
//   }

//   Future<void> apmsPayPressed() async {
//     FlutterPaytabsBridge.startAlternativePaymentMethod(generateConfig(),
//         (event) {
//       setState(() {
//         if (event["status"] == "success") {
//           // Handle transaction details here.
//           var transactionDetails = event["data"];
//           print(transactionDetails);
//         } else if (event["status"] == "error") {
//           // Handle error here.
//         } else if (event["status"] == "event") {
//           // Handle events here.
//         }
//       });
//     });
//   }

//   Future<void> queryPressed() async {
//     FlutterPaytabsBridge.queryTransaction(
//         generateConfig(), generateQueryConfig(), (event) {
//       setState(() {
//         if (event["status"] == "success") {
//           // Handle transaction details here.
//           var transactionDetails = event["data"];
//           print(transactionDetails);
//         } else if (event["status"] == "error") {
//           // Handle error here.
//         } else if (event["status"] == "event") {
//           // Handle events here.
//         }
//       });
//     });
//   }

//   Future<void> applePayPressed() async {
//     var configuration = PaymentSdkConfigurationDetails(
//         profileId: "110145",
//         serverKey: "SMJNHZG26Z-JKNZ2NMDBK-JTZW2WDT6B",
//         clientKey: "CHKM96-BD7B6K-Q9MQND-9TDBHB",
//         cartId: "test111orderid",
//         cartDescription: "cart description it is about the products or project",
//         merchantName: "Brothers Creative",
//         amount: 3.0,
//         currencyCode: "SAR",
//         merchantCountryCode: "SA",
//         showBillingInfo: true,
//         merchantApplePayIndentifier: "merchant.com.bunldeId",
//         simplifyApplePayValidation: true);
//     FlutterPaytabsBridge.startApplePayPayment(configuration, (event) {
//       setState(() {
//         if (event["status"] == "success") {
//           // Handle transaction details here.
//           var transactionDetails = event["data"];
//           print(transactionDetails);
//         } else if (event["status"] == "error") {
//           // Handle error here.
//         } else if (event["status"] == "event") {
//           // Handle events here.
//         }
//       });
//     });
//   }

//   Widget applePayButton() {
//     if (Platform.isIOS) {
//       return TextButton(
//         onPressed: () {
//           applePayPressed();
//         },
//         child: const Text('Pay with Apple Pay'),
//       );
//     }
//     return const SizedBox(height: 0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PayTabs Payment'),
//       ),
//       body: Center(
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//             Text('$_instructions'),
//             const SizedBox(height: 16),
//             TextButton(
//               onPressed: () {
//                 payPressed();
//               },
//               child: const Text('Pay with Card'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Future.delayed(const Duration(seconds: 20)).then(
//                     (value) => FlutterPaytabsBridge.cancelPayment((dynamic) {
//                           debugPrint("cancel payment $dynamic");
//                         }));
//               },
//               child: const Text('Cancel Payment After 20 sec'),
//             ),
//             TextButton(
//               onPressed: () {
//                 payWithTokenPressed();
//               },
//               child: const Text('Pay with Token'),
//             ),
//             TextButton(
//               onPressed: () {
//                 payWith3ds();
//               },
//               child: const Text('Pay with 3ds'),
//             ),
//             TextButton(
//               onPressed: () {
//                 payWithSavedCards();
//               },
//               child: const Text('Pay with saved cards'),
//             ),
//             const SizedBox(height: 16),
//             TextButton(
//               onPressed: () {
//                 apmsPayPressed();
//               },
//               child: const Text('Pay with Alternative payment methods'),
//             ),
//             const SizedBox(height: 16),
//             TextButton(
//               onPressed: () {
//                 queryPressed();
//               },
//               child: const Text('Query transaction'),
//             ),
//             TextButton(
//               onPressed: () {
//                 _clearSavedCards();
//               },
//               child: const Text('Clear saved cards'),
//             ),
//             const SizedBox(height: 16),
//             applePayButton()
//           ])),
//     );
//   }

//   Future _clearSavedCards() async {
//   //  final result = await FlutterPaytabsBridge.clearSavedCards();
//     debugPrint("ClearSavedCards $result");
//   }

//   var profileId = "110145";
//   var serverKey = "SMJNHZG26Z-JKNZ2NMDBK-JTZW2WDT6B";
//   var clientKey = "CHKM96-BD7B6K-Q9MQND-9TDBHB";
//   PaymentSDKQueryConfiguration generateQueryConfig() {
//     return PaymentSDKQueryConfiguration(
//         serverKey, clientKey, "SA", profileId, "Transaction Reference");
//   }
// }
