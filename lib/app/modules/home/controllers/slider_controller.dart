import 'package:get/state_manager.dart';
import 'package:served_food/app/modules/home/providers/promotion_provider.dart';
import 'package:http/http.dart' as http;

class SliderController extends GetxController {
  var lstPromotion = List<dynamic>.empty(growable: true).obs;
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getPromotion();
  }

  Stream<http.Response> getPromotion() async* {
    try {
      isDataProcessing(true);
      PromotionProvider().getPromotion().then((response) {
        lstPromotion.clear();
        isDataProcessing(false);
        response.forEach((item) {
          if (item['status'] == "in_progess") {
            lstPromotion.add(item);
          }
        });
        isDataError(false);
      }, onError: (error) {
        isDataProcessing(false);
        isDataError(true);
        dataError(error);
      });
    } catch (e) {
      isDataProcessing(false);
      isDataError(true);
      dataError(e);
    }
    if (isDataProcessing(false)) {
      yield* Stream.periodic(Duration(minutes: 60));
    }
  }
}
