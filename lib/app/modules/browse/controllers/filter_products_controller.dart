import 'package:get/get.dart';
import 'package:served_food/app/modules/browse/providers/category_product_provider.dart';
import 'package:served_food/app/modules/browse/providers/filter_product_provider.dart';

class FilterProductsController extends GetxController {
  var lstProducts = List<dynamic>.empty(growable: true).obs;
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  @override
  void onInit() {
    super.onInit();

    getFilterProducts();
  }

  @override
  void onClose() {
    dispose();
    super.onClose();
  }

  void getFilterProducts() {
    try {
      isDataProcessing(true);
      FilterProductProvider().getFilterProducts().then((response) {
        lstProducts.clear();
        isDataProcessing(false);

        lstProducts.assignAll(response);

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
