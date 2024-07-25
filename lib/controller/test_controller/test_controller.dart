import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/controller/course_controller/course_controller.dart';
import 'package:new_project_driving/model/test_model/test_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class TestController extends GetxController {
  final courseCtrl = Get.put(CourseController());
  RxBool onTapTest = false.obs;
  final formKey = GlobalKey<FormState>();
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  TextEditingController testDateController = TextEditingController();
  TextEditingController testTimeController = TextEditingController();
  TextEditingController testLocationController = TextEditingController();

  TextEditingController testDateEditController = TextEditingController();
  TextEditingController testTimeEditController = TextEditingController();
  TextEditingController testLocationEditController = TextEditingController();

  
  Rxn<TestModel> testModelData = Rxn<TestModel>();
  RxString docId = ''.obs;
  
 

  clearFields() {
    testDateController.clear();
    testTimeController.clear();
    testLocationController.clear();

    testDateEditController.clear();
    testTimeEditController.clear();
    testLocationEditController.clear();
  }

  Future<void> addTestDate() async {
    final uuid = const Uuid().v1();
     final testDetails = TestModel(
      testDate: testDateController.text, 
      testTime: testTimeController.text, 
      location: testLocationController.text, 
      docId: uuid);

    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('DrivingTest')
          .doc( testDetails.docId)
          .set(testDetails.toMap()
      //       {
      //   'testDate': testDateController.text,
      //   'testTime': testTimeController.text,
      //   'location': testLocationController.text,
      //   'docId': uuid,
      // }
      )
      .then((value) async {
        clearFields();
        buttonstate.value = ButtonState.success;

        showToast(msg: "Driving Created Successfully");
        await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
          buttonstate.value = ButtonState.idle;
        });
      });
    } catch (e) {
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      log("Error .... $e");
    }
  }

  Future<void> editTest(String docId, BuildContext context) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('DrivingTest')
          .doc(docId)
          .update({
            'testDate': testDateEditController.text,
            'testTime': testTimeEditController.text,
            'location': testLocationEditController.text,
          })
          .then((value) {
            clearFields();
          })
          .then((value) => Navigator.pop(context))
          .then((value) => showToast(msg: 'test details Updated!'));
    } catch (e) {
      showToast(msg: 'test details  Updation failed.Try Again');
      log("test details Updation failed $e");
    }
  }

  Future<void> deleteTest({required String docId}) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('DrivingTest')
          .doc(docId)
          .delete()
          .then((value) {
        showToast(msg: "Deleted Successfully");
        log("Deleted Successfully");
        Get.back();
      });
    } catch (e) {
      log(e.toString(), name: "TestController");
    }
  }

  Future<void> addStudent(String textID) async {
    final uuid = const Uuid().v1();
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('DrivingTest')
          .doc(textID)
          .collection('Students')
          .doc(uuid)
          .set({
        'studentDocId': courseCtrl.studentDocID.value,
        'studentName': courseCtrl.studentName.value,
        'docId': uuid,
      }).then((value) async {
        clearFields();
        buttonstate.value = ButtonState.success;

        showToast(msg: "Student added Successfully");
        await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
          buttonstate.value = ButtonState.idle;
        });
      });
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
      final docidoftest= await server
           .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection("DrivingTest")
          .get();

  if (docidoftest.docs.isNotEmpty) {
      for (var testDoc in docidoftest.docs) {
        final testDocid = testDoc.id;
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('DrivingTest')
          .doc(testDocid)
          .collection('Students')
          .doc(docId)
          .delete()
          .then((value) {
        showToast(msg: "Deleted Successfully");
        log("Deleted Successfully");
        Get.back();
      });
     }
    } else {
      log("No Test found");
    }
    } catch (e) {
      log("Student deletion error:$e");
    }
  }
}
