import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/firebase_options.dart';
import 'package:new_project_driving/controller/user_login_Controller/user_login_controller.dart';
import 'package:new_project_driving/view/splash_screen/splash_screen.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferencesHelper.initPrefs();

  runApp(const MyApp());

  Get.put(UserLoginController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        designSize: const Size(1536, 786.4000244140625),
        builder: (context) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              '/spashscreen': (context) => SplashScreen(),
            },
            home: SplashScreen(),
            theme: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              )),
              primarySwatch: Colors.blue,
              dialogTheme: const DialogTheme(
                shape: RoundedRectangleBorder(),
              ),
              datePickerTheme: const DatePickerThemeData(
                shape: RoundedRectangleBorder(),
              ),
            ),
          );
        });
  }
}
//fff//
