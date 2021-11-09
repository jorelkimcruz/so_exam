import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:so_exam/core/services/client.dart';
import 'package:so_exam/core/services/user_service.dart';

import 'dashboard_controller.dart';

class DashboardViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() => Client.dio);
    Get.lazyPut<UserServiceProtocol>(() => UserService(Get.find()));
    Get.lazyPut<DashboardController>(
        () => DashboardController(userservice: Get.find()));
  }
}
