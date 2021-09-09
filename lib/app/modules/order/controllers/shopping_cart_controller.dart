import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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
  var cartItems = List<dynamic>.empty(growable: true).obs;

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

  void addOrderItem() async {
    for (var orderItem in orderItems) {
      print(orderItem);
      try {
        ShoppingCartProvider().addOrderItem(orderItem).then((response) {});
      } catch (e) {
        isDataProcessing(false);
        isDataError(false);
        dataError(e);
      }
    }
  }
}
