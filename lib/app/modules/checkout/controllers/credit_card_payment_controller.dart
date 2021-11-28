// import 'package:get/get.dart';
// import 'package:served_food/app/modules/checkout/providers/payment_service.dart';
// import 'package:served_food/app/routes/app_routes.dart';
// import 'package:stripe_payment/stripe_payment.dart';

// class CreditCardPaymentController extends GetxController {
//   var isDataProcessing = false.obs;
//   var isDataError = false.obs;
//   var dataError = ''.obs;
//   var card = new CreditCard().obs;
//   var amount = 0.obs;
//   String curreny = 'VND';
//   void updatePaymentMethod(CreditCard card, int amount) {
//     this.card.value = card;
//     this.amount.value = amount;
//   }

//   void payWithCard() async {
//     try {
//       isDataProcessing(true);
//       var response = await StripeService.payViaExistingCard(
//           amount: amount.value.toString(), currency: curreny, card: card.value);

//       if (response.success) {
//         isDataProcessing(false);
//         isDataError(false);
//         Get.toNamed(AppRoutes.CHECKOUT_RESULT);
//       } else {
//         isDataProcessing(false);
//         isDataError(true);
//         dataError.value = response.message;
//         print(response.message);
//       }
//     } catch (e) {
//       isDataProcessing(false);
//       isDataError(true);
//       dataError(e);
//     }
//   }
// }
