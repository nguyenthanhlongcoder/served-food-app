import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/app_widgets/btn_text_white_widget.dart';
import 'package:served_food/app/common/app_widgets/gradient_btn_widget.dart';
import 'package:served_food/app/common/providers/format_number.dart';
import 'package:served_food/app/modules/checkout/components/checkout_header.dart';
import 'package:served_food/app/modules/checkout/controllers/cash_payment_controller.dart';
import 'package:served_food/app/modules/checkout/providers/payment_service.dart';
import 'package:served_food/app/modules/checkout/widgets/payment_method_item.dart';
import 'package:served_food/app/modules/order/models/order_model.dart';
import 'package:served_food/app/modules/order/widgets/order_clipper.dart';
import 'package:served_food/app/routes/app_routes.dart';

class CheckoutView extends StatefulWidget {
  @override
  CheckoutViewState createState() {
    return CheckoutViewState();
  }
}

class CheckoutViewState extends State<CheckoutView> {
  List<bool> isActives = [true, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: kBtnColorStart,
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: OrderClipper(),
            child: Container(
              color: kBtnColorStart,
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Checkout',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: kTitleTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: kPadding,
                  ),
                  Container(
                    padding: EdgeInsets.all(kPadding),
                    width: Get.width - kPadding * 2,
                    height: Get.height - 48 - kPadding * 11,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all(Radius.circular(kBorderRadius)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          )
                        ]),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckoutHeader(
                            tableName: Get.arguments[0],
                            order: Get.arguments[1],
                          ),
                          SizedBox(
                            height: kPadding * 2,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'payment method'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: kSubtitleTextSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: kPadding,
                              ),
                              PaymentMethodItem(
                                icon: 'assets/svg_pictures/cash-payment.svg',
                                content: 'Cash Payment',
                                isActive: isActives[0],
                                onTap: () {
                                  setState(() {
                                    for (int i = 0; i <= 4; i++) {
                                      isActives[i] = false;
                                    }
                                    isActives[0] = !isActives[0];
                                  });
                                },
                              ),
                              SizedBox(
                                height: kPadding,
                              ),
                              PaymentMethodItem(
                                icon: 'assets/svg_pictures/momo.svg',
                                content: '0908652940',
                                isActive: isActives[1],
                                onTap: () {
                                  setState(() {
                                    for (int i = 0; i <= 4; i++) {
                                      isActives[i] = false;
                                    }
                                    isActives[1] = !isActives[1];
                                  });
                                },
                              ),
                              SizedBox(
                                height: kPadding,
                              ),
                              PaymentMethodItem(
                                icon: 'assets/svg_pictures/visa.svg',
                                content: '*** *** *** 5967',
                                isActive: isActives[2],
                                onTap: () {
                                  setState(() {
                                    for (int i = 0; i <= 4; i++) {
                                      isActives[i] = false;
                                    }
                                    isActives[2] = !isActives[2];
                                  });
                                },
                              ),
                              SizedBox(
                                height: kPadding,
                              ),
                              PaymentMethodItem(
                                icon: 'assets/svg_pictures/mastercard.svg',
                                content: '*** *** *** 5967',
                                isActive: isActives[3],
                                onTap: () {
                                  setState(() {
                                    for (int i = 0; i <= 4; i++) {
                                      isActives[i] = false;
                                    }
                                    isActives[3] = !isActives[3];
                                  });
                                },
                              ),
                              SizedBox(
                                height: kPadding,
                              ),
                              PaymentMethodItem(
                                icon: 'assets/svg_pictures/paypal.svg',
                                content: 'anhlang@w360s.com',
                                isActive: isActives[4],
                                onTap: () {
                                  setState(() {
                                    for (int i = 0; i <= 4; i++) {
                                      isActives[i] = false;
                                    }
                                    isActives[4] = !isActives[4];
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                width: Get.width,
                padding: const EdgeInsets.all(kPadding),
                child: GradientBtnWidget(
                  child: BtnTextWhiteWidget(
                    text: 'Payment',
                  ),
                  onTap: () {
                    if (isActives[0]) {
                      Get.bottomSheet(CashPayment(
                        tableName: Get.arguments[0],
                        order: Get.arguments[1],
                      ));
                    }
                    if (isActives[2]) {
                      OrderModel order = Get.arguments[1];
                      // Get.toNamed(AppRoutes.CREDIT_CARD,
                      //     arguments: [CardType.visa, Get.arguments[1]]);
                      // payViaNewCard(context, order.orderTotalPrice);
                    }
                    if (isActives[3]) {
                      Get.toNamed(AppRoutes.CREDIT_CARD,
                          arguments: [CardType.mastercard, Get.arguments[1]]);
                    }
                  },
                ),
              )),
        ],
      ),
    );
  }
}

// payViaNewCard(BuildContext context, int amount) async {
//   ProgressDialog dialog = new ProgressDialog(context);
//   dialog.style(message: 'Please wait...');
//   await dialog.show();
//   var response = await StripeService.payWithNewCard(
//       amount: amount.toString(), currency: 'VND');
//   await dialog.hide();
//   Get.snackbar(
//     'Thông báo',
//     response.message,
//     duration:
//         new Duration(milliseconds: response.success == true ? 1200 : 3000),
//   );
// }

class CashPayment extends StatefulWidget {
  final String tableName;
  final OrderModel order;
  const CashPayment({Key key, this.tableName, this.order}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CashPaymentState();
  }
}

class CashPaymentState extends State<CashPayment> {
  int change = 0;
  bool validate = false;
  @override
  Widget build(BuildContext context) {
    CashPaymentController controller = Get.put(CashPaymentController());
    return Container(
      height: Get.height / 3,
      padding: EdgeInsets.all(kPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kBorderRadius * 2),
              topRight: Radius.circular(kBorderRadius * 2)),
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
                text: 'total price: '.toUpperCase(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: kSubtitleTextSize,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: formatNumber(widget.order.orderTotalPrice) + ' VNĐ',
                    style: TextStyle(
                        color: kBtnColorStart,
                        fontSize: kSubtitleTextSize,
                        fontWeight: FontWeight.bold),
                  )
                ]),
          ),
          SizedBox(
            height: kPadding,
          ),
          TextFormField(
            onChanged: (value) {
              setState(() {
                if (widget.order.orderTotalPrice > int.parse(value)) {
                  validate = false;
                  change = 0;
                } else {
                  validate = true;
                  change = int.parse(value) - widget.order.orderTotalPrice;
                }
              });
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                errorText:
                    !validate ? 'Value Must Be More Than Total Price' : null,
                border: OutlineInputBorder(),
                hintText: 'Enter Cash...'),
          ),
          SizedBox(
            height: kPadding,
          ),
          RichText(
            text: TextSpan(
                text: 'change: '.toUpperCase(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: kSubtitleTextSize,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: formatNumber(change) + ' VNĐ',
                    style: TextStyle(
                        color: kBtnColorStart,
                        fontSize: kSubtitleTextSize,
                        fontWeight: FontWeight.bold),
                  )
                ]),
          ),
          SizedBox(
            height: kPadding,
          ),
          GradientBtnWidget(onTap: () {
            if (validate) {
              controller.cashOrder(widget.order);
            }
          }, child: Obx(() {
            if (controller.isDataProcessing.value) {
              return Container(
                width: kIconSize,
                height: kIconSize,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else {
              return BtnTextWhiteWidget(
                text: 'Confirm',
              );
            }
          }))
        ],
      ),
    );
  }
}
