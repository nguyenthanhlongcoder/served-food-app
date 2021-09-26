import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/product_model.dart';
import 'package:served_food/app/modules/order/controllers/order_controller.dart';
import 'package:served_food/app/modules/order/providers/order_provider.dart';
import 'package:served_food/app/modules/order/providers/shopping_cart_provider.dart';
import 'package:served_food/app/modules/product/models/cart_model.dart';
import 'package:served_food/app/modules/product/models/order_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCartController extends GetxController {
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  var isAddOrderProcessing = false.obs;
  List<OrderItemModel> orderItems = [];
  var productItem = new ProductModel().obs;
  var cartItems = List<CartModel>.empty(growable: true).obs;
  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  void getCartItems() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('carts')) {
      String cartItemsString = await pref.getString('carts');
      String orderItemsString = await pref.getString('order_items');

      orderItems.addAll(OrderItemModel.decode(orderItemsString));
      cartItems.addAll(CartModel.decode(cartItemsString));
    }
  }

  void addOrder(var arguments) async {
    OrderController controller = Get.put(OrderController());

    isAddOrderProcessing(true);
    if (controller.order.value == null) {
      dynamic body = {
        "table": int.parse(controller.tableID.value),
        "status": "serving",
      };
      try {
        OrderProvider().createOrder(body).then((response) async {
          if (response != null) {
            await addOrderItems(response["id"]);
          }
        });
      } catch (e) {
        Fluttertoast.showToast(msg: e);
        isAddOrderProcessing(false);
      }
    } else {
      await addOrderItems(controller.order.value.id);
    }
  }

  void removeCartItem(var index) async {
    orderItems.removeAt(index);
    cartItems.removeAt(index);
    final String encodedOrderItem = OrderItemModel.encode(orderItems);
    final String encodedCartItem = CartModel.encode(cartItems);
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString('order_items', encodedOrderItem);
    pref.setString('carts', encodedCartItem);
  }

  Future<void> addOrderItems(int orderID) async {
    int order = orderID;
    for (var orderItem in orderItems) {
      if (orderItem.order != 0) {
        order = orderItem.order;
      }
      dynamic body = {
        "order": order,
        "product": orderItem.product,
        "product_variation_option": orderItem.productVariationOption,
        "order_item_variation_options": orderItem.orderItemVariationOptions,
        "extras": orderItem.extras,
        "quantity": orderItem.quantity,
        "note": orderItem.note,
        "user": orderItem.user
      };
      try {
        ShoppingCartProvider().addOrderItem(body).then((response) async {
          if (response != null) {
            isAddOrderProcessing(false);
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.remove('order_items');
            pref.remove('carts');

            OrderController controller = Get.put(OrderController());
            controller.getOrderDetail();
          }
        });
      } catch (e) {
        isDataProcessing(false);
        isDataError(false);
        dataError(e);
      }
    }
    if (!isDataError.value) {
      Get.back();
    }
  }
}
