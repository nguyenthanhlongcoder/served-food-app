import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/modules/promotion/models/promotion_model.dart';
import 'package:served_food/app/modules/promotion/widgets/promotion_name.dart';
import 'package:served_food/app/modules/promotion/widgets/time.dart';

class PromotionHeader extends StatelessWidget {
  const PromotionHeader({
    Key key,
    @required this.promotion,
  }) : super(key: key);

  final PromotionModel promotion;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PromotionName(
          title: promotion.name,
        ),
        SizedBox(height: kPadding * 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Time(
              title: 'Start at',
              time: promotion.startAt,
            ),
            Time(
              title: 'End at',
              time: promotion.endAt,
            ),
            SizedBox()
          ],
        ),
      ],
    );
  }
}
