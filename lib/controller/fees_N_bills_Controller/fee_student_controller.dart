import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/controller/fees_N_bills_Controller/fees_bills_controller.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';

class StudentFeeController extends GetxController {
  final RxMap<String, dynamic> studentdata = {'': ''}.obs;
  TextEditingController updateFeeController = TextEditingController();
  RxInt totalStudentFee = 0.obs;
  RxInt paidStudentFee = 0.obs;
  RxInt unpaidStudentFee = 0.obs;

  Future<void> feeEditController(
    String studentID,
    bool status,
  ) async {
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('FeesCollection')
        .doc(Get.find<FeesAndBillsController>().feeMonthData.value)
        .collection(Get.find<FeesAndBillsController>().feeMonthData.value)
        .doc(Get.find<FeesAndBillsController>().feeDateData.value)
        .collection('Students')
        .doc(studentID)
        .update({
      "editFee": status,
    }).then((value) async {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('FeesCollection')
          .doc(Get.find<FeesAndBillsController>().feeMonthData.value)
          .collection(Get.find<FeesAndBillsController>().feeMonthData.value)
          .doc(Get.find<FeesAndBillsController>().feeDateData.value)
          .collection('Students')
          .doc(studentID)
          .get()
          .then((value) async {
        if (value.data()!['feepaid'] == true) {
          await server
              .collection('DrivingSchoolCollection')
              .doc(UserCredentialsController.schoolId)
              .collection('FeesCollection')
              .doc(Get.find<FeesAndBillsController>().feeMonthData.value)
              .collection(Get.find<FeesAndBillsController>().feeMonthData.value)
              .doc(Get.find<FeesAndBillsController>().feeDateData.value)
              .collection('Students')
              .doc(studentID)
              .update({'paid': value.data()!['fee']});
        }
      });
    });
  }

  Future<void> updateStudentFeeInFeeBill(String studentID) async {
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('FeesCollection')
        .doc(Get.find<FeesAndBillsController>().feeMonthData.value)
        .collection(Get.find<FeesAndBillsController>().feeMonthData.value)
        .doc(Get.find<FeesAndBillsController>().feeDateData.value)
        .collection('Students')
        .doc(studentID)
        .update({'fee': int.parse(updateFeeController.text.trim())}).then(
            (value) => feeEditController(studentID, false));
  }

  Future<void> updateStudentFeeStatus(
      String studentID, bool status, int fee) async {
    log("Fee Month ${Get.find<FeesAndBillsController>().feeMonthData.value}");
    log("Fee Docid  ${Get.find<FeesAndBillsController>().feeDateData.value}");
    log("Student ID  $studentID");
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('FeesCollection')
        .doc(Get.find<FeesAndBillsController>().feeMonthData.value)
        .collection(Get.find<FeesAndBillsController>().feeMonthData.value)
        .doc(Get.find<FeesAndBillsController>().feeDateData.value)
        .collection('Students')
        .doc(studentID)
        .update({'feepaid': status, 'paid': fee});
  }

  getStudentFeeDetails(String studentId) async {
    // print('fee start');
    // print(studentId);
    // print(Get.find<FeesAndBillsController>().feeMonthData.value);
    // print(Get.find<FeesAndBillsController>().feeDateData.value);
    final studentFeeData = await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('FeesCollection')
        .doc(Get.find<FeesAndBillsController>().feeMonthData.value)
        .collection(Get.find<FeesAndBillsController>().feeMonthData.value)
        .doc(Get.find<FeesAndBillsController>().feeDateData.value)
        .collection('Students')
        .doc(studentId)
        .get();

    totalStudentFee.value = studentFeeData.data()!['fee'];
    paidStudentFee.value = studentFeeData.data()!['paid'];
    unpaidStudentFee.value = totalStudentFee.value - paidStudentFee.value;

    log(totalStudentFee.value.toString());
  }
}
