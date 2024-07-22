import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class TestController extends GetxController {
  RxBool onTapTest = false.obs;
  final formKey = GlobalKey<FormState>();
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  TextEditingController testDateController = TextEditingController();
  TextEditingController testTimeController = TextEditingController();
  TextEditingController testLocationController = TextEditingController();

  TextEditingController testDateEditController = TextEditingController();
  TextEditingController testTimeEditController = TextEditingController();
  TextEditingController testLocationEditController = TextEditingController();

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

    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('DrivingTest')
          .doc(uuid)
          .set({
        'testDate': testDateController.text,
        'testTime': testTimeController.text,
        'location': testLocationController.text,
        'docId': uuid,
      }).then((value) async {
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
}
