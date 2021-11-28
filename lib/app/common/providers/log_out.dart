import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/common/http/api_provider.dart';
import 'package:served_food/app/routes/app_pages.dart';
import 'package:served_food/app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOut {
  UserRepository userRepository;
  ApiProvider apiProvider;
  GetRequestUrl getRequestUrl;
  void logOut() async {
    userRepository = new UserRepository();
    apiProvider = new ApiProvider();
    getRequestUrl = new GetRequestUrl();
    userRepository.getUser().then((user) async {
      if (user != null) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        String deviceID = '';
        if (Platform.isAndroid) {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          deviceID = androidInfo.androidId;
          var response = await apiProvider
              .get(getRequestUrl.getFCMDeviceUrl(user.id.toString(), deviceID));
          if (response[0] != null) {
            var statusCode = await apiProvider.delete(
                GetRequestUrl.GET_FCM_DEVICE + response[0]['id'].toString());
            if (statusCode == 204) {
              print('FCMDevice was be deleted');
            } else {
              print('FCMDevice delection error');
            }
          }
        }
      }
    });

    userRepository.deleteAll();
    Get.offAllNamed(AppRoutes.WELCOME);
  }
}
