import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:so_exam/core/services/client.dart';
import 'package:so_exam/core/services/login_service.dart';
import 'login_controller.dart';

class LoginViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() => Client.dio);
    Get.lazyPut<LoginController>(() => LoginController(
            loginService: LoginService(
          Get.find(),
        )));
  }
}
