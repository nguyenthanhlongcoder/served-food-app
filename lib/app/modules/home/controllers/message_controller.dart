import 'package:get/state_manager.dart';
import 'package:served_food/app/modules/home/providers/message_provider.dart';
import 'package:http/http.dart' as http;

class MessageController extends GetxController {
  var lstMessage = List<dynamic>.empty(growable: true).obs;
  var isDataProcessing = false.obs;
  var isDataError = false.obs;
  var dataError = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getMessage();
  }

  Stream<http.Response> getMessage() async* {
    try {
      isDataProcessing(true);
      MessageProvider().getMessage().then((response) {
        lstMessage.clear();
        isDataProcessing(false);
        lstMessage.addAll(response);
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
