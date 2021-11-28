import 'package:get/get.dart';
import 'package:served_food/app/modules/browse/views/browse_filter_view.dart';
import 'package:served_food/app/modules/browse/views/browse_view.dart';
import 'package:served_food/app/modules/chat/views/chat_view.dart';
import 'package:served_food/app/modules/checkout/views/cash_view.dart';
import 'package:served_food/app/modules/checkout/views/checkout_result_view.dart';
import 'package:served_food/app/modules/checkout/views/checkout_view.dart';
import 'package:served_food/app/modules/checkout/views/credit_card_view.dart';
import 'package:served_food/app/modules/checkout/views/test_view.dart';
import 'package:served_food/app/modules/home/bindings/home_binding.dart';
import 'package:served_food/app/modules/home/views/home_view.dart';
import 'package:served_food/app/modules/main/bindings/main_binding.dart';
import 'package:served_food/app/modules/login/bindings/login_binding.dart';
import 'package:served_food/app/modules/login/views/login_view.dart';
import 'package:served_food/app/modules/main/views/main_view.dart';
import 'package:served_food/app/modules/order/bindings/order_bindings.dart';
import 'package:served_food/app/modules/order/views/order_view.dart';
import 'package:served_food/app/modules/product/views/product_view.dart';
import 'package:served_food/app/modules/profile/bindings/profile_binding.dart';
import 'package:served_food/app/modules/profile/views/profile_view.dart';
import 'package:served_food/app/modules/promotion/bindings/promotion_binding.dart';
import 'package:served_food/app/modules/promotion/views/promotion_view.dart';
import 'package:served_food/app/modules/report/views/my_report_view.dart';
import 'package:served_food/app/modules/report/views/report_view.dart';
import 'package:served_food/app/modules/welcome/views/welcome_view.dart';
import 'package:served_food/app/routes/app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.WELCOME;
  static const LOGIN = AppRoutes.LOGIN;
  static final routes = [
    GetPage(name: AppRoutes.WELCOME, page: () => new WelcomeView()),
    GetPage(
        name: AppRoutes.LOGIN,
        page: () => new LoginView(),
        binding: LoginBinding()),
    GetPage(
        name: AppRoutes.HOME,
        page: () => new HomeView(),
        binding: HomeBinding()),
    GetPage(
        name: AppRoutes.MAIN,
        page: () => new MainView(),
        binding: MainBinding()),
    GetPage(
        name: AppRoutes.PROMOTION,
        page: () => new PromotionView(),
        binding: PromotionBinding()),
    GetPage(
        name: AppRoutes.ORDER,
        page: () => new OrderView(),
        binding: OrderBinding()),
    GetPage(
      name: AppRoutes.BROWSE,
      page: () => new BrowseView(),
    ),
    GetPage(
      name: AppRoutes.BROWSE_FILTER,
      page: () => new BrowseFilterView(),
    ),
    GetPage(
      name: AppRoutes.PRODUCT_DETAIL,
      page: () => new ProductView(),
    ),
    GetPage(name: AppRoutes.CHECKOUT, page: () => new CheckoutView()),
    GetPage(name: AppRoutes.CREDIT_CARD, page: () => new CreditCardView()),
    GetPage(name: AppRoutes.CASH, page: () => new CashView()),
    // GetPage(
    //     name: AppRoutes.CHECKOUT_RESULT, page: () => new CheckoutResultView()),
    // GetPage(name: AppRoutes.TEST, page: () => new MyApp()),
    GetPage(
        name: AppRoutes.PROFILE,
        page: () => new ProfileView(),
        binding: ProfileBinding()),
    GetPage(
      name: AppRoutes.REPORT,
      page: () => new ReportView(),
    ),
    GetPage(
      name: AppRoutes.MY_REPORT,
      page: () => new MyReportView(),
    ),
    GetPage(
      name: AppRoutes.CHAT,
      page: () => new ChatView(),
    )
  ];
}
