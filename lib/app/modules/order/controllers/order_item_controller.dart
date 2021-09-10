import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/modules/order/controllers/order_controller.dart';
import 'package:served_food/app/modules/order/models/user_model.dart';
import 'package:served_food/app/modules/order/providers/order_item_provider.dart';
import 'package:served_food/app/modules/order/providers/user_provider.dart';

class OrderItemController extends GetxController {
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  var orderItemID = 0.obs;
  var user = new UserModel().obs;
  @override
  void onInit() async {
    super.onInit();
    getUser();
  }

  void updateOrderItemID(int id) {
    orderItemID.value = id;
  }

  void getUser() {
    UserRepository().fetchUserID().then((value) {
      if (value != null) {
        try {
          UserProvider().getUserDetail(value).then((response) {
            print(response);
            user.value = UserModel.fromJson(response);
            if (user.value != null) {
              print(user.value.username);
            }
            isDataError(false);
          });
        } catch (e) {
          dataError(e);
          isDataError(true);
        }
      } else {
        Fluttertoast.showToast(msg: 'Have no user');
      }
    });
  }

  void deleteOrderItem() {
    if (user.value.isSuperuser) {
      try {
        isDataProcessing(true);
        OrderItemProvider().deleteOrderItem(orderItemID.value).then((response) {
          isDataProcessing(false);

          isDataError(false);
          OrderController controller = Get.put(OrderController());
          Get.back();
          controller.getOrderDetail();
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
    } else {
      Fluttertoast.showToast(msg: 'This action requires Manager User');
    }
  }
}
