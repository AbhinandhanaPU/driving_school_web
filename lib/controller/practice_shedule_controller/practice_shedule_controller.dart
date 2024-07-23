import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/model/practice_shedule_model/practice_shedule_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class PracticeSheduleController extends GetxController {
  final formKey = GlobalKey<FormState>();

  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  TextEditingController practiceNameController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

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
}
