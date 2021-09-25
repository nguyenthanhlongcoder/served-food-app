class GetRequestUrl {
  static const DOMAIN = 'https://servedfood.xyz';
  // static const DOMAIN = 'http://127.0.0.1:8000';
  static const LOGIN = '$DOMAIN/users/login/';
  static const SEND_MESSAGES =
      '$DOMAIN/send_messages/?is_active=true&ordering=-created_at';
  static const PROMOTIONS = '$DOMAIN/promotions/?is_active=true';
  static const PROMOTION_DETAIL = '$DOMAIN/promotions/';
  static const FCM_DEVICES = '$DOMAIN/fcm_devices/?is_active=true&user=1';
  static const GET_FCM_DEVICE = '$DOMAIN/fcm_devices/';
  static const TABLES = '$DOMAIN/tables/?is_active=true';
  String getFCMDeviceUrl(String userID, String deviceID) {
    String requestUrl =
        '$DOMAIN/fcm_devices/?is_active=true&user=$userID&device_id=$deviceID';
    return requestUrl;
  }

  static const CANCEL_ORDER = '$DOMAIN/orders/create_order/';
  static const CREATE_ORDER_ITEM = '$DOMAIN/orders/create_order_item';
  static const ORDER_ITEMS = '$DOMAIN/orders/order_items?order=';
  static const TABLE_DETAIL = '$DOMAIN/tables/';
  static const ORDER_DETAIL = '$DOMAIN/orders/?status=serving&table=';
  static const PRODUCTS = '$DOMAIN/products/?is_active=true';
  static const FILTER_PRODUCTS = '$DOMAIN/products/?is_active=true&category=';
  static const CATEGORIES = '$DOMAIN/products/categories';
  static const PRODUCT_DETAIL = '$DOMAIN/products/';
  static const USER_DETAIL = '$DOMAIN/users/';
  static const CREATE_ORDER = '$DOMAIN/orders/create_order';
  static const ORDER_ITEM_DETAIL = '$DOMAIN/orders/create_order_item/';
  static const EXTRAS = '$DOMAIN/products/extras';
  static const CREATE_ORDER_DETAIL = '$DOMAIN/orders/create_order/';
}
