import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/modules/order/controllers/order_controller.dart';
import 'package:served_food/app/modules/order/controllers/shopping_cart_controller.dart';
import 'package:served_food/app/modules/product/models/cart_model.dart';
import 'package:served_food/app/modules/product/models/order_item_model.dart';
import 'package:served_food/app/modules/product/models/product_model.dart';
import 'package:served_food/app/modules/product/providers/product_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  var productId = ''.obs;
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  var quantityItem = 1.obs;
  var product = new ProductModel().obs;
  var productVariationOption = 0.obs;
  var price = 0.obs;
  var totalPrice = 0.obs;
  var note = ''.obs;
  var isAddToTableLoading = false.obs;
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

  void setProductVariationOption(int id) {
    productVariationOption.value = id;
  }

  void setProductTotalPrice() {
    totalPrice.value = quantityItem.value * price.value;
  }

  void addToTable() async {
    if (totalPrice.value != 0) {
      isAddToTableLoading.value = true;
      UserRepository userRepository = new UserRepository();
      String userId = '';
      await userRepository.fetchUserID().then((value) => userId = value);
      SharedPreferences pref = await SharedPreferences.getInstance();
      OrderController controller = Get.put(OrderController());

      OrderItemModel orderItem = new OrderItemModel(
          user: int.parse(userId),
          order: controller.order.value.id,
          product: int.parse(productId.value),
          productVariationOption: productVariationOption.value,
          quantity: quantityItem.value,
          note: note.value);
      String productVariationOptionName = '';
      for (var item in product.value.productVariationOption) {
        if (item.id == productVariationOption.value) {
          productVariationOptionName = item.variationOption.name;
        }
      }
      CartModel cart = CartModel(
          title: product.value.name + ' - ' + productVariationOptionName,
          quantity: quantityItem.value,
          note: note.value,
          orderItemPrice: totalPrice.value,
          image: product.value.image);

      if (!pref.containsKey(controller.order.value.id.toString())) {
        final String encodedOrderItem = OrderItemModel.encode([orderItem]);
        final String encodedCartItem = CartModel.encode([cart]);
        pref.setString(controller.order.value.id.toString(), encodedOrderItem);
        pref.setString('carts', encodedCartItem);
      } else {
        final String orderItemsString =
            await pref.getString(controller.order.value.id.toString());
        final List<OrderItemModel> orderItems =
            OrderItemModel.decode(orderItemsString);

        final String cartItemsString = await pref.getString('carts');
        final List<CartModel> cartItems = CartModel.decode(cartItemsString);

        cartItems.add(cart);
        orderItems.add(orderItem);

        final String encodedOrderItem = OrderItemModel.encode(orderItems);
        final String encodedCartItem = CartModel.encode(cartItems);

        pref.setString(controller.order.value.id.toString(), encodedOrderItem);
        pref.setString('carts', encodedCartItem);
      }
      Fluttertoast.showToast(msg: 'Add to table success');

      print(pref.getString(controller.order.value.id.toString()));
      Get.back();
    } else {
      isAddToTableLoading.value = false;

      Fluttertoast.showToast(msg: 'Order price must not be 0');
    }
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
