import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/modules/order/models/order_model.dart';
import 'package:served_food/app/modules/order/providers/order_provider.dart';
import 'package:served_food/app/routes/app_routes.dart';

class CashPaymentController extends GetxController {
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;

  void cashOrder(OrderModel order) {
    isDataProcessing(true);
    try {
      UserRepository().getUser().then((user) {
        dynamic body = {
          "table": order.table,
          "status": "paid",
          "paid_by": user.id
        };
        OrderProvider().updateOrder(order.id.toString(), body).then((response) {
          if (response['status'] == 'paid') {
            isDataProcessing(false);
            // Get.toNamed(AppRoutes.CHECKOUT_RESULT);
            Get.back();
            Get.back();
            Get.back();
          }
        });
      });
    } catch (e) {
      isDataProcessing(false);
      isDataError(true);
      dataError.value = e;
    }
  }
}
