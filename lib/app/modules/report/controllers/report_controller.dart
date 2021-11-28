import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/common/providers/user_provider.dart';
import 'package:served_food/app/modules/product/providers/product_provider.dart';
import 'package:served_food/app/modules/report/models/order_item_record_model.dart';
import 'package:served_food/app/modules/report/models/order_record_model.dart';
import 'package:served_food/app/modules/report/models/product_ranking_model.dart';
import 'package:served_food/app/modules/report/models/user_ranking_model.dart';
import 'package:served_food/app/modules/report/provider/report_provider.dart';

class ReportController extends GetxController {
  var isDataLoading = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  var totalSaleReport = OrderRecordModel().obs;
  var itemSaleReport = OrderItemRecordModel().obs;
  var startAt = ''.obs;
  var endAt = ''.obs;
  var durationReport = 1.obs;
  var lstUser = List<dynamic>.empty(growable: true).obs;
  var lstUserRanking = List<UserRankingModel>.empty(growable: true).obs;
  var lstProduct = List<dynamic>.empty(growable: true).obs;
  var lstProductRanking = List<ProductRankingModel>.empty(growable: true).obs;
  List<int> lstMonth = [];
  var lstValue = List<OrderRecordModel>.empty(growable: true).obs;
  var userID = ''.obs;
  @override
  void onInit() {
    getTimeRange();
    getValueRange();
    updateDurationReport(1);
    super.onInit();
  }

  void updateUserID() {
    new UserRepository().getUser().then((value) {
      userID.value = value.id.toString();
    });
  }

  void getTotalSaleReport() {
    try {
      isDataLoading(true);
      ReportProvider()
          .getTotalSaleReport(startAt.value, endAt.value)
          .then((response) {
        if (response != null) {
          isDataLoading(false);
          isDataError(false);
          totalSaleReport.value = OrderRecordModel.fromJson(response);
        } else {
          isDataError(true);
          dataError('Nothing');
        }
      });
    } catch (e) {
      isDataLoading(false);
      isDataError(true);
      dataError(e);
    }
  }

  void getAllUser() async {
    try {
      lstUser.clear();
      lstUserRanking.clear();
      isDataLoading(true);
      UserProvider().getAllUser().then((response) {
        if (response != null) {
          isDataLoading(false);
          isDataError(false);
          lstUser.assignAll(response);
          getUserRanking();
        } else {
          isDataError(true);
          dataError('Nothing');
        }
      });
    } catch (e) {
      isDataLoading(false);
      isDataError(true);
      dataError(e);
    }
  }

  void getAllProduct() async {
    try {
      lstProduct.clear();
      lstProductRanking.clear();
      isDataLoading(true);
      ProductDetailProvider().getAllProduct().then((response) {
        if (response != null) {
          isDataLoading(false);
          isDataError(false);
          lstProduct.assignAll(response);
          getProductRanking();
        } else {
          isDataError(true);
          dataError('Nothing');
        }
      });
    } catch (e) {
      isDataLoading(false);
      isDataError(true);
      dataError(e);
    }
  }

  void updateDurationReport(int value) {
    getTimeRange();
    this.durationReport.value = value;
    switch (durationReport.value) {
      case 1:
        DateTime now = DateTime.now();
        DateTime tommorrow = now.add(Duration(days: 1));
        DateFormat formatter = DateFormat('yyyy-MM-dd');
        updateDateTime(formatter.format(now), formatter.format(tommorrow));
        break;
      case 2:
        DateTime now = DateTime.now();
        DateTime current = now.add(Duration(days: 1));
        DateFormat formatter = DateFormat('yyyy-MM-dd');
        DateTime startDay = now.subtract(Duration(days: now.weekday - 1));
        updateDateTime(formatter.format(startDay), formatter.format(current));
        break;
      case 3:
        DateTime now = DateTime.now();
        DateTime current = now.add(Duration(days: 1));
        DateFormat formatter = DateFormat('yyyy-MM-dd');
        DateTime startDay = new DateTime.utc(current.year, current.month, 1);
        updateDateTime(formatter.format(startDay), formatter.format(current));
        break;
      case 4:
        DateTime now = DateTime.now();
        DateTime current = now.add(Duration(days: 1));
        DateFormat formatter = DateFormat('yyyy-MM-dd');
        DateTime startDay = new DateTime.utc(current.year, 1, 1);
        updateDateTime(formatter.format(startDay), formatter.format(current));
        break;
      default:
    }
  }

  void updateDateTime(String startAt, String endAt) {
    this.startAt.value = startAt + 'T00:00:00.00';
    this.endAt.value = endAt + 'T00:00:00.00';
    getTotalSaleReport();
    getItemSaleReport(userID.value);
    getAllUser();
    getAllProduct();
    getUserRanking();
    getProductRanking();
  }

  void getTimeRange() {
    DateTime now = DateTime.now();
    for (int i = 0; i < 6; i++) {
      int curentMonth = now.month - (5 - i);
      if (curentMonth > 0) {
        lstMonth.add(curentMonth);
      } else {
        lstMonth.add(curentMonth - 1);
      }
    }
  }

  void getValueRange() {
    for (int month in lstMonth) {
      DateTime now = DateTime.now();
      DateTime startDay;
      DateTime endDay;
      if (month > 0) {
        startDay = new DateTime.utc(now.year, month, 1);
        if (month == 12) {
          endDay = new DateTime.utc(now.year + 1, 1, 1);
        } else {
          endDay = new DateTime.utc(now.year, month + 1, 1);
        }
      } else {
        startDay = new DateTime.utc(now.year - 1, -month, 1);
        if (month == -1) {
          endDay = new DateTime.utc(now.year, 1, 1);
        } else {
          endDay = new DateTime.utc(now.year - 1, -month + 1, 1);
        }
      }
      DateFormat formatter = DateFormat('yyyy-MM-dd');

      getTotalSaleByDuration(formatter.format(startDay) + 'T00:00:00.00',
          formatter.format(endDay) + 'T00:00:00.00');
    }
  }

  void getTotalSaleByDuration(String startDay, String endDay) {
    try {
      isDataLoading(true);
      ReportProvider().getTotalSaleReport(startDay, endDay).then((response) {
        if (response != null) {
          isDataLoading(false);
          isDataError(false);
          lstValue.add(OrderRecordModel.fromJson(response));
        } else {
          isDataError(true);
          dataError('Nothing');
        }
      });
    } catch (e) {
      isDataLoading(false);
      isDataError(true);
      dataError(e);
    }
  }

  void getUserRanking() {
    for (var user in lstUser) {
      int totalSale = 0;
      for (var item in itemSaleReport.value.results) {
        if (item.user == user['id']) {
          totalSale += item.orderItemPriceRecord;
        }
      }
      lstUserRanking.add(new UserRankingModel(
          user['id'], user['image'], user['first_name'], totalSale));
    }
    lstUserRanking.sort((a, b) {
      return b.totalSale - a.totalSale;
    });
  }

  void getProductRanking() {
    for (var product in lstProduct) {
      int totalSale = 0;
      int qty = 0;
      for (var item in itemSaleReport.value.results) {
        if (item.product == product['id']) {
          totalSale += item.orderProductTotalPriceRecord;
          qty += item.quantity;
        }
      }
      lstProductRanking.add(new ProductRankingModel(
          id: product['id'],
          name: product['name'],
          qty: qty,
          totalSale: totalSale));
    }
    lstProductRanking.sort((a, b) {
      return b.qty - a.qty;
    });
  }

  void getItemSaleReport(String user) {
    try {
      isDataLoading(true);
      ReportProvider()
          .getItemSaleReport(startAt.value, endAt.value, user, '')
          .then((response) {
        if (response != null) {
          isDataLoading(false);
          isDataError(false);
          itemSaleReport.value = OrderItemRecordModel.fromJson(response);
        } else {
          isDataError(true);
          dataError('Nothing');
        }
      });
    } catch (e) {
      isDataLoading(false);
      isDataError(true);
      dataError(e);
    }
  }
}
