import 'package:get/get.dart';
import 'package:served_food/app/modules/browse/providers/category_product_provider.dart';

class CategoryController extends GetxController {
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  var lstCategories = List<dynamic>.empty(growable: true).obs;
  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  @override
  void onClose() {
    dispose();
    super.onClose();
  }

  void getCategories() {
    try {
      isDataProcessing(true);
      CategoryProductProvider().getCategories().then((response) {
        lstCategories.clear();
        isDataProcessing(false);
        lstCategories.assignAll(response);
        isDataError(false);
        print(lstCategories);
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
