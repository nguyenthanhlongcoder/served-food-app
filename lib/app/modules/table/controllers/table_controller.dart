import 'package:get/get.dart';
import 'package:served_food/app/modules/table/models/table.dart';
import 'package:served_food/app/modules/table/providers/table_provider.dart';
import 'package:http/http.dart' as http;

class TableController extends GetxController {
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  var lstTable = List<dynamic>.empty(growable: true).obs;

  @override
  void onInit() {
    super.onInit();
    getTables();
  }

  Stream<http.Response> getTables() async* {
    try {
      isDataProcessing(true);
      TableProvider().getTables().then((response) {
        lstTable.clear();
        isDataProcessing(false);
        lstTable.addAll(response);
        isDataError(false);
      }, onError: (error) {
        isDataProcessing(false);
        isDataError(true);
        dataError(error);
      });
    } catch (e) {
      isDataProcessing(false);
      isDataError(true);
      dataError(e);
    }
    if (isDataProcessing(false)) {
      yield* Stream.periodic(Duration(minutes: 60));
    }
  }
}
