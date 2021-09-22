import 'package:get/state_manager.dart';
import 'package:served_food/app/modules/product/providers/extra_provider.dart';

class ExtraController extends GetxController {
  var lstExtra = List<dynamic>.empty(growable: true).obs;
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  var lstSelection = List<dynamic>.empty(growable: true).obs;
  @override
  void onInit() {
    getExtras();
    super.onInit();
  }

  void getExtras() async {
    try {
      isDataProcessing(true);
      ExtraProvider().getExtras().then((response) {
        lstExtra.clear();

        lstExtra.addAll(response);
        for (var item in lstExtra) {
          lstSelection.add(false);
        }
        isDataProcessing(false);
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
  }
}
