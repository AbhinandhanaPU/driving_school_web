import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/constant/constant.validate.dart';
import 'package:new_project_driving/controller/class_controller/class_controller.dart';
import 'package:new_project_driving/model/admin_model/admin_model.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/model/teacher_model/teacher_model.dart';
import 'package:new_project_driving/utils/firebase/errors.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:new_project_driving/view/splash_screen/splash_screen.dart';

class UserLoginController extends GetxController {
  final classCtrl = Get.put(ClassController());
  late AnimationController animationctr;
  late Animation colorAnimation;

  RxBool loginontapped = false.obs;
  RxBool lodingContainer = false.obs;
  RxBool isLoading = RxBool(false);

  RxString userUID = ''.obs;
  final TextEditingController userEmailIDController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();
  String batchID = '';
  late String? schoolID = UserCredentialsController.schoolId;
  late String? schoolName = UserCredentialsController.schoolName;

  Future<bool> secondaryAdminLogin() async {
    //....... .......................................Secondary Admin Login Function
    try {
      await serverAuth
          .signInWithEmailAndPassword(
              email: userEmailIDController.text.trim(),
              password: userPasswordController.text.trim())
          .then((authvalue) async {
        await SharedPreferencesHelper.setString(
            SharedPreferencesHelper.currentUserDocid, authvalue.user!.uid);
        final result = await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Admins')
            .doc(authvalue.user?.uid)
            .get();
        if (result.data() != null) {
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.userRoleKey, 'secondoryAdmin');
          await SharedPreferencesHelper.setString(
                  SharedPreferencesHelper.schoolIdKey, schoolID!)
              // await SharedPreferencesHelper.setString(
              //         SharedPreferencesHelper.schoolNameKey, schoolName!)
              .then((value) async {
            logined.value = true;
            userEmailIDController.clear();
            userPasswordController.clear();

            if (result.data() != null) {
              UserCredentialsController.adminModel =
                  AdminModel.fromMap(result.data()!);
              log(UserCredentialsController.adminModel.toString());
            }
            Get.offAll(() => SplashScreen());
          });
        } else if (result.data() == null) {
          showToast(msg: "Admin login failed");
        } else {
          showToast(msg: "Secondary-Admin login failed");
        }
      }).catchError((error) {
        if (error is FirebaseAuthException) {
          isLoading.value = false;
          handleFirebaseError(error);
        }
      });
    } catch (e) {
      log(e.toString());
      showToast(msg: "Secondary-Admin login failed");
    }
    return true;
  }

  Future<void> adminLoginController(BuildContext context) async {
    loginontapped.value = true;

    //....... ........................................Admin  Login Function
    try {
      await serverAuth
          .signInWithEmailAndPassword(
              email: userEmailIDController.text.trim(),
              password: userPasswordController.text.trim())
          .then((authvalue) async {
        await SharedPreferencesHelper.setString(
            SharedPreferencesHelper.currentUserDocid, authvalue.user!.uid);
        userUID.value = authvalue.user!.uid;
        log("Admin ID $userUID");
        log("schoolID ID $schoolID");

        if (userUID.value == schoolID) {
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.userRoleKey, 'admin');
          await SharedPreferencesHelper.setString(
                  SharedPreferencesHelper.schoolIdKey, schoolID!)
              // await SharedPreferencesHelper.setString(
              //         SharedPreferencesHelper.schoolNameKey, schoolName!)
              .then((value) async {
            log("SchoolID :  ${UserCredentialsController.schoolId}");
            log("userrole :  ${UserCredentialsController.userRole}");
            final user = await server
                .collection('DrivingSchoolCollection')
                .doc(UserCredentialsController.schoolId)
                .get();

            if (user.data() != null) {
              UserCredentialsController.adminModel =
                  AdminModel.fromMap(user.data()!);
              log(UserCredentialsController.adminModel.toString());
            }
            userEmailIDController.clear();
            userPasswordController.clear();
            logined.value = true;
            Get.offAll(() => SplashScreen());
          });
        } else {
          log("trying secondaryAdminLogin");
          await secondaryAdminLogin();
        }
      }).catchError((error) {
        if (error is FirebaseAuthException) {
          isLoading.value = false;
          handleFirebaseError(error);
        }
      });
    } catch (e) {
      log(e.toString());
      showToast(msg: "School Login failed !!");
    }
  }

  Future<void> studentLoginController(BuildContext context) async {
    //....... ........................................Student  Login Function
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: userEmailIDController.text.trim(),
        password: userPasswordController.text.trim(),
      )
          .then((value) async {
        final user = await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Students')
            .doc(value.user?.uid)
            .get();

        if (user.data() != null) {
          UserCredentialsController.studentModel =
              StudentModel.fromMap(user.data()!);
          log(UserCredentialsController.studentModel.toString());
        }

        if (UserCredentialsController.studentModel?.userRole == "student") {
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.userRoleKey, 'student');
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.schoolIdKey, schoolID!);
          // await SharedPreferencesHelper.setString(
          //     SharedPreferencesHelper.schoolNameKey, schoolName!);
          if (context.mounted) {
            logined.value = true;
            userEmailIDController.clear();
            userPasswordController.clear();
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return SplashScreen();
            }), (route) => false);
          }
          isLoading.value = false;
        } else {
          showToast(msg: "You are not a student");
          isLoading.value = false;
        }
      }).catchError((error) {
        if (error is FirebaseAuthException) {
          isLoading.value = false;
          handleFirebaseError(error);
        }
      });
    } catch (e) {
      isLoading.value = false;
      // showToast(msg: e.toString());
      showToast(msg: "Sign in failed");
    }
  }

  Future<void> teachereLoginController(BuildContext context) async {
    //....... ........................................parent  Login Function

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: userEmailIDController.text.trim(),
        password: userPasswordController.text.trim(),
      )
          .then((value) async {
        final user = await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Teachers')
            .doc(value.user?.uid)
            .get();

        if (user.data() != null) {
          UserCredentialsController.teacherModel =
              TeacherModel.fromMap(user.data()!);
          log(UserCredentialsController.teacherModel.toString());
        }

        if (UserCredentialsController.teacherModel?.userRole == "teacher") {
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.userRoleKey, 'teacher');
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.schoolIdKey, schoolID!);
          // await SharedPreferencesHelper.setString(
          //     SharedPreferencesHelper.schoolNameKey, schoolName!);
          if (context.mounted) {
            logined.value = true;
            userEmailIDController.clear();
            userPasswordController.clear();
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return SplashScreen();
            }), (route) => false);
          }
          isLoading.value = false;
        } else {
          showToast(msg: "You are not a teacher");
          isLoading.value = false;
        }
      }).catchError((error) {
        if (error is FirebaseAuthException) {
          isLoading.value = false;
          handleFirebaseError(error);
        }
      });
    } catch (e) {
      isLoading.value = false;
      // showToast(msg: e.toString());
      showToast(msg: "Sign in failed");
    }
  }

  RxString loginData = ''.obs;
  RxBool logined = false.obs;
  Future<void> loginSaveData() async {
    try {
      log("***************loginSaveData*************************");
      log("Sherf P schhol ID ${UserCredentialsController.schoolId}");
      // log(" Local School Id  $schoolID");
      final date = DateTime.now();
      DateTime parseDate = DateTime.parse(date.toString());
      final month = DateFormat('MMMM-yyyy');
      String monthwise = month.format(parseDate);
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formatted = formatter.format(parseDate);

      final String docid = uuid.v1();
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection("LoginHistory")
          .doc(monthwise)
          .set({
        'docid': monthwise,
      }).then((value) async {
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection("LoginHistory")
            .doc(monthwise)
            .collection(monthwise)
            .doc(formatted)
            .set({'docid': formatted}).then((value) async {
          loginData.value = docid;
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.userloginKey, loginData.value);

          log("LOG IN KEY ::::: ${loginData.value}");
          await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection("LoginHistory")
              .doc(monthwise)
              .collection(monthwise)
              .doc(formatted)
              .collection(formatted)
              .doc(docid)
              .set({
            'docid': docid,
            'loginTime': DateTime.now().toString(),
            'logoutTime': '',
            'adminuserName': FirebaseAuth.instance.currentUser?.email,
            'adminID': FirebaseAuth.instance.currentUser?.uid
          }, SetOptions(merge: true));
        });
      });
      logined.value = false;
    } catch (e) {
      print("loginSaveData $e ");
    }
  }

  Future<void> logoutSaveData() async {
    log('logout Key${UserCredentialsController.userloginKey}');
    final date = DateTime.now();
    DateTime parseDate = DateTime.parse(date.toString());
    final month = DateFormat('MMMM-yyyy');
    String monthwise = month.format(parseDate);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formatted = formatter.format(parseDate);
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        // .collection(UserCredentialsController.batchId!)
        // .doc(UserCredentialsController.batchId)
        .collection("LoginHistory")
        .doc(monthwise)
        .collection(monthwise)
        .doc(formatted)
        .collection(formatted)
        .doc(UserCredentialsController.userloginKey)
        .set({
      'docid': UserCredentialsController.userloginKey,
      'logoutTime': DateTime.now().toString(),
      'adminuserName': FirebaseAuth.instance.currentUser?.email,
      'adminID': FirebaseAuth.instance.currentUser?.uid
    }, SetOptions(merge: true));
  }
}
