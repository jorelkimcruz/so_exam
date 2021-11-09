import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:so_exam/models/user_login.dart';

class UserManager {
  factory UserManager() {
    return _singleton;
  }

  UserManager._internal();

  static final UserManager _singleton = UserManager._internal();

  FlutterSecureStorage storage = const FlutterSecureStorage();
  static const _cachedLogin = '_cachedLoginInSecureSrorage';

  Future<void> cacheLogin(UserLoginModel loginmodel) async {
    final String str = json.encode(loginmodel);
    return storage.write(key: _cachedLogin, value: str);
  }

  UserLoginModel? currentUser;

  Future<bool> preloadCachedLogin() async {
    final Map<String, String>? result = await storage.readAll();

    if (result != null) {
      final String? loginValueString = result[_cachedLogin];
      if (loginValueString != null) {
        final Map<String, dynamic>? data =
            json.decode(loginValueString) as Map<String, dynamic>;

        currentUser = (data != null) ? UserLoginModel.fromJson(data) : null;
        final expireDate = DateTime.parse(
          currentUser!.data!.expiresAt!,
        );
        return DateTime.now().isBefore(expireDate);
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
