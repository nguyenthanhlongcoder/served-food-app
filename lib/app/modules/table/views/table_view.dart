import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_components/failure_load.dart';

import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/modules/table/controllers/table_controller.dart';
import 'package:served_food/app/modules/table/widgets/table_item.dart';
import 'package:served_food/app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletons/skeletons.dart';

class TableView extends StatelessWidget {
  final TableController controller = Get.put(TableController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Order',
            style: kBodyTextStyle.copyWith(
                fontSize: kTitleTextSize,
                color: kBtnColorStart,
                fontWeight: FontWeight.w500),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.info_outline,
                  color: kBtnColorStart,
                ))
          ],
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: EdgeInsets.all(kPadding),
          child: Obx(() {
            if (controller.isDataProcessing.value) {
              return SpinKitFadingFour(
                color: kBtnColorStart,
                size: 50.0,
              );
            } else {
              if (controller.isDataError.value) {
                return FailureLoad(
                    title: 'Error',
                    message: controller.dataError.value,
                    onPressed: () => controller.getTables());
              } else {
                return StreamBuilder(
                    stream: controller.getTables(),
                    builder: (context, snapshot) {
                      var data = controller.lstTable;

                      return GridView.count(
                          crossAxisCount: 3,
                          children: List.generate(data.length, (index) {
                            Color color;
                            if (data[index]['is_in_use']) {
                              color = kBtnColorEnd;
                            } else {
                              switch (data[index]['status']) {
                                case 'ready':
                                  color = kHintColor;
                                  break;
                                case 'ordered':
                                  color = kBtnColorStart;
                                  break;
                                default:
                                  color = Colors.red;
                              }
                            }
                            return FocusedMenuHolder(
                              onPressed: () async {
                                if (data[index]['is_in_use']) {
                                  Fluttertoast.showToast(
                                      msg: 'This table is been using.');
                                } else {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  pref.clear();
                                  controller.openTable(data[index]);
                                }
                              },
                              menuWidth: Get.width / 2,
                              blurSize: 4,
                              menuItems: <FocusedMenuItem>[
                                FocusedMenuItem(
                                    title: Text('Mở'),
                                    onPressed: () async {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      pref.clear();
                                      controller.openTable(data[index]);
                                    },
                                    trailingIcon: Icon(
                                      Icons.open_in_new,
                                      color: kBtnColorStart,
                                    )),
                                FocusedMenuItem(
                                    title: Text('Thanh Toán'),
                                    onPressed: () {},
                                    trailingIcon: Icon(
                                      Icons.wallet_giftcard,
                                      color: kBtnColorStart,
                                    )),
                                FocusedMenuItem(
                                    title: Text('Hủy'),
                                    onPressed: () {},
                                    trailingIcon: Icon(
                                      Icons.cancel,
                                      color: kBtnColorStart,
                                    )),
                                FocusedMenuItem(
                                    title: Text('Đặt Lại'),
                                    onPressed: () async {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      pref.clear();
                                      controller.resetTable(data[index]);
                                    },
                                    trailingIcon: Icon(
                                      Icons.restart_alt,
                                      color: kBtnColorStart,
                                    )),
                                FocusedMenuItem(
                                    title: Text(
                                      'Xóa',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {},
                                    trailingIcon: Icon(Icons.delete),
                                    backgroundColor: Colors.redAccent),
                              ],
                              child: TableItem(
                                title: data[index]['name'] ?? 'Error',
                                color: color,
                              ),
                            );
                          }));
                    });
              }
            }
          }),
        ));
  }
}
