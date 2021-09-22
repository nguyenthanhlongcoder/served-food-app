import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/variation_option_model.dart';

class ProductVariationController extends GetxController {
  var variationName = ''.obs;
  dynamic radioValue = 0.obs;
  List<int> variationOptionGroupValue = [];
  List<VariationOptionModel> variationOptions = [];
  void setVariationName(String variationName) {
    this.variationName.value = variationName;
  }

  void setVariationOptions(List<VariationOptionModel> variationOptions) {
    this.variationOptions = variationOptions;
    for (var variationOption in this.variationOptions) {
      variationOptionGroupValue.add(variationOption.id);
    }
  }

  void setRadioValue(var value) {
    this.radioValue.value = value;
  }
}
