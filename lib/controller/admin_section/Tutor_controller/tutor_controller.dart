import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/model/teacher_model/teacher_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';
import 'package:progress_state_button/progress_button.dart';

class TutorController extends GetxController {
  TextEditingController tutorNameController = TextEditingController();
  TextEditingController tutorPhoneNumeber = TextEditingController();
  TextEditingController tutorEmailController = TextEditingController();
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;
  final Rx<String> dateofbithController = ''.obs;
  final Rx<String> gender = ''.obs;
  final Rx<String> subject = ''.obs;
  final Rxn<DateTime> selectedDOB = Rxn<DateTime>();
  RxBool ontapTutor = false.obs;
  RxString dobSelectedDate = ''.obs;
  RxString joiningSelectedDate = ''.obs;
  RxBool ontapviewTutor = false.obs;
  RxBool tutorEditDetail = false.obs;
  Rxn<TeacherModel> tutorModelData = Rxn<TeacherModel>();
  final formKey = GlobalKey<FormState>();

//......................  Add teacher Section

  RxBool automaticmail = false.obs;

  final _firebase = server
      .collection('DrivingSchoolCollection')
      .doc(UserCredentialsController.schoolId);

  Future<void> createNewTutor(TeacherModel teacherModel) async {
    buttonstate.value = ButtonState.loading;
    try {
      await _firebase
          .collection('TempTeacherList')
          .add(teacherModel.toMap())
          .then((value) async {
        await _firebase
            .collection('TempTeacherList')
            .doc(value.id)
            .update({"docid": value.id}).then(
          (value) {
            showToast(msg: "Successfully Created");
            clearFields();
          },
        );
      });
      buttonstate.value = ButtonState.success;
      await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
        buttonstate.value = ButtonState.idle;
      });
    } catch (e) {
      showToast(msg: "Teacher Creation Failed");
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      log("Error .... $e");
    }
  }

  Future<void> deleteTutor(TeacherModel teacherModel) async {
    try {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Teachers')
          .doc(teacherModel.docid)
          .delete()
          .then((value) => log("Tutor deleted"));
    } catch (e) {
      log("Tutor deletion error:$e");
    }
  }

  void clearFields() {
    tutorNameController.clear();
    tutorPhoneNumeber.clear();
    tutorEmailController.clear();
  }
}