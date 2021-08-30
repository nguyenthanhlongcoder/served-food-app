import 'package:flutter/material.dart';

import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/modules/table/widgets/table_item.dart';

class TableView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(12, (index) {
                  return TableItem(
                    title: 'A1',
                    color: kBtnColorStart,
                  );
                }))));
  }
}
