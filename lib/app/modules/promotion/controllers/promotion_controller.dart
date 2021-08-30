import 'package:get/get.dart';
import 'package:served_food/app/modules/promotion/models/promotion_model.dart';
import 'package:served_food/app/modules/promotion/providers/promotion_detail_provider.dart';

class PromotionController extends GetxController {
  var promotionId = ''.obs;
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  var promotion = new PromotionModel().obs;

  @override
  void onInit() {
    super.onInit();
    getPromotionDetail();
  }

  void updateID(var id) {
    promotionId.value = id;
    getPromotionDetail();
  }

  void getPromotionDetail() async {
    try {
      isDataProcessing(true);
      PromotionDetailProvider().getPromotionDetail(promotionId.value).then(
          (response) {
        isDataProcessing(false);
        isDataError(false);
        promotion.value = PromotionModel.fromJson(response);
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
