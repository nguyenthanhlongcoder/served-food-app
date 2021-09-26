import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_components/failure_load.dart';

import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/app_widgets/btn_text_white_widget.dart';
import 'package:served_food/app/common/app_widgets/gradient_btn_widget.dart';
import 'package:served_food/app/modules/order/models/table_model.dart';
import 'package:served_food/app/modules/table/controllers/table_controller.dart';
import 'package:served_food/app/modules/table/widgets/table_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                    onPressed: () {
                      controller.getTabless();
                    });
              } else {
                // return StreamBuilder(
                //     stream: controller.getTables(),
                //     builder: (context, snapshot) {
                //       var data = controller.lstTable;

                //       return GridView.count(
                //           crossAxisCount: 3,
                //           children: List.generate(data.length, (index) {
                //             Color color;
                //             if (data[index]['is_in_use']) {
                //               color = kBtnColorEnd;
                //             } else {
                //               switch (data[index]['status']) {
                //                 case 'ready':
                //                   color = kHintColor;
                //                   break;
                //                 case 'ordered':
                //                   color = kBtnColorStart;
                //                   break;
                //                 default:
                //                   color = Colors.red;
                //               }
                //             }
                //             return FocusedMenuHolder(
                //               onPressed: () async {
                //                 if (data[index]['is_in_use']) {
                //                   Fluttertoast.showToast(
                //                       msg: 'This table is been using.');
                //                 } else {
                //                   SharedPreferences pref =
                //                       await SharedPreferences.getInstance();
                //                   pref.remove('carts');
                //                   pref.remove('order_items');
                //                   controller.openTable(data[index]);
                //                 }
                //               },
                //               menuWidth: Get.width / 2,
                //               blurSize: 4,
                //               menuItems: <FocusedMenuItem>[
                //                 FocusedMenuItem(
                //                     title: Text('Mở'),
                //                     onPressed: () async {
                //                       SharedPreferences pref =
                //                           await SharedPreferences.getInstance();
                //                       pref.remove('carts');
                //                       pref.remove('order_items');

                //                       controller.openTable(data[index]);
                //                     },
                //                     trailingIcon: Icon(
                //                       Icons.open_in_new,
                //                       color: kBtnColorStart,
                //                     )),
                //                 FocusedMenuItem(
                //                     title: Text('Thanh Toán'),
                //                     onPressed: () {},
                //                     trailingIcon: Icon(
                //                       Icons.wallet_giftcard,
                //                       color: kBtnColorStart,
                //                     )),
                //                 FocusedMenuItem(
                //                     title: Text('Hủy'),
                //                     onPressed: () {},
                //                     trailingIcon: Icon(
                //                       Icons.cancel,
                //                       color: kBtnColorStart,
                //                     )),
                //                 FocusedMenuItem(
                //                     title: Text('Đặt Lại'),
                //                     onPressed: () {
                //                       controller.resetTable(data[index]);
                //                     },
                //                     trailingIcon: Icon(
                //                       Icons.restart_alt,
                //                       color: kBtnColorStart,
                //                     )),
                //                 FocusedMenuItem(
                //                     title: Text(
                //                       'Chuyển bàn',
                //                     ),
                //                     onPressed: () {
                //                       TableModel table =
                //                           TableModel.fromJson(data[index]);
                //                       Get.bottomSheet(BottomSheet(
                //                         table: table,
                //                       ));
                //                     },
                //                     trailingIcon: Icon(Icons.swap_horiz_rounded,
                //                         color: kBtnColorStart),
                //                     backgroundColor: Colors.white),
                //                 FocusedMenuItem(
                //                     title: Text(
                //                       'Xóa',
                //                       style: TextStyle(color: Colors.white),
                //                     ),
                //                     onPressed: () {},
                //                     trailingIcon: Icon(Icons.delete),
                //                     backgroundColor: Colors.redAccent),
                //               ],
                //               child: TableItem(
                //                 title: data[index]['name'] ?? 'Error',
                //                 color: color,
                //               ),
                //             );
                //           }));
                //     });
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
                            pref.remove('carts');
                            pref.remove('order_items');
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
                                pref.remove('carts');
                                pref.remove('order_items');

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
                              onPressed: () {
                                controller.cancelOrder(data[index]);
                              },
                              trailingIcon: Icon(
                                Icons.cancel,
                                color: kBtnColorStart,
                              )),
                          FocusedMenuItem(
                              title: Text('Đặt Lại'),
                              onPressed: () {
                                controller.resetTable(data[index]);
                                controller.getTabless();
                              },
                              trailingIcon: Icon(
                                Icons.restart_alt,
                                color: kBtnColorStart,
                              )),
                          FocusedMenuItem(
                              title: Text(
                                'Chuyển bàn',
                              ),
                              onPressed: () {
                                TableModel table =
                                    TableModel.fromJson(data[index]);
                                Get.bottomSheet(BottomSheet(
                                  table: table,
                                ));
                              },
                              trailingIcon: Icon(Icons.swap_horiz_rounded,
                                  color: kBtnColorStart),
                              backgroundColor: Colors.white),
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
              }
            }
          }),
        ));
  }
}

class BottomSheet extends StatelessWidget {
  final TableModel table;

  const BottomSheet({Key key, this.table}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TableController controller = Get.put(TableController());

    return Container(
      padding: EdgeInsets.all(kPadding),
      height: Get.height * 0.35,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kBorderRadius * 2),
              topRight: Radius.circular(kBorderRadius * 2)),
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  text: 'Table #',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: kTitleTextSize,
                      fontWeight: FontWeight.bold),
                  children: [
                TextSpan(
                  text: table.name,
                  style: TextStyle(
                      color: kBtnColorStart,
                      fontSize: kTitleTextSize,
                      fontWeight: FontWeight.bold),
                )
              ])),
          SizedBox(
            height: kPadding / 2,
          ),
          Icon(
            Icons.swap_horiz_rounded,
            color: kBtnColorStart,
            size: kTitleTextSize,
          ),
          SizedBox(
            height: kPadding / 2,
          ),
          Obx(() {
            List<TableModel> tables = [];
            for (var item in controller.lstTable) {
              if (item['status'] == 'ready') {
                TableModel table = TableModel.fromJson(item);
                tables.add(table);
              }
            }
            return DropdownSearch<TableModel>(
              validator: (v) => v == null ? "required field" : null,
              hint: "Select a table",
              mode: Mode.BOTTOM_SHEET,
              popupItemBuilder: _customPopupItemBuilderExample,
              compareFn: (item, selectedItem) => item?.id == selectedItem?.id,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              dropdownSearchDecoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: kBtnColorStart),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ),
              showAsSuffixIcons: true,
              clearButtonBuilder: (_) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.clear,
                  size: 24,
                  color: Colors.black,
                ),
              ),
              dropdownButtonBuilder: (_) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.arrow_drop_down,
                  size: 24,
                  color: Colors.black,
                ),
              ),
              dropdownBuilder: _customDropDownExample,
              showSelectedItems: true,
              items: tables,
              showClearButton: true,
              onChanged: (data) {
                controller.tableID.value = data.id;
              },
            );
          }),
          SizedBox(
            height: kPadding,
          ),
          GradientBtnWidget(onTap: () {
            controller.swapOrder(table.id);
          }, child: Obx(() {
            if (controller.isSwapProcessing.value) {
              return Container(
                  width: kIconSize,
                  height: kIconSize,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
            } else {
              return BtnTextWhiteWidget(
                text: 'Swap',
              );
            }
          }))
        ],
      ),
    );
  }
}

Widget _customDropDownExample(BuildContext context, TableModel item) {
  if (item == null) {
    return Container();
  }

  return Container(
    padding: EdgeInsets.symmetric(horizontal: kPadding / 2),
    child: Text(
      item.name,
      style: TextStyle(
          fontSize: kSubtitleTextSize,
          fontWeight: FontWeight.bold,
          color: kBtnColorStart),
    ),
  );
}

Widget _customPopupItemBuilderExample(
    BuildContext context, TableModel item, bool isSelected) {
  return Container(
    decoration: !isSelected
        ? null
        : BoxDecoration(
            color: kBtnColorStart,
          ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kPadding / 2, horizontal: kPadding),
      child: Text(
        item.name,
        style: TextStyle(
            fontSize: kSubtitleTextSize,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black),
      ),
    ),
  );
}
