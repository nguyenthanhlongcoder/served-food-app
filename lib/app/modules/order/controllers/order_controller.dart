import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:served_food/app/modules/order/models/order_model.dart';
import 'package:served_food/app/modules/order/providers/order_provider.dart';
import 'package:served_food/app/modules/table/providers/table_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController extends GetxController {
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  var lstOrder = List<dynamic>.empty(growable: true).obs;
  var tableID = ''.obs;
  var order = new OrderModel().obs;
  @override
  void onInit() {
    super.onInit();
    updateTableID(Get.arguments['id'].toString());
  }

  void backToTable(var arguments) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('carts')) {
      final String cartItemsString = await pref.getString('carts');
      if (cartItemsString == '[]') {
        updateTable(arguments);
      } else {
        Fluttertoast.showToast(msg: 'Please confirm the cart.');
      }
    } else {
      updateTable(arguments);
    }
  }

  void updateTable(var arguments) {
    try {
      dynamic table = jsonEncode({
        'id': arguments['id'],
        'name': arguments['name'],
        'is_active': arguments['is_active'],
        'is_in_use': false,
        'status': arguments['status']
      });
      TableProvider().updateTable(arguments['id'].toString(), table).then(
          (response) {
        Get.back();
      }, onError: (e) {
        if (e == 'Not Found') {
          Fluttertoast.showToast(msg: 'Table not found');
        } else {
          Fluttertoast.showToast(msg: e);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void updateTableID(var id) {
    tableID.value = id;
    getOrderDetail();
  }

  void getOrderDetail() {
    try {
      isDataProcessing(true);
      OrderProvider().getOrderDetail(tableID.value).then((response) {
        isDataProcessing(false);
        if (response.length != 0) {
          order.value = OrderModel.fromJson(response[0]);
        } else {
          order.value = null;
        }
        isDataError(false);
      }, onError: (error) {
        isDataProcessing(false);
        isDataError(true);
        dataError(error);
      });
    } catch (e) {
      isDataProcessing(false);
      isDataError(true);
      dataError(e);
    }
  }
}
