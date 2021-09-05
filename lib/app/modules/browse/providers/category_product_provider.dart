import 'package:get/get_connect.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';

class CategoryProductProvider extends GetConnect {
  Future<List<dynamic>> getCategoryProducts() async {
    try {
      final response = await get(GetRequestUrl.PRODUCTS);
      if (response.status.hasError) {
        return Future.error(response.statusText);
      } else {
        return response.body;
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<dynamic>> getCategories() async {
    try {
      final response = await get(GetRequestUrl.CATEGORIES);
      if (response.status.hasError) {
        return Future.error(response.statusText);
      } else {
        return response.body;
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
