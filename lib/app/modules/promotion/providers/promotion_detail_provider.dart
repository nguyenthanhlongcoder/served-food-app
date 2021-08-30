import 'package:get/get_connect.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';

class PromotionDetailProvider extends GetConnect {
  Future<dynamic> getPromotionDetail(String id) async {
    try {
      final response = await get(GetRequestUrl.PROMOTION_DETAIL + id);
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
