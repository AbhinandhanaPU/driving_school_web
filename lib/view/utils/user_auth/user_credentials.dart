import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/view/model/admin_model/admin_model.dart';
import 'package:new_project_driving/view/model/student_model/student_model.dart';
import 'package:new_project_driving/view/model/teacher_model/teacher_model.dart';
import 'package:new_project_driving/view/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static String batchIdKey = 'batchId';
  static String schoolIdKey = 'schoolId';
  static String schoolNameKey = 'schoolName';
  static String classIdKey = 'classId';
  static String userRoleKey = 'userRole';
  static String userloginKey = 'loginkey';
  static String currentUserDocid = 'currentUserDocid';
  static late SharedPreferences _prefs;

  static Future<void> clearSharedPreferenceData() async {
    await setString(batchIdKey, "");
    await setString(schoolIdKey, "");
    await setString(schoolNameKey, "");
    await setString(classIdKey, "");
    await setString(userRoleKey, "");
    await setString(userloginKey, "");
    await setString(currentUserDocid, "");
  }

  static Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static Future<bool> setString(String key, String value) async {
    final result = await _prefs.setString(key, value);
    return result;
  }

  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  static Future<bool> setInt(String key, int value) async {
    final result = await _prefs.setInt(key, value);

    return result;
  }

  // Add more functions as needed
}

class UserCredentialsController {
  static String? schoolId;
  static String? schoolName;
  static String? batchId;
  static String? classId;
  static String? userRole;
  static String? userloginKey;
  static String? currentUserDocid;
  static StudentModel? studentModel;
  static AdminModel? adminModel;
  static TeacherModel? teacherModel;

  static void clearUserCredentials() {
    schoolId = null;
    schoolName = null;
    batchId = null;
    classId = null;
    userRole = null;
    studentModel = null;
    adminModel = null;
    teacherModel = null;
    userloginKey = null;
    currentUserDocid = null;
  }
}

logoutUser() async {
  await FirebaseAuth.instance.signOut().then((value) async {
    Get.offAll(const SplashScreen());
    await SharedPreferencesHelper.clearSharedPreferenceData();
    UserCredentialsController.clearUserCredentials();
  });
}
