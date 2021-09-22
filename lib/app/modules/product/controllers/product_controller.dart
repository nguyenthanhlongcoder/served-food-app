import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/product_model.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/common/app_datas/variation_option_model.dart';
import 'package:served_food/app/modules/order/controllers/order_controller.dart';
import 'package:served_food/app/modules/product/models/cart_model.dart';
import 'package:served_food/app/modules/product/models/order_item_model.dart';
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
  List<String> extraCart = [];
  List<int> extraOrder = [];
  List<int> orderVariationOptions = [];
  var variationName = ''.obs;
  List<VariationOptionModel> variationOptions = [];
  @override
  void onInit() {
    super.onInit();
    totalPrice.value = quantityItem.value * price.value;
    updateID(Get.arguments.toString());

    getProductDetail();
    setProductTotalPrice();
  }

  void setVariationName(String variationName) {
    this.variationName.value = variationName;
  }

  void setVariationOptions(List<VariationOptionModel> variationOptions) {
    this.variationOptions = variationOptions;
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

  void setProductVariationOption(int id, int orderVariationOptionID) {
    productVariationOption.value = id;
    if (orderVariationOptions.length != 0) {
      orderVariationOptions[0] = id;
    } else {
      orderVariationOptions.add(orderVariationOptionID);
    }
  }

  void updateOrderVariationOptions(int index, int id) {
    orderVariationOptions[index] = id;
  }

  void setProductTotalPrice() {
    totalPrice.value = quantityItem.value * price.value;
  }

  void addToTable() async {
    if (totalPrice.value != 0 &&
        product.value.variations.length == orderVariationOptions.length) {
      isAddToTableLoading.value = true;
      UserRepository userRepository = new UserRepository();
      int userId;
      await userRepository.getUser().then((user) => userId = user.id);
      SharedPreferences pref = await SharedPreferences.getInstance();
      OrderController controller = Get.put(OrderController());
      int orderId = 0;
      if (controller.order.value != null) {
        orderId = controller.order.value.id;
      }
      OrderItemModel orderItem = new OrderItemModel(
          user: userId,
          order: orderId,
          product: int.parse(productId.value),
          productVariationOption: productVariationOption.value,
          orderItemVariationOptions: orderVariationOptions,
          extras: extraOrder,
          quantity: quantityItem.value,
          note: note.value);
      String productVariationOptionName = '';
      for (var item in product.value.productVariationOptions) {
        if (item.id == productVariationOption.value) {
          for (var variationOption in item.variationOptions) {
            for (var orderVariationOption in orderVariationOptions) {
              if (orderVariationOption == variationOption.id) {
                productVariationOptionName += ' - ${variationOption.name}';
              }
            }
          }
        }
      }
      CartModel cart = CartModel(
          title: product.value.name + productVariationOptionName,
          quantity: quantityItem.value,
          note: note.value,
          orderItemPrice: totalPrice.value,
          extras: extraCart,
          image: product.value.image);

      if (!pref.containsKey('order_items')) {
        final String encodedOrderItem = OrderItemModel.encode([orderItem]);
        final String encodedCartItem = CartModel.encode([cart]);
        pref.setString('order_items', encodedOrderItem);
        pref.setString('carts', encodedCartItem);
      } else {
        final String orderItemsString = await pref.getString('order_items');
        final List<OrderItemModel> orderItems =
            OrderItemModel.decode(orderItemsString);

        final String cartItemsString = await pref.getString('carts');
        final List<CartModel> cartItems = CartModel.decode(cartItemsString);

        cartItems.add(cart);
        orderItems.add(orderItem);

        final String encodedOrderItem = OrderItemModel.encode(orderItems);
        final String encodedCartItem = CartModel.encode(cartItems);

        pref.setString('order_items', encodedOrderItem);
        pref.setString('carts', encodedCartItem);
      }
      Fluttertoast.showToast(msg: 'Add to table success');
      Get.back();
    } else {
      isAddToTableLoading.value = false;

      Fluttertoast.showToast(msg: 'Please fill up all the selections.');
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
        for (var item in product.value.productVariationOptions) {
          productVaritionGroupValue.add(item.variationOptions[0].id);
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
