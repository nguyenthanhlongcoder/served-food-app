import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/user_model.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';

class ProfileController extends GetxController {
  var user = new UserModel().obs;
  UserRepository userRepository = new UserRepository();
  @override
  void onInit() async {
    userRepository.getUser().then((value) {
      user.value = value;
    });
    super.onInit();
  }
}
