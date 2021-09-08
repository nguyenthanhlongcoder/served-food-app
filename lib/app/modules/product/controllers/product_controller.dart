import 'package:get/get.dart';
import 'package:served_food/app/modules/product/models/product_model.dart';
import 'package:served_food/app/modules/product/providers/product_provider.dart';

class ProductController extends GetxController {
  var productId = ''.obs;
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  var quantityItem = 1.obs;
  var product = new ProductModel().obs;

  var price = 0.obs;
  var totalPrice = 0.obs;
  List<dynamic> productVaritionGroupValue = [].obs;
  @override
  void onInit() {
    super.onInit();
    totalPrice.value = quantityItem.value * price.value;
    getProductDetail();
    setProductTotalPrice();
  }

  void increment() {
    quantityItem.value++;
    setProductTotalPrice();
  }

  void decrement() {
    if (quantityItem.value > 1) {
      quantityItem.value--;
    }
    setProductTotalPrice();
  }

  void updateID(var id) {
    productId.value = id;
    getProductDetail();
  }

  void setProductTotalPrice() {
    totalPrice.value = quantityItem.value * price.value;
  }

  void setProductPrice(var price) {
    this.price.value = price;
    setProductTotalPrice();
  }

  void getProductDetail() async {
    try {
      isDataProcessing(true);
      ProductDetailProvider().getProductDetail(productId.value).then(
          (response) {
        isDataProcessing(false);
        isDataError(false);
        product.value = ProductModel.fromJson(response);
        for (var item in product.value.productVariationOption) {
          productVaritionGroupValue.add(item.variationOption.id);
        }
      }, onError: (error) {
        isDataProcessing(false);
        isDataError(true);
      });
    } catch (e) {
      isDataProcessing(false);
      isDataError(true);
    }
  }
}
