import 'package:dio/dio.dart';
import 'package:so_exam/models/user_login.dart';
import 'package:so_exam/models/user_manager.dart';

class RequestInterceptor extends InterceptorsWrapper {
  RequestInterceptor();

  final UserManager _userManager = UserManager();
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final UserLoginModel? login = _userManager.currentUser;
    if (login != null && login.data != null) {
      if (login.data!.accessToken != null) {
        options.headers['Authorization'] = login.data!.accessToken!;
      }
    }
    super.onRequest(options, handler);
  }
}
