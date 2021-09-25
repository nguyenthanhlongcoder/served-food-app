import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/app_widgets/btn_text_white_widget.dart';
import 'package:served_food/app/common/app_widgets/gradient_btn_widget.dart';
import 'package:served_food/app/modules/checkout/components/checkout_header.dart';
import 'package:served_food/app/modules/checkout/widgets/payment_method_item.dart';
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
                          CheckoutHeader(),
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
                                icon: 'assets/svg_pictures/visa.svg',
                                content: '*** *** *** 5967',
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
                                icon: 'assets/svg_pictures/mastercard.svg',
                                content: '*** *** *** 5967',
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
                                icon: 'assets/svg_pictures/paypal.svg',
                                content: 'anhlang@w360s.com',
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
                                icon: 'assets/svg_pictures/momo.svg',
                                content: '0908652940',
                                isActive: isActives[3],
                                onTap: () {
                                  setState(() {
                                    for (int i = 0; i <= 4; i++) {
                                      isActives[i] = false;
                                    }
                                    isActives[3] = !isActives[2];
                                  });
                                },
                              ),
                              SizedBox(
                                height: kPadding,
                              ),
                              PaymentMethodItem(
                                icon: 'assets/svg_pictures/cash-payment.svg',
                                content: 'Cash Payment',
                                isActive: isActives[4],
                                onTap: () {
                                  setState(() {
                                    for (int i = 0; i <= 4; i++) {
                                      isActives[i] = false;
                                    }
                                    isActives[4] = !isActives[4];
                                  });
                                },
                              )
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
                    Get.toNamed(AppRoutes.CREDIT_CARD);
                  },
                ),
              )),
        ],
      ),
    );
  }
}
