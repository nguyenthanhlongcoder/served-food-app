import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/modules/order/controllers/order_controller.dart';
import 'package:served_food/app/modules/order/providers/order_provider.dart';
import 'package:served_food/app/modules/order/providers/shopping_cart_provider.dart';
import 'package:served_food/app/modules/product/models/cart_model.dart';
import 'package:served_food/app/modules/product/models/order_item_model.dart';
import 'package:served_food/app/modules/product/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCartController extends GetxController {
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  List<OrderItemModel> orderItems = [];
  var productItem = new ProductModel().obs;
  var cartItems = List<CartModel>.empty(growable: true).obs;
  var key = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  void updateKey(String key) {
    this.key.value = key;
  }

  void getCartItems() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.containsKey('carts')) {
        String cartItemsString = await pref.getString('carts');
        String orderItemsString = await pref.getString(key.value);

        orderItems.addAll(OrderItemModel.decode(orderItemsString));
        cartItems.addAll(CartModel.decode(cartItemsString));
      }

      isDataError(false);
    } catch (e) {
      isDataError(true);
      dataError(e);
    }
  }

  void addOrder(var arguments) async {
    OrderController controller = Get.put(OrderController());
    isDataProcessing(true);
    if (controller.order.value.id == null) {
      dynamic body = {
        "table": int.parse(controller.tableID.value),
        "status": "serving",
        "order_item": [],
      };
      try {
        OrderProvider().createOrder(body).then((response) {
          if (response != null) {
            addOrderItems(response["id"]);
          }
        });
      } catch (e) {
        print(e);
      }
    } else {
      addOrderItems(controller.order.value.id);
    }

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    isDataProcessing(false);
    OrderController orderController = Get.put(OrderController());
    orderController.getOrderDetail();
  }

  void removeCartItem(var index) async {
    orderItems.removeAt(index);
    cartItems.removeAt(index);
    final String encodedOrderItem = OrderItemModel.encode(orderItems);
    final String encodedCartItem = CartModel.encode(cartItems);
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString(key.value, encodedOrderItem);
    pref.setString('carts', encodedCartItem);
  }

  void addOrderItems(int orderID) {
    int order = orderID;
    for (var orderItem in orderItems) {
      if (orderItem.order != null) {
        order = orderItem.order;
      }
      dynamic body = {
        "order": order,
        "product": orderItem.product,
        "product_variation_option": orderItem.productVariationOption,
        "quantity": orderItem.quantity,
        "note": orderItem.note,
        "user": orderItem.user
      };
      try {
        ShoppingCartProvider().addOrderItem(body).then((response) {});
      } catch (e) {
        isDataProcessing(false);
        isDataError(false);
        dataError(e);
      }
    }
  }
}
