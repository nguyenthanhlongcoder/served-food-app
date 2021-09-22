import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeController extends GetxController {
  var isLoading = false.obs;
  UserRepository userRepository = new UserRepository();

  @override
  void onInit() {
    super.onInit();
    isLoading(false);
  }

  void routeToLogin() {
    isLoading(true);
    userRepository.hasUser().then((value) async {
      if (value == true) {
        userRepository.fetchExpiry().then((expiry) async {
          DateTime expiryDateTime =
              DateFormat("yyyy-MM-dd HH:mm:ss").parse(expiry);
          if (expiryDateTime.isAfter(DateTime.now())) {
            Get.offNamedUntil(AppRoutes.MAIN, (route) => false);
          } else {
            userRepository.deleteAll();
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.clear();

            Get.toNamed(AppRoutes.LOGIN);
          }
        });
      } else {
        userRepository.deleteAll();
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.clear();

        Get.toNamed(AppRoutes.LOGIN);
      }
    });
  }
}
