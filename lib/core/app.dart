import 'package:get/get.dart';
import 'package:so_exam/pages/dashboard/dashboard_view.dart';
import 'package:so_exam/pages/dashboard/dashboard_view_binding.dart';
import 'package:so_exam/pages/login/login_view.dart';
import 'package:so_exam/pages/login/login_view_binding.dart';
import 'package:so_exam/pages/search/search_view.dart';
import 'package:so_exam/pages/search/search_view_binding.dart';

enum AppRoutes { login, dashboard, search }

extension RoutesExtension on AppRoutes {
  String get value {
    switch (this) {
      case AppRoutes.login:
        return '/login_view';
      case AppRoutes.dashboard:
        return '/dashboard_view';
      case AppRoutes.search:
        return '/search_view';
      default:
        return '/';
    }
  }
}

class App {
  static List<GetPage> pages = [
    GetPage(
      name: AppRoutes.login.value,
      binding: LoginViewBinding(),
      page: () => const LoginView(),
    ),
    GetPage(
      name: AppRoutes.dashboard.value,
      binding: DashboardViewBinding(),
      page: () => const DashboardView(),
    ),
    GetPage(
      name: AppRoutes.search.value,
      binding: SearchViewBinding(),
      page: () => const SearchView(),
    ),
  ];
}
