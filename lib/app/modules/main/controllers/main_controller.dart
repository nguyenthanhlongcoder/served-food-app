import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:device_info/device_info.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/common/http/api_provider.dart';
import '../../../../main.dart';

class MainController extends GetxController {
  PageController pageController;
  var currentIndex = 0.obs;
  GlobalKey bottomNavigationKey = GlobalKey();
  FirebaseMessaging messaging;
  String deviceName, deviceID;
  UserRepository userRepository;
  @override
  void onInit() async {
    super.onInit();
    userRepository = new UserRepository();
    pageController = PageController();
    Firebase.initializeApp().then((value) {
      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) async {
        print('FCM device token: ' + value);
        String registrationToken = value;
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        if (Platform.isAndroid) {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          deviceName = androidInfo.model;
          deviceID = androidInfo.androidId;
          userRepository.fetchUserID().then((value) async {
            if (value != null) {
              var response = await new ApiProvider().post(
                  GetRequestUrl.FCM_DEVICE,
                  json.encode({
                    "name": deviceName,
                    "is_active": true,
                    "device_id": deviceID,
                    "registration_token": registrationToken,
                    "type": "android",
                    "user": value
                  }));
              if (response != null) {
                print(response);
              }
            }
          });
        }
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(message.notification.body);
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ));
        }
      });
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print('Message clicked!');
      });
    });
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }
}
