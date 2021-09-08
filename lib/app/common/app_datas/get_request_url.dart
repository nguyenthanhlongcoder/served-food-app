class GetRequestUrl {
  static const LOGIN = 'https://served-food.herokuapp.com/users/api/login/';
  static const SEND_MESSAGES =
      'https://served-food.herokuapp.com/send_messages/?is_active=true&ordering=-created_at';
  static const PROMOTIONS =
      'https://served-food.herokuapp.com/promotions/?is_active=true';
  static const PROMOTION_DETAIL =
      'https://served-food.herokuapp.com/promotions/';
  static const FCM_DEVICES =
      'https://served-food.herokuapp.com/fcm_devices/?is_active=true&user=1';
  static const GET_FCM_DEVICE =
      'https://served-food.herokuapp.com/fcm_devices/';
  static const TABLES =
      'https://served-food.herokuapp.com/tables/?is_active=true';
  String getFCMDeviceUrl(String userID, String deviceID) {
    String requestUrl =
        'https://served-food.herokuapp.com/fcm_devices/?is_active=true&user=$userID&device_id=$deviceID';
    return requestUrl;
  }

  static const ORDER_ITEMS =
      'https://served-food.herokuapp.com/orders/order_item?order=';
  static const TABLE_DETAIL = 'https://served-food.herokuapp.com/tables/';
  static const ORDER_DETAIL = 'https://served-food.herokuapp.com/orders/';
  static const PRODUCTS =
      'https://served-food.herokuapp.com/products/?is_active=true';
  static const FILTER_PRODUCTS =
      'https://served-food.herokuapp.com/products/?is_active=true&category=';
  static const CATEGORIES =
      'https://served-food.herokuapp.com/products/categories';
  static const PRODUCT_DETAIL = 'https://served-food.herokuapp.com/products/';
  static const USER_DETAIL = 'https://served-food.herokuapp.com/users/';
}
