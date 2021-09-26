import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/common/app_datas/user_model.dart';
import 'package:served_food/app/modules/order/controllers/order_controller.dart';
import 'package:served_food/app/modules/order/models/order_model.dart';
import 'package:served_food/app/modules/order/providers/order_provider.dart';
import 'package:served_food/app/modules/table/providers/table_provider.dart';
import 'package:http/http.dart' as http;
import 'package:served_food/app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TableController extends GetxController {
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  var lstTable = List<dynamic>.empty(growable: true).obs;
  var user = new UserModel().obs;
  OrderModel order = new OrderModel();
  var tableID = 0.obs;
  var isSwapProcessing = false.obs;
  @override
  void onInit() {
    super.onInit();
    getTabless();
    getUser();
  }

  void resetTable(var arguments) async {
    if (user.value.isSuperuser) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove('order_items');
      pref.remove('carts');
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
          getTabless();
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
    } else {
      Fluttertoast.showToast(msg: 'This action requires Manager User.');
    }
  }

  void getUser() {
    UserRepository().getUser().then((user) {
      if (user != null) {
        this.user.value = user;
      }
    });
  }

  void swapOrder(int id) async {
    isSwapProcessing(true);
    // ignore: await_only_futures
    await getOrderDetail(id.toString());
    dynamic body = jsonEncode({'table': tableID.value});
    try {
      OrderProvider().updateOrder(order.id.toString(), body).then((response) {
        if (response != null) {
          Fluttertoast.showToast(msg: 'Swap table successfully.');
          Get.back();
          isSwapProcessing(false);
          getTabless();
        } else {
          Fluttertoast.showToast(msg: response.printError());
        }
      }, onError: (e) {
        isSwapProcessing(false);

        if (e == 'Not Found') {
          Fluttertoast.showToast(msg: 'Order not found');
        } else {
          Fluttertoast.showToast(msg: e);
        }
      });
    } catch (e) {
      isSwapProcessing(false);

      print(e);
    }
  }

  void cancelOrder(var arguments) async {
    getOrderDetail(arguments['id'].toString());
    dynamic body = {"table": arguments['id'], "status": "cancelled"};
    try {
      TableProvider().cancelOrder(order.id.toString(), body).then((response) {
        if (response['status'] == 'cancelled') {
          Fluttertoast.showToast(msg: 'Cancel successfully.');
          getTabless();
        }
      }, onError: (e) {
        if (e == 'Not Found') {
          Fluttertoast.showToast(msg: 'Table not found.');
        } else {
          Fluttertoast.showToast(msg: e);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void openTable(var arguments) {
    dynamic table = jsonEncode({
      'id': arguments['id'],
      'name': arguments['name'],
      'is_active': arguments['is_active'],
      'is_in_use': true,
      'status': arguments['status']
    });
    try {
      TableProvider().updateTable(arguments['id'].toString(), table).then(
          (response) {
        Get.toNamed(AppRoutes.ORDER, arguments: arguments);
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

  Stream<http.Response> getTables() async* {
    try {
      isDataProcessing(true);
      TableProvider().getTables().then((response) {
        lstTable.clear();
        isDataProcessing(false);
        lstTable.addAll(response);
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
    if (isDataProcessing(false)) {
      yield* Stream.periodic(Duration(minutes: 60));
    }
  }

  void getTabless() {
    try {
      TableProvider().getTabless().then((response) {
        lstTable.clear();
        lstTable.addAll(response);
        isDataError(false);
      }, onError: (error) {
        isDataError(true);
        dataError(error);
      });
    } catch (e) {
      isDataError(true);
      dataError(e);
    }
  }

  void getOrderDetail(String id) {
    try {
      OrderProvider().getOrderDetail(id).then((response) {
        isDataProcessing(false);
        if (response.length != 0) {
          order = OrderModel.fromJson(response[0]);
        } else {
          order = null;
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
