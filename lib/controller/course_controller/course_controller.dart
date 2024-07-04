import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/model/course_model/course_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class CourseController extends GetxController {
  final formKey = GlobalKey<FormState>();
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseDesController = TextEditingController();
  TextEditingController courseDurationController = TextEditingController();
  TextEditingController courseRateController = TextEditingController();

  TextEditingController courseEditNameController = TextEditingController();
  TextEditingController courseEditDesController = TextEditingController();
  TextEditingController courseEditDurationController = TextEditingController();
  TextEditingController courseEditRateController = TextEditingController();

  clearFields() {
    courseEditNameController.clear();
    courseDesController.clear();
    courseDurationController.clear();
    courseRateController.clear();

    courseEditNameController.clear();
    courseEditDesController.clear();
    courseEditDurationController.clear();
    courseEditRateController.clear();
  }

  Future<void> createCourses() async {
    log("Creating Course .....");
    final uuid = const Uuid().v1();
    final courseDetails = CourseModel(
        courseName: courseEditNameController.text,
        courseDes: courseDesController.text,
        duration: courseDurationController.text,
        rate: courseRateController.text,
        courseId: uuid);

    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Courses')
          .doc(courseDetails.courseId)
          .set(courseDetails.toMap())
          .then((value) async {
        clearFields();
        buttonstate.value = ButtonState.success;
        showToast(msg: "Courses Created Successfully");
        await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
          buttonstate.value = ButtonState.idle;
        });
      });
    } catch (e) {
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      log("Courses Creation Error .... $e");
    }
  }

  Future<void> deleteCourse(String courseId) async {
    log("courseId -----------$courseId");
    try {
      server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Courses')
          .doc(courseId)
          .delete()
          .then((value) {
        showToast(msg: "Courses deleted Successfully");
      });
    } catch (e) {
      log("Courses delete$e");
    }
  }

  Future<void> updateCourse(String courseId, BuildContext context) async {
    try {
      server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Courses')
          .doc(courseId)
          .update({
            'courseName': courseEditNameController.text,
            'courseDes': courseEditDesController.text,
            'duration': courseEditDurationController.text,
            'rate': courseEditRateController.text,
          })
          .then((value) {})
          .then((value) => Navigator.pop(context))
          .then((value) => showToast(msg: 'Courses Updated!'));
    } catch (e) {
      showToast(msg: 'Courses  Updation failed.Try Again');
      log("Courses Updation failed $e");
    }
  }
}
