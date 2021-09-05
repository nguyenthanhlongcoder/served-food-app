import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:served_food/app/modules/order/models/order_model.dart';
import 'package:served_food/app/modules/order/models/table_model.dart';
import 'package:served_food/app/modules/order/providers/order_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OrderController extends GetxController {
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  var lstOrder = List<dynamic>.empty(growable: true).obs;
  var tableID = ''.obs;
  var table = new TableModel().obs;
  var order = new OrderModel().obs;
  @override
  void onInit() {
    super.onInit();
    getTableDetail();
  }

  void updateTableID(var id) {
    tableID.value = id;
    getTableDetail();
  }

  void getTableDetail() {
    try {
      isDataProcessing(true);

      OrderProvider().getTableDetail(tableID.value).then((response) {
        isDataProcessing(false);
        table.value = TableModel.fromJson(response);
        if (table.value != null) {
          getOrderDetail();
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

  void getOrderDetail() {
    try {
      isDataProcessing(true);
      OrderProvider().getOrderDetail(table.value.id.toString()).then(
          (response) {
        isDataProcessing(false);
        order.value = OrderModel.fromJson(response);
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
