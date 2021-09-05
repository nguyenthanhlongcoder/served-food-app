import 'package:get/get.dart';
import 'package:served_food/app/modules/browse/providers/category_product_provider.dart';

class ProductSliderController extends GetxController {
  var lstProducts = List<dynamic>.empty(growable: true).obs;
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  @override
  void onInit() {
    super.onInit();

    getCategoryProducts();
  }

  @override
  void onClose() {
    dispose();
    super.onClose();
  }

  List<String> getSuggestions() {
    List<String> suggestions = [];

    for (var product in lstProducts) {
      suggestions.add(product['name']);
    }
    return suggestions;
  }

  void getCategoryProducts() {
    try {
      isDataProcessing(true);
      CategoryProductProvider().getCategoryProducts().then((response) {
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
