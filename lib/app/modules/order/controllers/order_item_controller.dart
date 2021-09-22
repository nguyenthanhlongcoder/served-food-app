import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/modules/order/controllers/order_controller.dart';
import 'package:served_food/app/common/app_datas/user_model.dart';
import 'package:served_food/app/modules/order/providers/order_item_provider.dart';

class OrderItemController extends GetxController {
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  Map<String, dynamic> body;
  var orderItemID = 0.obs;
  var user = new UserModel().obs;
  @override
  void onInit() async {
    super.onInit();
    getUser();
  }

  void updateOrderItem(int orderID, int orderItemID, int user,
      int productVariationOption, List<int> orderItemVariationOptions) {
    this.orderItemID.value = orderItemID;
    body = {
      'order': orderID,
      'user': user,
      'product_variation_option': productVariationOption,
      'order_item_variation_options': orderItemVariationOptions,
      'is_active': false
    };
  }

  void getUser() {
    UserRepository().getUser().then((user) {
      if (user != null) {
        this.user.value = user;
      }
    });
  }

  void deleteOrderItem() {
    if (user.value.isSuperuser) {
      try {
        isDataProcessing(true);
        OrderItemProvider().deleteOrderItem(this.orderItemID.value, body).then(
            (response) {
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
