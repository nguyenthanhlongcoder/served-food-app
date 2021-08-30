import 'package:get/get.dart';
import 'package:served_food/app/modules/promotion/controllers/promotion_controller.dart';

class PromotionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PromotionController());
  }
}
