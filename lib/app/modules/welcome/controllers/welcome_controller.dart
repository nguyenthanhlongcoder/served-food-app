import 'package:get/get.dart';

class WelcomeController extends GetxController {
  var isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isLoading(false);
  }
}
