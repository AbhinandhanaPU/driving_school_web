import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/controller/course_controller/course_controller.dart';
import 'package:new_project_driving/model/practice_shedule_model/practice_shedule_model.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class PracticeSheduleController extends GetxController {
  final courseCtrl = Get.put(CourseController());

  final formKey = GlobalKey<FormState>();

  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  TextEditingController practiceNameController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  RxBool onTapSchedule = false.obs;
  RxString scheduleId = ''.obs;

  Future<void> createPracticeShedule() async {
    final uuid = const Uuid().v1();
    final practicesheduleDetails = PracticeSheduleModel(
        practiceName: practiceNameController.text,
        startTime: startTimeController.text,
        endTime: endTimeController.text,
        practiceId: uuid);
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('PracticeSchedule')
          .doc(practicesheduleDetails.practiceId)
          .set(practicesheduleDetails.toMap())
          .then((value) async {
        practiceNameController.clear();
        startTimeController.clear();
        endTimeController.clear();
        buttonstate.value = ButtonState.success;

        showToast(msg: "PracticeSchedule Created Successfully");
        await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
          buttonstate.value = ButtonState.idle;
        });
      });
    } catch (e) {
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      log("Error .... $e", name: "PracticeSchedule");
    }
  }

  Future<void> updatePractice(String practiceId, BuildContext context) async {
    try {
      server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('PracticeSchedule')
          .doc(practiceId)
          .update({
            'practiceName': practiceNameController.text,
            'startTime': startTimeController.text,
            'endTime': endTimeController.text,
          })
          .then((value) {
            practiceNameController.clear();
            startTimeController.clear();
            endTimeController.clear();
          })
          .then((value) => Navigator.pop(context))
          .then((value) => showToast(msg: 'Practice Updated!'));
    } catch (e) {
      showToast(msg: 'Practice  Updation failed.Try Again');
      log("Practice Updation failed $e");
    }
  }

  Future<void> deletePractice(String practiceId, BuildContext context) async {
    log("noticeId -----------$practiceId");
    server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('PracticeSchedule')
        .doc(practiceId)
        .delete();
  }

  Future<void> addStudent() async {
    try {
      final studentResult = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .doc(courseCtrl.studentDocID.value)
          .get();
      if (courseCtrl.studentDocID.value != '') {
        final data = StudentModel.fromMap(studentResult.data()!);
        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('PracticeSchedule')
            .doc(scheduleId.value)
            .collection('Students')
            .doc(courseCtrl.studentDocID.value)
            .set(data.toMap())
            .then((value) async {
          buttonstate.value = ButtonState.success;
          showToast(msg: "Student added Successfully");
          await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
            buttonstate.value = ButtonState.idle;
          });
        });
      }
    } catch (e) {
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      log("Error .... $e");
    }
  }

  Future<void> deleteStudent({required String docId}) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('PracticeSchedule')
          .doc(scheduleId.value)
          .collection('Students')
          .doc(docId)
          .delete()
          .then((value) {
        showToast(msg: "Deleted Successfully");
        log("Deleted Successfully");
        Get.back();
      });
    } catch (e) {
      log(e.toString(), name: "PracticeSchedule");
    }
  }

  Stream<List<StudentModel>> fetchStudentsWithStatusTrue(String practiseId) {
    return server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('PracticeSchedule')
        .doc(practiseId)
        .collection('Students')
        .snapshots()
        .asyncMap((snapshot) async {
      List<String> studentIds = snapshot.docs.map((doc) => doc.id).toList();

      if (studentIds.isEmpty) return [];

      QuerySnapshot studentSnapshot = await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Students')
          .where('status', isEqualTo: true)
          .where('docid', whereIn: studentIds)
          .get();

      return studentSnapshot.docs
          .map(
              (doc) => StudentModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
