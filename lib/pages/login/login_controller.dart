import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:so_exam/core/services/login_service.dart';
import 'package:so_exam/models/user_login.dart';
import 'package:so_exam/models/user_manager.dart';

class LoginController extends GetxController with StateMixin {
  LoginController({
    required this.loginService,
  });

  LoginServiceProtocol loginService;

  final passwordTextController = TextEditingController();
  final mobilenumberTextController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final userManager = UserManager();
  @override
  void onInit() {
    mobilenumberTextController.text = '09021234567';
    passwordTextController.text = '123456';
    super.onInit();
  }

  Future<UserLoginModel> login(String mobile, String password) async {
    return loginService.login(UserLoginModel.post(mobile, password));
  }
}
