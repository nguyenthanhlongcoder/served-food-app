import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/providers/format_number.dart';
import 'package:served_food/app/modules/report/models/order_record_model.dart';

class ReportChart extends StatefulWidget {
  final List<int> lstMonth;
  final List<OrderRecordModel> lstValue;
  const ReportChart({Key key, this.lstMonth, this.lstValue}) : super(key: key);
  @override
  ReportChartState createState() => ReportChartState();
}

class ReportChartState extends State<ReportChart> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.3,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color(0xff28304D)),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 20.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                showAvg ? avgData() : mainData(),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                  fontSize: 12,
                  color:
                      showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff1A2344),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            const monthNames = [
              "Jan",
              "Feb",
              "Mar",
              "Apr",
              "May",
              "Jun",
              "Jul",
              "Aug",
              "Sep",
              "Oct",
              "Nov",
              "Dec"
            ];

            switch (value.toInt()) {
              case 0:
                return monthNames[widget.lstMonth[0] < 0
                        ? -widget.lstMonth[0] - 1
                        : widget.lstMonth[0] - 1]
                    .toUpperCase();
              case 2:
                return monthNames[widget.lstMonth[1] < 0
                        ? -widget.lstMonth[1] - 1
                        : widget.lstMonth[1] - 1]
                    .toUpperCase();
              case 4:
                return monthNames[widget.lstMonth[2] < 0
                        ? -widget.lstMonth[2] - 1
                        : widget.lstMonth[2] - 1]
                    .toUpperCase();
              case 6:
                return monthNames[widget.lstMonth[3] < 0
                        ? -widget.lstMonth[3] - 1
                        : widget.lstMonth[3] - 1]
                    .toUpperCase();
              case 8:
                return monthNames[widget.lstMonth[4] < 0
                        ? -widget.lstMonth[4] - 1
                        : widget.lstMonth[4] - 1]
                    .toUpperCase();
              case 10:
                return monthNames[widget.lstMonth[5] < 0
                        ? -widget.lstMonth[5] - 1
                        : widget.lstMonth[5] - 1]
                    .toUpperCase();
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: kBodyTextSize * 0.8,
          ),
          getTitles: (value) {
            List<OrderRecordModel> lstData = widget.lstValue;
            lstData.sort((a, b) {
              return b.totalSales - a.totalSales;
            });
            int topSell = 0;
            if (widget.lstValue.length == 6) {
              topSell = (lstData[0].totalSales ~/ 1000000 + 1) * 1000000;
            }

            switch (value.toInt()) {
              case 1:
                return reduceNumber2(topSell / 4, 2);
              case 3:
                return reduceNumber2(topSell / 2, 2);
              case 5:
                return reduceNumber2(3 * topSell / 4, 2);
              case 7:
                return reduceNumber(topSell, 0);
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: lstSpot(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  List<FlSpot> lstSpot() {
    List<FlSpot> lstSpot = [];
    if (widget.lstValue.length == 6) {
      List<OrderRecordModel> lstData = widget.lstValue;

      int topSell = (lstData[0].totalSales ~/ 1000000 + 1) * 1000000;
      lstSpot.add(FlSpot(0, 7 / topSell * widget.lstValue[5].totalSales));
      lstSpot.add(FlSpot(2, 7 / topSell * widget.lstValue[4].totalSales));
      lstSpot.add(FlSpot(4, 7 / topSell * widget.lstValue[3].totalSales));
      lstSpot.add(FlSpot(6, 7 / topSell * widget.lstValue[2].totalSales));
      lstSpot.add(FlSpot(8, 7 / topSell * widget.lstValue[1].totalSales));
      lstSpot.add(FlSpot(10, 7 / topSell * widget.lstValue[0].totalSales));
    }

    return lstSpot;
  }

  double getAvg() {
    if (widget.lstValue.length == 6) {
      List<OrderRecordModel> lstData = widget.lstValue;
      lstData.sort((a, b) {
        return b.totalSales - a.totalSales;
      });
      double avg = (lstData[0].totalSales +
              lstData[1].totalSales +
              lstData[2].totalSales +
              lstData[3].totalSales +
              lstData[4].totalSales +
              lstData[5].totalSales) /
          6;
      double dot = 7 / lstData[0].totalSales * avg;
      return dot;
    }
    return 0;
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            const monthNames = [
              "Jan",
              "Feb",
              "Mar",
              "Apr",
              "May",
              "Jun",
              "Jul",
              "Aug",
              "Sep",
              "Oct",
              "Nov",
              "Dec"
            ];

            switch (value.toInt()) {
              case 0:
                return monthNames[widget.lstMonth[0] < 0
                        ? -widget.lstMonth[0] - 1
                        : widget.lstMonth[0] - 1]
                    .toUpperCase();
              case 2:
                return monthNames[widget.lstMonth[1] < 0
                        ? -widget.lstMonth[1] - 1
                        : widget.lstMonth[1] - 1]
                    .toUpperCase();
              case 4:
                return monthNames[widget.lstMonth[2] < 0
                        ? -widget.lstMonth[2] - 1
                        : widget.lstMonth[2] - 1]
                    .toUpperCase();
              case 6:
                return monthNames[widget.lstMonth[3] < 0
                        ? -widget.lstMonth[3] - 1
                        : widget.lstMonth[3] - 1]
                    .toUpperCase();
              case 8:
                return monthNames[widget.lstMonth[4] < 0
                        ? -widget.lstMonth[4] - 1
                        : widget.lstMonth[4] - 1]
                    .toUpperCase();
              case 10:
                return monthNames[widget.lstMonth[5] < 0
                        ? -widget.lstMonth[5] - 1
                        : widget.lstMonth[5] - 1]
                    .toUpperCase();
            }
            return '';
          },
          margin: 8,
          interval: 1,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: kBodyTextSize * 0.8,
          ),
          getTitles: (value) {
            List<OrderRecordModel> lstData = widget.lstValue;
            lstData.sort((a, b) {
              return b.totalSales - a.totalSales;
            });
            int topSell = 0;
            if (widget.lstValue.length == 6) {
              topSell = (lstData[0].totalSales ~/ 1000000 + 1) * 1000000;
            }

            switch (value.toInt()) {
              case 1:
                return reduceNumber2(topSell / 4, 2);
              case 3:
                return reduceNumber2(topSell / 2, 2);
              case 5:
                return reduceNumber2(3 * topSell / 4, 2);
              case 7:
                return reduceNumber(topSell, 0);
            }
            return '';
          },
          reservedSize: 32,
          interval: 1,
          margin: 12,
        ),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 9,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, getAvg()),
            FlSpot(2, getAvg()),
            FlSpot(4, getAvg()),
            FlSpot(6, getAvg()),
            FlSpot(8, getAvg()),
            FlSpot(10, getAvg()),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}
