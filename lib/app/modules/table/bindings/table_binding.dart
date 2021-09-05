import 'package:get/instance_manager.dart';
import 'package:served_food/app/modules/table/controllers/table_controller.dart';

class TableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TableController());
  }
}
