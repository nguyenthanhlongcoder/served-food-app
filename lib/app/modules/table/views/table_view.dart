import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_components/failure_load.dart';

import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/modules/table/controllers/table_controller.dart';
import 'package:served_food/app/modules/table/widgets/table_item.dart';
import 'package:served_food/app/routes/app_routes.dart';

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
              return Center(
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ),
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
                              onPressed: () {
                                if (data[index]['is_in_use']) {
                                  Get.snackbar(
                                      'Thông báo', 'Bàn đang được sử dụng');
                                } else {
                                  Get.toNamed(AppRoutes.ORDER,
                                      arguments: data[index]['id'].toString());
                                }
                              },
                              menuWidth: Get.width / 2,
                              blurSize: 4,
                              menuItems: <FocusedMenuItem>[
                                FocusedMenuItem(
                                    title: Text('Mở'),
                                    onPressed: () {},
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
                                    onPressed: () {},
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
