import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_driving/constant/const.dart';
import 'package:new_project_driving/model/course_model/course_model.dart';
import 'package:new_project_driving/model/student_model/student_model.dart';
import 'package:new_project_driving/utils/firebase/firebase.dart';
import 'package:new_project_driving/utils/user_auth/user_credentials.dart';

class FeeController extends GetxController {
  RxBool onTapBtach = false.obs;
  RxString batchId = ''.obs;
  Rx<bool> onTapUnpaid = Rx<bool>(false);

  final formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();

  final _fbServer =
      server.collection('DrivingSchoolCollection').doc(UserCredentialsController.schoolId);

  addStudentfeeFullyPaid(
    StudentModel studentModel,
    String status,
    CourseModel course,
  ) async {
    DocumentSnapshot batchDoc =
        await _fbServer.collection('FeesCollection').doc(studentModel.batchId).get();

    if (!batchDoc.exists) {
      await _fbServer.collection('FeesCollection').doc(studentModel.batchId).set({
        'batchId': studentModel.batchId,
      });
    }
    DocumentSnapshot courseDoc = await _fbServer
        .collection('FeesCollection')
        .doc(studentModel.batchId)
        .collection('Courses')
        .doc(course.courseId)
        .get();

    if (!courseDoc.exists) {
      await _fbServer
          .collection('FeesCollection')
          .doc(studentModel.batchId)
          .collection('Courses')
          .doc(course.courseId)
          .set({
        'courseId': course.courseId,
      });
    }
    await _fbServer
        .collection('FeesCollection')
        .doc(studentModel.batchId)
        .collection('Courses')
        .doc(course.courseId)
        .collection('Students')
        .doc(studentModel.docid)
        .set({
      'studentName': studentModel.studentName,
      'studentID': studentModel.docid,
      'feeStatus': status,
      'amountPaid': course.rate,
      'totalAmount': course.rate,
      'paidStatus': true
    }).then((value) async {
      await getFeeTotalAmount(course.courseId, studentModel.batchId, course.rate);
      await pendingAmountCalculate(course.courseId, studentModel.batchId);
      await acceptStudentToCourse(studentModel, status, course.courseId);
      showToast(msg: 'Student fees updated');
      log("Fees Status Updated");
    });
  }

  Future<void> addStudentFeeColl(
    StudentModel studentModel,
    String status,
    CourseModel course,
  ) async {
    try {
      int amountPaid = int.tryParse(amountController.text) ?? 0;
      DocumentSnapshot batchDoc =
          await _fbServer.collection('FeesCollection').doc(studentModel.batchId).get();

      if (!batchDoc.exists) {
        await _fbServer.collection('FeesCollection').doc(studentModel.batchId).set({
          'batchId': studentModel.batchId,
        });
      }
      DocumentSnapshot courseDoc = await _fbServer
          .collection('FeesCollection')
          .doc(studentModel.batchId)
          .collection('Courses')
          .doc(course.courseId)
          .get();

      if (!courseDoc.exists) {
        await _fbServer
            .collection('FeesCollection')
            .doc(studentModel.batchId)
            .collection('Courses')
            .doc(course.courseId)
            .set({
          'courseId': course.courseId,
        });
      }
      DocumentSnapshot studentDoc = await _fbServer
          .collection('FeesCollection')
          .doc(studentModel.batchId)
          .collection('Courses')
          .doc(course.courseId)
          .collection('Students')
          .doc(studentModel.docid)
          .get();

      if (studentDoc.exists && studentDoc['amountPaid'] != course.rate) {
        await _fbServer
            .collection('FeesCollection')
            .doc(studentModel.batchId)
            .collection('Courses')
            .doc(course.courseId)
            .collection('Students')
            .doc(studentModel.docid)
            .update({
          'feeStatus': status,
          'amountPaid': FieldValue.increment(amountPaid),
          'paidStatus': false
        });
      } else {
        await _fbServer
            .collection('FeesCollection')
            .doc(studentModel.batchId)
            .collection('Courses')
            .doc(course.courseId)
            .collection('Students')
            .doc(studentModel.docid)
            .set({
          'studentName': studentModel.studentName,
          'studentID': studentModel.docid,
          'feeStatus': status,
          'amountPaid': amountPaid,
          'totalAmount': course.rate,
          'paidStatus': false,
        });
      }
      await getFeeTotalAmount(course.courseId, studentModel.batchId, course.rate);
      await pendingAmountCalculate(course.courseId, studentModel.batchId);
      await acceptStudentToCourse(studentModel, status, course.courseId);

      amountController.clear();
      update();
      showToast(msg: 'Student fees updated');
      log("Fees Status Updated");
    } catch (e) {
      log("FeesCollection error: $e");
    }
  }

  Future<void> acceptStudentToCourse(
    StudentModel studentModel,
    String status,
    String courseID,
  ) async {
    try {
      final reqStudentDoc = await _fbServer
          .collection('Courses')
          .doc(courseID)
          .collection("RequestedStudents")
          .doc(studentModel.docid)
          .get();

      if (reqStudentDoc.exists) {
        await reqStudentDoc.reference.delete();
        await _fbServer
            .collection('Courses')
            .doc(courseID)
            .collection("Students")
            .doc(studentModel.docid)
            .set(studentModel.toMap());
        showToast(msg: 'Student Added to Course');
        log("Student accepted and Added to the course.");
      } else {
        log("Student not found in RequestedStudents collection.");
      }
    } catch (e) {
      log("Students approval error: $e");
    }
  }

  Future<void> declineStudentToCourse(
    StudentModel studentModel,
    String courseID,
  ) async {
    try {
      final reqStudentDoc = await _fbServer
          .collection('Courses')
          .doc(courseID)
          .collection("RequestedStudents")
          .doc(studentModel.docid)
          .get();

      if (reqStudentDoc.exists) {
        await reqStudentDoc.reference.delete();
        showToast(msg: 'Student request declined');
        log("Student request declined");
      } else {
        log("Student not found in RequestedStudents collection.");
      }
    } catch (e) {
      log("Students approval error: $e");
    }
  }

  Future<void> getFeeTotalAmount(
    String courseId,
    String batchId,
    int fee,
  ) async {
    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('FeesCollection')
        .doc(batchId)
        .collection('Courses')
        .doc(courseId)
        .collection('Students')
        .get()
        .then((value) async {
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('FeesCollection')
          .doc(batchId)
          .collection('Courses')
          .doc(courseId)
          .set({
        'totalStudents': value.docs.length,
        'totalAmount': fee * value.docs.length,
      }, SetOptions(merge: true));
      log('Total studnets and amount added');
    });
  }

  Future<void> pendingAmountCalculate(String courseID, String batchId) async {
    int paidFee = 0;
    int studenttotalAmount = 0;

    await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('FeesCollection')
        .doc(batchId)
        .collection('Courses')
        .doc(courseID)
        .collection('Students')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        final int totaladdesult = value.docs[i].data()['amountPaid'];
        studenttotalAmount = studenttotalAmount + totaladdesult;
      }

      paidFee = studenttotalAmount;
      await server
          .collection('DrivingSchoolCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('FeesCollection')
          .doc(batchId)
          .collection('Courses')
          .doc(courseID)
          .get()
          .then((value) async {
        int totalAmount = value.data()?['totalAmount'] ?? 0;
        int result = totalAmount - paidFee;

        await server
            .collection('DrivingSchoolCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('FeesCollection')
            .doc(batchId)
            .collection('Courses')
            .doc(courseID)
            .update({
          'pendingAmount': result,
          'amountCollected': paidFee,
        });
        log('Pending amount added');
      });
    });
  }
}
