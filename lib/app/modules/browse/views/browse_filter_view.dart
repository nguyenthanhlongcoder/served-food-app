import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/app_widgets/product_filter_item.dart';
import 'package:served_food/app/modules/browse/components/browse_filter_appbar.dart';

class BrowseFilterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        flexibleSpace: BrowseFilterAppBar(),
      ),
      body: Container(
        padding: EdgeInsets.all(kPadding),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: kPadding / 2,
          crossAxisSpacing: kPadding / 2,
          childAspectRatio: 0.8,
          children: [
            ProductFilterItem(),
            ProductFilterItem(),
            ProductFilterItem(),
            ProductFilterItem()
          ],
        ),
      ),
    );
  }
}
