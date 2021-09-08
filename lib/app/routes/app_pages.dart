import 'package:get/get.dart';
import 'package:served_food/app/modules/browse/views/browse_filter_view.dart';
import 'package:served_food/app/modules/browse/views/browse_view.dart';
import 'package:served_food/app/modules/home/bindings/home_binding.dart';
import 'package:served_food/app/modules/home/views/home_view.dart';
import 'package:served_food/app/modules/main/bindings/main_binding.dart';
import 'package:served_food/app/modules/login/bindings/login_binding.dart';
import 'package:served_food/app/modules/login/views/login_view.dart';
import 'package:served_food/app/modules/main/views/main_view.dart';
import 'package:served_food/app/modules/order/bindings/order_bindings.dart';
import 'package:served_food/app/modules/order/views/order_view.dart';
import 'package:served_food/app/modules/product/views/product_view.dart';
import 'package:served_food/app/modules/promotion/bindings/promotion_binding.dart';
import 'package:served_food/app/modules/promotion/views/promotion_view.dart';
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
    )
  ];
}
