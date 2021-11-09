import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:so_exam/models/user_manager.dart';

import 'core/app.dart';
import 'pages/splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _userManager = UserManager();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userManager.preloadCachedLogin(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: ErrorSplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        } else {
          final isLoggedIn = snapshot.data as bool;
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute:
                isLoggedIn ? AppRoutes.dashboard.value : AppRoutes.login.value,
            getPages: App.pages,
            builder: EasyLoading.init(builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child ?? const SizedBox(),
              );
            }),
          );
        }
      },
    );
  }
}
