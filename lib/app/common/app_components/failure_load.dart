import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_widgets/btn_text_white_widget.dart';
import 'package:served_food/app/common/app_widgets/gradient_btn_widget.dart';

class FailureLoad extends StatelessWidget {
  final String title, message;
  final Function onPressed;

  const FailureLoad(
      {Key key, this.title, this.message, @required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
              size: 30,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 2,
            ),
            GradientBtnWidget(
              child: BtnTextWhiteWidget(
                text: 'Retry',
              ),
              onTap: onPressed,
            )
          ],
        ),
      ),
    );
  }
}
