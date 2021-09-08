import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/modules/order/models/order_model.dart';
import 'package:served_food/app/modules/order/providers/order_provider.dart';
import 'package:served_food/app/modules/table/providers/table_provider.dart';

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
    getOrderDetail();
  }

  void backToTable(var arguments) {
    dynamic table = jsonEncode({
      'id': arguments['id'],
      'name': arguments['name'],
      'is_active': arguments['is_active'],
      'is_in_use': false,
      'status': arguments['status']
    });
    try {
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
        if (response['order_item'] != null) {
          order.value = OrderModel.fromJson(response);
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
