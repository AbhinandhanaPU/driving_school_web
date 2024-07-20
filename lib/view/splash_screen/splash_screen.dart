import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/controller/school_controller/school_controller.dart';
import 'package:new_project_driving/controller/user_auth/user_auth_controller.dart';
import 'package:new_project_driving/controller/user_login_Controller/user_login_controller.dart';
import 'package:new_project_driving/fonts/google_monstre.dart';
import 'package:new_project_driving/info/info.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';

class SplashScreen extends StatelessWidget {
  final UserAuthController userLoginController = Get.put(UserAuthController());
  final SchoolController schoolController = Get.put(SchoolController());

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (userLoginController.loginAuthState.value == true) {
      log("****************TRUE");
      log("Get.find<UserLoginController>().logined.value ${Get.find<UserLoginController>().logined.value}");
      Get.put(UserLoginController());
    }
    if (UserCredentialsController.schoolId == null) {
      schoolController.fetchAllSchoolData();
    }
    nextpage();
    return Scaffold(
      backgroundColor: cWhite,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AnimationConfiguration.staggeredGrid(
              position: 1,
              duration: const Duration(milliseconds: 4000),
              columnCount: 3,
              child: ScaleAnimation(
                duration: const Duration(milliseconds: 900),
                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  child: Container(
                    height: 220.h,
                    width: 220.w,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(
                        logoImage,
                      ),
                    )),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: AnimationConfiguration.staggeredGrid(
              position: 2,
              duration: const Duration(milliseconds: 4000),
              columnCount: 3,
              child: ScaleAnimation(
                duration: const Duration(milliseconds: 900),
                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GoogleMonstserratWidgets(
                        text: separate,
                        fontsize: ResponsiveWebSite.isMobile(context)?20: 25,
                        color: const Color.fromARGB(255, 230, 18, 3),
                        fontWeight: FontWeight.bold,
                      ),
                      GoogleMonstserratWidgets(
                        text: separatetwo,
                        fontsize: ResponsiveWebSite.isMobile(context)?20:25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  nextpage() async {
    Future.delayed(const Duration(seconds: 3))
        .then((value) => userLoginController.checkSavedLoginAuth());
  }
}
